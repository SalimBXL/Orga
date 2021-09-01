class ToolsController < ApplicationController
    before_action :read_konfig, only: [:backup_db]

    # ACCUEIL
    def index
        # Log action
        log(request.path)
    end


    ###########
    # EXPORTS #
    ###########
    def exports
        
    end


    ##############
    # CHECK DAYS #
    ##############
    def check_days
        @problemes = Array.new
        @problemes_batchs = Array.new
        tmp_batch_par_jour = Hash.new

        # on fait la liste des days
        jours = Jour.all

        # pour chaque day...
        if jours
            jours.each do |jour|

                tmp_batch_par_jour[jour.date] ||= Hash.new
                tmp_batch_par_jour[jour.date][jour.utilisateur_id] ||= 0

                # on vérifie s'il y a au moins une working_list
                working_lists = jour.working_lists
                @problemes << jour if working_lists.count <1

                # on vérifie s'il n'y a pas plus de deux batch
                tmp_batch_par_jour[jour.date][jour.utilisateur_id] += 1
                @problemes_batchs << jour if tmp_batch_par_jour[jour.date][jour.utilisateur_id] > 2

            end
        end
    end


    ################
    # CHECK ADMINS #
    ################
    def check_admins
        @managers = Array.new
        @super_admins = Array.new
        @problems = Array.new
        Utilisateur.all.each do |utilisateur|
            @managers << utilisateur if utilisateur.admin and !utilisateur.profil.admin
            @super_admins << utilisateur if utilisateur.admin and utilisateur.profil.admin
            @problems << utilisateur if !utilisateur.admin and utilisateur.profil.admin
        end
    end


    ##############
    # BACK UP DB #
    ##############
    def backup_db
        current_directory = Dir.pwd
        @current_directory = File.join(current_directory, "backup")
        @old_name = "backup.tar"
        @new_name = "_backup.tar"
        @old_archive_size = 0
        @new_archive_size = 0
        @remove_status = false
        @rename_status = false
        @command_status = false
        @size_status = false
        @old_backup_exists = false
        @backup_exists = false

        #pp "***** Remove old backup *****"
        @remove_status = remove_old_backup
        #pp "***** Rename previous backup *****"
        @rename_status = rename_previous_backup
        #pp "***** Create archive TAR *****"
        tmp = create_archive
        @command_status = (tmp == true) ? true : false
        @command_message = @command_status ? nil : tmp

        #pp "***** Check archive size *****"
        @size_status = check_archive_size
    end

    def download_backup
        backup = params[:backup]
        if backup
            mnt = (Time.now).to_s.gsub(" ", "_")
            send_file(
                "#{backup}",
                filename: "#{mnt}_#{File.basename(backup)}",
                type: "application/tar"
            )
        end
    end


    ###############
    # CHECK USERS #
    ###############
    def check_users
        @problemes = Hash.new
        emails = Array.new
        @pas_profil_utilisateur = Array.new
        @pas_profil_connection = Array.new
        

        # on fait la liste des utilisateurs et des profils de login
        @utilisateurs = Utilisateur.all
        if @utilisateurs
            @utilisateurs.each do |utilisateur|
                emails << utilisateur.email
                @problemes[utilisateur.email] ||= Hash.new
                @problemes[utilisateur.email]["utilisateur"] = utilisateur
            end
        end

        @profiles = User.all
        if @profiles
            @profiles.each do |profile|
                emails << profile.email
                @problemes[profile.email] ||= Hash.new
                @problemes[profile.email]["profile"] = profile
            end
        end

        # pour chaque utilisateur, on vérifie s'il y a au moins un profil
        emails.each do |email|
            if (@problemes[email]["utilisateur"] and @problemes[email]["profile"])
                # Ok, on a deux profils : connection et utilisateur
            else
                # Problème, il manque un des deux profils...

                if (@problemes[email]["utilisateur"] and @problemes[email]["profile"].nil?)
                    # On a un profil utilisateur mais pas de connection
                    @pas_profil_connection << email
                end
                if (@problemes[email]["utilisateur"].nil? and @problemes[email]["profile"])
                    # On a un profil de connection mais pas de profil utilisateur
                    @pas_profil_utilisateur << email
                end
            end
        end
    end


    #################
    #   STATISTICS  #
    #################
    def statistics

        @works = nil

        
        unless params[:work].blank?

            # Trouve les Works de la base
            @works = Work.where(id: params[:work])
        
            # Trouve la plage de dates
            @date_job_futur = Jour.order(:date).last.date
            @date_job_past = @date_job_futur - 1.year

            # Trouve les Jours qui ont été programmés dans l'intervalle de dates
            jours = Jour.where("date::date >= ?", @date_job_past).order(:utilisateur_id)

            # Trie les jours par utilisateur
            @jours = Hash.new
            jours.each do |jour|
                # Liste des WorkingLists par Jour
                if params[:work].blank?
                    liste = WorkingList.where(jour_id: jour.id)
                else
                    liste = WorkingList.where(jour_id: jour.id, work_id: params[:work])
                end
                liste.each do |wl|
                    @jours[jour.utilisateur] ||= Hash.new
                    @jours[jour.utilisateur][wl.work] ||= 0
                    @jours[jour.utilisateur][wl.work] = @jours[jour.utilisateur][wl.work] + 1
                end
            end
        end    
    end


    # ###############################################################################

    private 


    def remove_old_backup
        @old_backup = File.join(@current_directory, @new_name)
        old_backup_glob = Dir.glob(@old_backup)
        @old_backup_exists = old_backup_glob.size == 1 ? true : false
        # Si l'ancien backup n'existe pas...
            return true unless @old_backup_exists
        # Si l'ancien backup trouvé n'est pas un fichier...
            return true if File.directory?(old_backup_glob.first)
        # Supprime l'ancien backup
            @remove_command = "rm -rf #{@old_backup}"
            retour = File.delete(@old_backup)
            #retour = nil
            return true if retour == 1
        remove_old_backup = false
    end


    def rename_previous_backup
        @backup = File.join(@current_directory, @old_name)
        backup_glob = Dir.glob(@backup)
        @backup_exists = backup_glob.size == 1 ? true : false
        # Si le backup n'existe pas...
            return true unless @backup_exists
        # Si le backup trouvé n'est pas un fichier...
            return true if File.directory?(backup_glob.first)
        # Renomme le backup
            @rename_command = "mv #{@backup} #{@old_backup}"
            #retour = nil
            retour = File.rename(@backup, @old_backup)
            return true if retour == 0
        rename_previous_backup = false
    end


    def create_archive
        # Ligne OVH
        #@tar_command = "pg_dump 'host=localhost port=5432 dbname=MyDataBase_development user=orga password=orga' -Ft  > #{@backup}"
        @tar_command = @konfiguration[:tools_backup_db_tar_command] ? "#{@konfiguration[:tools_backup_db_tar_command]} > #{@backup}" : "pg_dump 'host=localhost port=5432 dbname=MyDataBase_development user=orga password=orga' -Ft > #{@backup}"

        #Ligne localhost
        #@tar_command = "pg_dump 'dbname=orga_development user=salim' -Ft  > #{@backup}"
        
        #retour = IO.popen(@tar_command, in: :in)
        retour = IO.popen(@tar_command, :err=>[:child, :out])
        msg = retour.readlines
        retour.close
        boucle_temporelle
        create_archive = (File.exist?(@backup) and $?.success?) ? true : msg
    end


    def boucle_temporelle
        #time = 5    # Cinq secondes
        time = @konfiguration[:tools_backup_db_loop_length] ? "#{@konfiguration[:tools_backup_db_loop_length]}".to_i : 5

        time_start = Time.now
        begin      
            time_running = Time.now - time_start
            # Boucle temporelle qui laisse le temps au système de créer l'archive.
            tri = time_running.to_i
        end until (tri >= time)
    end


    def check_archive_size
        @old_archive_size = File.size?(@old_backup)
        @new_archive_size = File.size?(@backup)
        check_archive_size = (!@new_archive_size.nil? and !@old_archive_size.nil?) ? (@new_archive_size >= @old_archive_size) : false
    end


    

end
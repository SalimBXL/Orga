class ToolsController < ApplicationController

    # ACCUEIL
    def index
        # Log action
        log(request.path)
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

        @remove_status = remove_old_backup
        @rename_status = rename_previous_backup
        @command_status = create_archive
        @size_status = check_archive_size
    end

    def download_backup
        #current_directory = File.join(Dir.pwd, "backup")
        #backup = File.join(current_directory, "backup.tar")
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

        # on fait la liste des utilisateurs et des profils de login
        @utilisateurs = Utilisateur.all
        @profiles = User.all

        # pour chaque utilisateur, on vérifie s'il y a au moins un profil
        if @utilisateurs
            @utilisateurs.each do |utilisateur|
                @problemes[utilisateur.email] ||= Hash.new
                @problemes[utilisateur.email]["utilisateur"] = utilisateur
            end
        end

        # pour chaque profil, on vérifie s'il y a au moins un utilisateur
        if @profiles
            @profiles.each do |profile|
                @problemes[profile.email] ||= Hash.new
                @problemes[profile.email]["profile"] = profile
            end
        end
    end

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
        #@tar_command = "pg_dump 'host=localhost port=5432 dbname=MyDataBase_development user=orga password=orga' -Ft  > #{@backup}"
        @tar_command = "pg_dump 'dbname=orga_development user=salim' -Ft  > #{@backup}"
        retour = IO.popen(@tar_command, in: :in)
        boucle_temporelle
        create_archive = File.exist?(@backup)
    end


    def boucle_temporelle
        time = 5    # Cinq secondes
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
        check_archive_size = (@new_archive_size >= @old_archive_size)
    end

end
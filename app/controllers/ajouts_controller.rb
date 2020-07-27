class AjoutsController < ApplicationController
    before_action :find_ajout, only: [:edit, :update, :destroy, :valider, :dupliquer]
    before_action :find_utilisateurs, only: [:new, :create, :edit, :modification]
    before_action :find_groupes, only: [:new, :create, :edit, :modification]
    before_action :find_works, only: [:index, :new, :create, :edit, :modification]
    before_action :find_classes, only: [:new, :create, :edit, :modification]
    before_action :find_services, only: [:new, :create, :edit, :modification]
    before_action :find_etendre, only: [:create, :edit, :modification]

    #############
    #   INDEX   #
    #############
    def index
        @ajouts = Ajout.order(:date, :am_pm, :utilisateur_id)
        #@works = Work.all
        
    end

    def show
    end


    ##########
    #   NEW  #
    ##########
    def new
        @ajout = Ajout.new
    end
    

    ##############
    #   CREATE   #
    ##############
    def create
        err = false
        @ajouts = Array.new

        # Si etendre à la semaine, 
        # on crée 5 jobs pour chacun des jours
        if (@etendre)
            5.times do |i|
                @ajouts[i] = Ajout.create(ajout_params)
                @ajouts[i].date = @ajouts[i].date.beginning_of_week + i.days
            end
        else
            @ajouts[0] = Ajout.create(ajout_params)
        end

        # on sauve les ajouts
        @ajouts.each do |a|
            if a.save
                flash[:notice] = "Ajout (#{a.date}:#{a.utilisateur.prenom_nom}) créé avec succès"
            else
                err = true
            end
        end
        if (err)
            render :new
        end
        redirect_to ajouts_path
    end


    #############
    #   EDIT    #
    #############
    def edit
    end


    #############
    #   UPDATE  #
    #############
    def update
        if @ajout.update(ajout_params)
            flash[:notice] = "Ajout modifiée avec succès"
            redirect_to ajouts_path
        else 
            render :edit
        end
    end

    #################
    # MODIFICATION  #
    #################
    def modification
        @ajout = Ajout.new(utilisateur_id: params[:utilisateur_id], date: params[:date], am_pm: params[:am_pm])
        @ajout.work1 = params[:work1] unless params[:work1].nil?
        @ajout.work2 = params[:work2] unless params[:work2].nil?
        @ajout.work3 = params[:work3] unless params[:work3].nil?
        @ajout.work4 = params[:work4] unless params[:work4].nil?
        @ajout.work5 = params[:work5] unless params[:work5].nil?
        render :edit
    end
    

    ##############
    #   DESTROY  #
    ##############
    def destroy
        @ajout.destroy
    end


    ################
    #   DUPLIQUER  #
    ################
    def dupliquer
        copie = @ajout.dup
        copie.date = @ajout.date + 1.day

        if copie.save
            flash[:notice] = "Ajout (#{copie.date}:#{copie.utilisateur.prenom_nom}) créé avec succès"
        else
            render :new
        end
        redirect_to ajouts_path
    end


    ##############
    #   VALIDER  #
    ##############
    def valider

        semaine = nil
        job = nil
        ajout_created = false
        
        unless @ajout.nil?
            utilisateur = Utilisateur.find_by_id(@ajout.utilisateur_id)
            work1 = Work.find_by_id(@ajout.work1)
            jour = Jour.where(date: @ajout.date, utilisateur: @ajout.utilisateur_id, am_pm: @ajout.am_pm, service_id: work1.service_id)

            # Jour
            # Check si jour existe. Sinon, on le crée.
            if jour.nil? || jour.count < 1
                jour = Jour.create(utilisateur: utilisateur, date: @ajout.date, am_pm: @ajout.am_pm, service: work1.service)
                unless jour.save
                    flash[:danger] = "Impossible de créer la semaine..."
                    redirect_to ajouts_path
                end
            else
                jour = jour.last
            end

            
            # Working_lists trouvées en DB
            liste_en_base = Array.new 
            Jour.find(jour.id).working_lists.each do |wl_db|
                liste_en_base << wl_db.work.id
            end


            # Check si working_list existe. Sinon, on la crée.
            @ajout.works.each do |w|
                #dans la liste ?  
                if liste_en_base.include?(w)
                    # Si oui,  on ne fait rien.
                    liste_en_base.delete(w)
                else
                    # Sinon on l'ajoute.
                    work = Work.find(w)
                    working_list = WorkingList.create(jour: jour, work: work)
                    unless working_list.save
                        flash[:danger] = "Impossible de créer la working liste suivante : JOB ID:#{job.id} WORK ID:#{w}"
                        redirect_to ajouts_path
                    end
                    liste_en_base.delete(w)
                end
            end


            # Si des entrées sont en DB mais pas dans la liste, 
            # on supprime les entrées en DB
            if liste_en_base.count > 0
                liste_en_base.each do |entree|
                    wl = WorkingList.where(work: entree, jour: jour)
                    unless wl.nil?
                        wl.first.destroy
                    end

                end
            end



            # Nettoyage de la liste des ajouts
            @ajout.destroy
            #redirect_to ajouts_path
        end
        redirect_to :controller => 'ajouts', :action => 'index'
    end


    private

    def ajout_params
        params.require(:ajout).permit(:utilisateur_id, :work1, :work2, :work3, :work4, :work5, :date, :am_pm)
    end

    def find_etendre
        @etendre = false
        if (!params[:ajout].nil?)
            if (!params[:ajout][:etendre].nil? && !params[:ajout][:etendre].blank?)
                if (params[:ajout][:etendre] == "1")
                    @etendre = true
                end
            end
        end
    end

    def find_ajout
        @ajout = Ajout.find_by_id(params[:id])
    end

    def find_utilisateurs
        @utilisateurs = Utilisateur.order(:service_id, :groupe_id, :prenom, :nom)
    end

    def find_groupes
        @groupes = Groupe.order(:nom)
    end

    def find_works
        @works = Work.order(:service_id, :classe_id, :groupe_id, :nom)
    end

    def find_classes
        @classes = Classe.order(:nom)
    end

    def find_services
        @services = Service.order(:nom)
    end


end
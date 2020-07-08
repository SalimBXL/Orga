class AjoutsController < ApplicationController
    before_action :find_ajout, only: [:show, :edit, :update, :destroy, :valider, :dupliquer]
    before_action :find_utilisateurs, only: [:new, :create, :edit]
    before_action :find_groupes, only: [:new, :create, :edit]
    before_action :find_works, only: [:index, :new, :create, :edit]
    before_action :find_classes, only: [:new, :create, :edit]
    before_action :find_services, only: [:new, :create, :edit]
    before_action :find_etendre, only: [:create, :edit]

    #############
    #   INDEX   #
    #############
    def index
        @ajouts = Ajout.order(:date, :am_pm, :utilisateur_id)
        #@works = Work.all
        
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
        utilisateur = Utilisateur.find_by_id(@ajout.utilisateur_id)
        work1 = Work.find_by_id(@ajout.work1)
        jour = Jour.where(date: @ajout, utilisateur: @ajout.utilisateur_id, am_pm: @ajout.am_pm, service_id: work1.service_id)

        # Jour
        # Check si jour existe. Sinon, on le crée.
        unless Jour.nil?
            jour = Jour.create(utilisateur: utilisateur, date: @ajout.date, am_pm: @ajout.am_pm, service: work1.service)
            unless jour.save
                flash[:danger] = "Impossible de créer la semaine..."
                redirect_to ajouts_path
            end
        end
        
        # Working_list
        # Check si working_list existe. Sinon, on la crée.
        @ajout.works.each do |w|
            unless WorkingList.exists?(jour: jour, work: w) && Work.exists?(w)
                work = Work.find(w)
                working_list = WorkingList.create(jour: jour, work: work)
                unless working_list.save
                    flash[:danger] = "Impossible de créer la working liste suivante : JOB ID:#{job.id} WORK ID:#{w}"
                    redirect_to ajouts_path
                end
            end
        end

        # Nettoyage de la liste des ajouts
        @ajout.destroy
        redirect_to ajouts_path
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
        @ajout = Ajout.find(params[:id])
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
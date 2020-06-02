class AjoutsController < ApplicationController
    before_action :find_ajout, only: [:show, :edit, :update, :destroy, :valider]
    before_action :find_utilisateurs, only: [:new, :create, :edit]
    before_action :find_groupes, only: [:new, :create, :edit]
    before_action :find_works, only: [:index, :new, :create, :edit]
    before_action :find_classes, only: [:new, :create, :edit]
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


    ##############
    #   VALIDER  #
    ##############
    def valider

        semaine = nil
        job = nil

        ajout_created = false
        utilisateur = Utilisateur.find(@ajout.utilisateur)
        numero_semaine = format_numero_semaine(@ajout.date_lundi.year, @ajout.date_lundi.cweek)
        numero_jour = @ajout.numero_jour
        slug = "#{utilisateur.prenom_nom} #{numero_semaine}".parameterize

        

        # Semaine
        # Check si semaine existe. Sinon, on la crée.
        unless Semaine.exists?(slug: slug)
            semaine = Semaine.create(numero_semaine: numero_semaine, utilisateur: utilisateur, date_lundi: @ajout.date_lundi)
            unless semaine.save
                flash[:danger] = "Impossible de créer la semaine..."
                redirect_to ajouts_path
            end
        else
            semaine = Semaine.find_by_slug(slug)
        end

        # Job
        # Check si job existe. Sinon, on le crée.
        unless Job.exists?(numero_jour: numero_jour, am_pm: @ajout.am_pm, semaine: semaine)
            job = Job.create(numero_jour: numero_jour, am_pm: @ajout.am_pm, semaine_id: semaine.id)
            unless job.save
                flash[:danger] = "Impossible de créer le job..."
                redirect_to ajouts_path
            end
        else
            job = Job.where(numero_jour: numero_jour, am_pm: @ajout.am_pm, semaine: semaine).first
        end
        
        # Working_list
        # Check si working_list existe. Sinon, on la crée.
        @ajout.works.each do |w|
            unless WorkingList.exists?(job: job, work: w) && Work.exists?(w)
                work = Work.find(w)
                working_list = WorkingList.create(job: job, work: work)
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


end
class AjoutsController < ApplicationController
    before_action :find_ajout, only: [:show, :edit, :update, :destroy, :valider]

    #############
    #   INDEX   #
    #############
    def index
        @ajouts = Ajout.all
        @works = Work.all
        @semaines = Semaine.where(date_lundi: @ajouts.last.date_lundi).order(:utilisateur_id) unless @ajouts.count<1
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
        @ajout = Ajout.create(ajout_params)
        if @ajout.save
            flash[:notice] = "ajout créé avec succès"
            redirect_to ajouts_path
        else
            render :new
        end
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

        ajout_created = false
        utilisateur = Utilisateur.find(@ajout.utilisateur)
        numero_semaine = format_numero_semaine(@ajout.date_lundi.year, @ajout.date_lundi.cweek)
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
        unless Job.exists?(numero_jour: @ajout.numero_jour, am_pm: @ajout.am_pm, semaine: semaine.id)
            job = Job.create(numero_jour: @ajout.numero_jour, am_pm: @ajout.am_pm, semaine_id: semaine.id)
            unless job.save
                flash[:danger] = "Impossible de créer le job..."
                redirect_to ajouts_path
            end
        else
            job = Job.find_by_semaine_id(semaine)
        end
        
        # Working_list
        # Check si working_list existe. Sinon, on la crée.
        @ajout.works.each do |w|
            unless WorkingList.exists?(job: job.id, work: w) && Work.exists?(w)
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
        params.require(:ajout).permit(:utilisateur, :work1, :work2, :work3, :work4, :work5, :date_lundi, :am_pm)
    end

    def find_ajout
        @ajout = Ajout.find(params[:id])
    end
end
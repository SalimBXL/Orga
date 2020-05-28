class AjoutsController < ApplicationController
    before_action :find_ajout, only: [:show, :edit, :update, :destroy, :valider]

    #############
    #   INDEX   #
    #############
    def index
        @ajouts = Ajout.all
        @works = Work.all
        
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
        if params[:ajout][:etendre] == "1"
                err = false
                message = ""
                5.times do |n|
                    puts("JOUR #{n} : ")
                    params[:ajout][:date_lundi] = params[:ajout][:date_lundi].to_date.beginning_of_week + n.days
                    @ajout = Ajout.create(ajout_params)
                    if @ajout.save
                        message += "#{@ajout.date_lundi} : ajout créé avec succès ** "
                    else
                        message =+ " ERROR: #{@ajout.date_lundi} : problème lors de l'ajout ** "
                        err = true
                    end
                end
                if err
                    flash[:danger] = message
                    render :new
                else
                    flash[:notice] = message
                    redirect_to ajouts_path
                end
            
        else 
            @ajout = Ajout.create(ajout_params)
            if @ajout.save
                flash[:notice] = "ajout créé avec succès"
                redirect_to ajouts_path
            else
                render :new
            end
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
        params.require(:ajout).permit(:utilisateur, :work1, :work2, :work3, :work4, :work5, :date, :am_pm)
    end

    def find_ajout
        @ajout = Ajout.find(params[:id])
    end

end
class JobsController < ApplicationController
    before_action :find_job, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        @jobs = Job.joins(:semaine).merge(Semaine.order(numero_semaine: :desc)).order(:service_id, :numero_jour, :am_pm).page(params[:page])

        #@jobs = Job.order(semaine_id: :desc).order(:numero_jour, :am_pm).page(params[:page])
        @semaine_last = nil 
        @service_last = nil
        @jour_last = nil
    end


    ################
    # JOBS SEMAINE #
    ################
    def jobs_semaine
        @semaine = Semaine.find_by_id(params[:id])
        @jobs = @semaine.jobs.order(:numero_jour).page(params[:page])
    end


    #############
    #   SHOW    #
    #############
    def show
    end


    #############
    #    NEW    #
    #############
    def new
        @job = Job.new
        unless params[:id].blank? || params[:id].nil?
            @job.semaine_id = params[:id].to_i
        end
    end


    ##############
    #   CREATE   #
    ##############
    def create
        jours = Array.new
        unless (params[:job][:numeros].blank? || params[:job][:numeros].nil? || params[:job][:numeros].count<2)
            params[:job][:numeros].each do |n|
                if (n.length>0)
                    jours << (n.to_i)
                end
            end
        else
            5.times do |j|
                jours << (j+1)
            end
        end
        type_erreur = 0
        message = ""
        jours.each do |numero|
            @job = Job.create(job_params)
            if Job.exists?(semaine_id: params[:job][:semaine_id], numero_jour: numero, am_pm: params[:job][:am_pm])
                message += "Jour #{numero} - Job pour jour #{numero} existe déjà... \n"
                type_erreur = 1
                #redirect_to jobs_path
            else
                @job.numero_jour = numero.to_i
                if !@job.save
                    message = "Problème lors de l'enregistrement du job pour le jour #{numero}..."
                    type_erreur = 2
                    #render :new
                    #return
                end
            end
        end
        if type_erreur == 1
            flash[:alert] = message
            render :new
        elsif type_erreur == 2
            flash[:alert] = message
            redirect_to jobs_path
        else
            flash[:notice] = "Job(s) créé(s) avec succès"
            redirect_to jobs_path
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        if @job.update(job_params)
            flash[:notice] = "Job modifié avec succès"
            redirect_to jobs_path
        else 
            render :edit
        end
    end

    #############
    #   EDIT    #
    #############
    def edit
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        @job.destroy
        #redirect_to jobs_path
    end


    private 

    def job_params
        params.require(:job).permit(:numero_jour, :am_pm, :note, :semaine_id, :numeros, :service_id)
    end

    def find_job
        @job = Job.find(params[:id])
    end    

end
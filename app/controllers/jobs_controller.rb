class JobsController < ApplicationController
    before_action :find_job, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        @jobs = Job.order(semaine_id: :desc).order(:numero_jour, :am_pm).page(params[:page])
    end


    #################
    #   THIS WEEK   #
    #################
    def this_week
        @jobs = Job.where(id: 0)
        semaines = semaines_at(Date.today)
        semaines.find_each do |semaine|
            @jobs = @jobs + semaine.jobs
        end
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
    end


    ##############
    #   CREATE   #
    ##############
    def create
        if params[:job][:numero_jour] != "0"
            
            if Job.exists?(semaine_id: params[:job][:semaine_id], numero_jour: params[:job][:numero_jour])
                # JOB EXISTE...
                flash[:alert] = "Job existe déjà..."
                redirect_to jobs_path
            else
                @job = Job.create(job_params)
                if @job.save
                    flash[:notice] = "Job créé avec succès"
                    redirect_to jobs_path
                    return
                else
                    render :new
                    return
                end
            end
        else
            5.times do |n|
                @job = Job.create(job_params)
                @job.numero_jour = (n+1)
                if Job.exists?(semaine_id: @job.semaine_id, numero_jour: @job.numero_jour)
                    # JOB EXISTE...
                else
                    if @job.save
                        # ok
                    else
                        render :new
                        return
                    end
                end
            end
            flash[:notice] = "Jobs créés avec succès"
            redirect_to jobs_path
            return
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
        params.require(:job).permit(:numero_jour, :am_pm, :note, :semaine_id)
    end

    def find_job
        @job = Job.find(params[:id])
    end    

end
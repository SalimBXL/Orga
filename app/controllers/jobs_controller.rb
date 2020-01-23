class JobsController < ApplicationController
    before_action :find_job, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        @jobs = Job.order(semaine_id: :desc).order(:numero_jour, :am_pm).page(params[:page])
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
        @job = Job.create(job_params)
        if @job.save
            flash[:notice] = "Job créé avec succès"
            redirect_to jobs_path
        else
            render :new
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
        @job = Job.find_by_id(params[:identifier])
        @job ||= Job.find_by_slug(params[:identifier])
        raise ActionController::RoutingError.new("Not found") unless @job
    end    

end
class WorkingListsController < ApplicationController
    before_action :find_working_list, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        @working_lists = WorkingList.order(:job_id, :work_id).page(params[:page])
    end


    #####################
    # WORKING LISTS JOB #
    #####################
    def working_lists_job
        @job = Job.find_by_id(params[:id])
        @working_lists = @job.working_lists.order(:job_id, :work_id).page(params[:page])
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
        @working_list = WorkingList.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        @working_list = WorkingList.create(working_list_params)
        if @working_list.save
            flash[:notice] = "Working List créé avec succès"
            redirect_to working_lists_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        if @working_list.update(working_list_params)
            flash[:notice] = "Working List modifié avec succès"
            redirect_to working_lists_path
        else
            redirect_to :edit
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
        @working_list.destroy
    end


    private 

    def working_list_params
        params.require(:working_list).permit(:job_id, :work_id)
    end

    def find_working_list
        @working_list = WorkingList.find(params[:id])
    end


end
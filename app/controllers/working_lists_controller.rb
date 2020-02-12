class WorkingListsController < ApplicationController
    before_action :find_working_list, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        @working_lists = WorkingList.order(job_id: :desc).order(:work_id).page(params[:page])
    end


    #####################
    # WORKING LISTS JOB #
    #####################
    def working_lists_job
        @job = Job.find_by_id(params[:id])
        @working_lists = @job.working_lists.order(:job_id, :work_id).page(params[:page])
    end

    ######################
    # WORKING LISTS WORK #
    ######################
    def working_lists_work
        @work = Work.find_by_id(params[:id])
        @working_lists = @work.working_lists.order(:job_id, :work_id).page(params[:page])
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
        @works = Work.order(:groupe_id)
        @working_list = WorkingList.new
        unless (params[:id].blank? || params[:id].nil?)
            @working_list.job_id = params[:id]
        end
    end


    ##############
    #   CREATE   #
    ##############
    def create
        unless params[:working_list][:travaux].count>1
            flash[:alert] = "Il faut sélectionner au moins un travail de la lsite..."
            redirect_to "#{new_working_lists_path}/#{params[:working_list][:job_id]}"
        end
        message = ""
        params[:working_list][:travaux].each do |travail|
            params[:working_list][:work_id] = travail
            @working_list = WorkingList.create(working_list_params)
            if !@working_list.save
                message += "Problème lors de la sauvegarde de la working liste pour le travail ID ##{travail}"
            end
        end
        if message.length>0
            flash[:alert] = message
            redirect_to working_lists_path
            return 
        else 
            flash[:notice] = "Working Liste(s) créée(s) avec succèes"
        end
        redirect_to working_lists_path
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
        params.require(:working_list).permit(:job_id, :work_id, :travaux)
    end

    def find_working_list
        @working_list = WorkingList.find(params[:id])
    end


end
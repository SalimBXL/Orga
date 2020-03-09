class WorksController < ApplicationController
    before_action :find_work, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        @works = Work.order(:groupe_id, :nom).page(params[:page])
    end


    ################
    # WORKS GROUPE #
    ################
    def works_groupe
        @groupe = Groupe.find_by_id(params[:id])
        @works = @groupe.works.order(:groupe_id, :nom).page(params[:page])
    end


    ################
    # WORKS CLASSE #
    ################
    def works_classe
        @classe = Classe.find_by_id(params[:id])
        @works = @classe.works.order(:classe_id, :nom).page(params[:page])
    end

    
    #####################
    # WORKS UTILISATEUR #
    #####################
    def works_job
        @job = Job.find_by_id(params[:id])
        @works = @job.working_lists.order(:groupe_id, :nom).page(params[:page])
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
        @work = Work.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        @work = Work.create(work_params)
        if @work.save
            flash[:notice] = "Work créé avec succès"
            redirect_to works_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        if @work.update(work_params)
            flash[:notice] = "Work modifié avec succès"
            redirect_to works_path
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
        @work.destroy
    end


    private 

    def work_params
        params.require(:work).permit(:nom, :description, :groupe_id, :classe_id, :service_id, :code)
    end

    def find_work
        @work = Work.find(params[:id])
    end
    
end
class WorksController < ApplicationController
    before_action :check_logged_in
    before_action :find_work, only: [:show, :edit, :update, :destroy]
    before_action :load_early_values, only: [:show, :edit, :index]

    #############
    #   INDEX   #
    #############
    def index
        # Log action
        log(request.path)
        if current_user.admin?
            @works = Work.order(:service_id, :classe_id, :groupe_id, :nom).page(params[:page])
        else
            @works = Work.where(service: current_user.utilisateur.service).order(:service_id, :classe_id, :groupe_id, :nom).page(params[:page])
        end
    end


    #############
    #   SHOW    #
    #############
    def show
        # Log action
        log(request.path)
    end


    #############
    #    NEW    #
    #############
    def new
        # Log action
        log(request.path)
        @work = Work.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        # Log action
        log(request.path)
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
        # Log action
        log(request.path, I18n.t("works.index.log_update"))
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
        # Log action
        log(request.path, I18n.t("works.index.log_edit"))
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        # Log action
        log(request.path, I18n.t("works.index.log_estroy"))
        @work.destroy
    end


    private 

    def work_params
        params.require(:work).permit(:nom, :description, :groupe_id, :classe_id, :service_id, :code, :mark, :early_value)
    end

    def find_work
        @work = Work.find(params[:id])
    end

    def load_early_values
        @values = ["Early 1", "Early 2", "Regular"]
    end
    
end
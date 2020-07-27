class WorkingListsController < ApplicationController
    before_action :check_logged_in
    before_action :find_working_list, only: [:show, :edit, :update, :destroy]
    before_action :find_services, only: [:new, :edit]
    before_action :find_jours, only: [:new, :edit]
    before_action :find_works, only: [:new, :edit]

    #############
    #   INDEX   #
    #############
    def index
        # Log action
        log(request.path)
        @working_lists = WorkingList.order(jour_id: :desc).order(:work_id).page(params[:page])
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
        @working_list = WorkingList.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        # Log action
        log(request.path)
        @working_list = WorkingList.create(working_list_params)
        if @working_list.save
            flash[:notice] = "Attribution créée avec succès"
            redirect_to working_lists_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        # Log action
        log(request.path, I18n.t("working_lists.index.log_update"))
        if @working_list.update(working_list_params)
            flash[:notice] = "Working List modifiée avec succès"
            redirect_to working_lists_path
        else
            redirect_to :edit
        end
    end


    #############
    #   EDIT    #
    #############
    def edit
        # Log action
        log(request.path, I18n.t("working_lists.index.log_edit"))
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        # Log action
        log(request.path, I18n.t("working_lists.index.log_destroy"))
        @working_list.destroy
    end


    private 

    def working_list_params
        params.require(:working_list).permit(:jour_id, :work_id)
    end

    def find_working_list
        @working_list = WorkingList.find(params[:id])
    end

    def find_services
        @services = Service.order(:lieu_id, :nom)
    end

    def find_jours
        @jours = Jour.order(numero_semaine: :desc).order(:numero_jour)
    end

    def find_works
        @works = Work.order(:service_id, :classe_id, :groupe_id, :code, :nom)
    end

end
class ServicesController < ApplicationController
    before_action :find_service, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        # Log action
        log(request.path)
        @services = Service.order(:nom).page(params[:page])
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
        @service = Service.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        # Log action
        log(request.path)
        @service = Service.create(service_params)
        if @service.save
            flash[:notice] = "Service créé avec succès"
            redirect_to services_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        # Log action
        log(request.path, I18n.t("services.index.log_update"))
        if @service.update(service_params)
            flash[:notice] = "Service modifié avec succès"
            redirect_to services_path
        else
            redirect_to :edit
        end
    end


    #############
    #   EDIT    #
    #############
    def edit
        # Log action
        log(request.path, I18n.t("services.index.log_edit"))
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        # Log action
        log(request.path, I18n.t("services.index.log_destroy"))
        @service.destroy
        #redirect_to services_path
    end


    private 

    def service_params
        params.require(:service).permit(:nom, :lieu_id, :description)
    end

    def find_service
        @service = Service.find(params[:id])
    end


end
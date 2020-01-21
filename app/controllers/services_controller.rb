class ServicesController < ApplicationController
    before_action :find_service, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        @services = Service.order(:nom)
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
        @service = Service.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        @service = Service.create(service_params)
        if @service.save
            redirect_to services_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        if @service.update(service_params)
            redirect_to services_path
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
        @service.destroy
        redirect_to services_path
    end


    private 

    def service_params
        params.require(:service).permit(:nom, :lieu_id, :description)
    end

    def find_service
        @service = Service.find(params[:id])
    end


end
class ServicesController < ApplicationController

    #############
    #   INDEX   #
    #############
    def index
        @services = Service.all
    end


    #############
    #   SHOW    #
    #############
    def show
        @service = Service.find(params[:id])
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
        @service = Service.create(params.require(:service).permit(:nom, :description))
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
    end


    #############
    #   EDIT    #
    #############
    def edit
        @service = Service.find(params[:id])
    end


end
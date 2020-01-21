class LieusController < ApplicationController
    before_action :find_groupe, only: [:show, :edit, :update]

    #############
    #   INDEX   #
    #############
    def index
        @lieus = Lieu.order(:nom)
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
        @lieu = Lieu.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        @lieu = Lieu.create(lieu_params)
        if @lieu.save
            redirect_to lieus_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        if @lieu.update(lieu_params)
            redirect_to lieus_path
        else 
            render :edit
        end
    end

    #############
    #   EDIT    #
    #############
    def edit
    end


    private 

    def lieu_params
        params.require(:lieu).permit(:nom, :adresse, :phone, :note)
    end

    def find_groupe
        @lieu = Lieu.find(params[:id])
    end
    
end
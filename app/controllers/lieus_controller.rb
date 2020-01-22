class LieusController < ApplicationController
    before_action :find_lieu, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        @lieus = Lieu.order(:nom).page(params[:page])
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
            flash[:notice] = "Lieu créé avec succès"
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
            flash[:notice] = "Lieu Modifié avec succès"
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

    ##############
    #   DESTROY  #
    ##############
    def destroy
        @lieu.destroy
        #redirect_to lieus_path
    end


    private 

    def lieu_params
        params.require(:lieu).permit(:nom, :adresse, :phone, :note)
    end

    def find_lieu
        @lieu = Lieu.find(params[:id])
    end
    
end
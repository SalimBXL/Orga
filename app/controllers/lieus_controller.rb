class LieusController < ApplicationController
    before_action :check_logged_in
    before_action :find_lieu, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        # Log action
        log(request.path)
        @lieus = Lieu.order(:nom).page(params[:page])
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
        @lieu = Lieu.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        # Log action
        log(request.path)
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
        # Log action
        log(request.path, I18n.t("lieus.index.log_update"))
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
        # Log action
        log(request.path, I18n.t("lieus.index.log_edit"))
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        # Log action
        log(request.path, I18n.t("lieus.index.log_destroy"))
        @lieu.destroy
    end


    private 

    def lieu_params
        params.require(:lieu).permit(:nom, :adresse, :phone, :note)
    end

    def find_lieu
        @lieu = Lieu.find(params[:id])
    end
    
end
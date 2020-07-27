class GroupesController < ApplicationController
    before_action :check_logged_in
    before_action :find_groupe, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        # Log action
        log(request.path)
        @groupes = Groupe.order(:nom).page(params[:page])
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
        @groupe = Groupe.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        # Log action
        log(request.path)
        @groupe = Groupe.create(groupe_params)
        if @groupe.save
            flash[:notice] = "Groupe créé avec succès"
            redirect_to groupes_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        # Log action
        log(request.path, I18n.t("groupes.index.log_update"))
        if @groupe.update(groupe_params)
            flash[:notice] = "Groupe modifié avec succès"
            redirect_to groupes_path
        else 
            render :edit
        end
    end

    #############
    #   EDIT    #
    #############
    def edit
        # Log action
        log(request.path, I18n.t("groupes.index.log_edit"))
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        # Log action
        log(request.path, I18n.t("groupes.index.log_destroy"))
        @groupe.destroy
        #redirect_to groupes_path
    end


    private 

    def groupe_params
        params.require(:groupe).permit(:nom, :description)
    end

    def find_groupe
        @groupe = Groupe.find(params[:id])
    end
    
end
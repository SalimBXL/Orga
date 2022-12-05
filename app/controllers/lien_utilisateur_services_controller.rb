class LienUtilisateurServicesController < ApplicationController
    before_action :check_logged_in
    before_action :find_lien_utilisateur_service, only: [:show, :edit, :update, :destroy]
    before_action :find_services, only: [:new, :edit]
    before_action :find_utilisateurs, only: [:new, :edit]

    #############
    #   INDEX   #
    #############
    def index
        # Log action
        log(request.path)
        @lien_utilisateur_services = LienUtilisateurService.order(:utilisateur_id, :service_id).page(params[:page])
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
        @lien_utilisateur_service = LienUtilisateurService.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        # Log action
        log(request.path)
        @lien_utilisateur_service = LienUtilisateurService.create(lien_utilisateur_service_params)
        if @lien_utilisateur_service.save
            flash[:notice] = "Attribution créée avec succès"
            redirect_to lien_utilisateur_services_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        # Log action
        log(request.path)
        if @lien_utilisateur_service.update(lien_utilisateur_service_params)
            flash[:notice] = "Lien Utilisateur Service modifié avec succès"
            redirect_to lien_utilisateur_services_path
        else
            redirect_to :edit
        end
    end


    #############
    #   EDIT    #
    #############
    def edit
        # Log action
        log(request.path)
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        # Log action
        log(request.path)
        @lien_utilisateur_service.destroy
    end


    private 

    def lien_utilisateur_service_params
        params.require(:lien_utilisateur_service).permit(:utilisateur_id, :service_id)
    end

    def find_lien_utilisateur_service
        @lien_utilisateur_service = LienUtilisateurService.find(params[:id])
    end

    def find_services
        @services = Service.order(:lieu_id, :nom)
    end

    def find_utilisateurs
        @utilisateurs = Utilisateur.order(:service_id, :prenom, :nom)
    end
end
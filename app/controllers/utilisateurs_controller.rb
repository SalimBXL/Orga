class UtilisateursController < ApplicationController
    before_action :find_utilisateur, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        @utilisateurs = Utilisateur.order(:service, :groupe, :nom, :prenom).page(params[:page])
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
        @utilisateur = Utilisateur.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        @utilisateur = Utilisateur.create(utilisateur_params)
        if @utilisateur.save
            flash[:notice] = "Utilisateur créé avec succès"
            redirect_to utilisateurs_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        if @utilisateur.update(utilisateur_params)
            flash[:notice] = "Utilisateur modifié avec succès"
            redirect_to utilisateurs_path
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
        @utilisateur.destroy
        #redirect_to utilisateurs_path
    end


    private 

    def utilisateur_params
        params.require(:utilisateur).permit(:prenom, :nom, :email, :phone, :gsm, :groupe_id, :service_id)
    end

    def find_utilisateur
        @utilisateur = Utilisateur.find(params[:id])
    end
    
end
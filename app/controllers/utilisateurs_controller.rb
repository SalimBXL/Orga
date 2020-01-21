class UtilisateursController < ApplicationController

    #############
    #   INDEX   #
    #############
    def index
        @utilisateurs = Utilisateur.all
    end


    #############
    #   SHOW    #
    #############
    def show
        @utilisateur = Utilisateur.find(params[:id])
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
        @utilisateur = Utilisateur.create(params.require(:utilisateur).permit(:nom, :prenom, :email, :email_confirmation, :password, :password_confirmation, :phone, :gsm))
        if @utilisateur.save
            redirect_to Utilisateurs_path
        else
            render :new
        end
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        @utilisateur.destroy
        redirect_to utilisateurs_path
    end

end
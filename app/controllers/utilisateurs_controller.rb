class UtilisateursController < ApplicationController
    before_action :create_user, only: [:create, :update]
    before_action :find_utilisateur, only: [:show, :edit, :update, :destroy]
    

    #############
    #   INDEX   #
    #############
    def index
        @utilisateurs = Utilisateur.order(:service_id, :groupe_id, :prenom, :nom).page(params[:page])
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
        @utilisateur.user = @utilisateur.profil
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
        @utilisateur.user = @utilisateur.profil
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
        params.require(:utilisateur).permit(:prenom, :nom, :email, :phone, :gsm, :groupe_id, :service_id, :admin)
    end

    def find_utilisateur
        @utilisateur = Utilisateur.find(params[:id])
    end

    def create_user
        unless User.find_by_email(utilisateur_params[:email])
            user = User.create(email: utilisateur_params[:email], password: "password")
            if user.save
                flash[:notice] = "Login créé avec succès"
            else
                render :new
            end
        end
    end
    
end
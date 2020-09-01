class UtilisateursController < ApplicationController
    before_action :check_logged_in
    before_action :create_user, only: [:create, :update]
    before_action :find_utilisateur, only: [:show, :edit, :update, :destroy]
    

    #############
    #   INDEX   #
    #############
    def index
        # Log action
        log(request.path)
        @utilisateurs = Utilisateur.order(:service_id, :groupe_id, :prenom, :nom).page(params[:page])
        @users = User.order(:email)

        @orphelins_utilisateurs = Array.new
        @orphelins_users = Array.new

        # Est-ce que cheque utilisateur possède un profil de connexion ?
        @utilisateurs.each do |utilisateur|
            if @users.find_by_email(utilisateur.email).nil?
                # Problème... !!!
                @orphelins_utilisateurs << utilisateur.id
            end
        end

        # Est-ce que chaque profil de connexion est lié à un utilisateur ?
        @users.each do |user|
            if @utilisateurs.find_by_email(user.email).nil?
                # Problème... !!!
                @orphelins_users << user.id
            end
        end

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
        @utilisateur = Utilisateur.new
        @services = Service.all
        @groupes = Groupe.all
    end


    ##############
    #   CREATE   #
    ##############
    def create
        # Log action
        log(request.path)
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
        # Log action
        log(request.path, I18n.t("utilisateurs.index.log_update"))
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
        # Log action
        log(request.path, I18n.t("utilisateurs.index.log_edit"))
        @services = Service.all
        @groupes = Groupe.all
        
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        # Log action
        log(request.path, I18n.t("utilisateurs.index.log_destroy"))
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
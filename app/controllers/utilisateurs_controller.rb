class UtilisateursController < ApplicationController
    before_action :check_logged_in
    before_action :create_user, only: [:create, :update]
    before_action :find_utilisateur, only: [:show, :edit, :update, :destroy]
    

    #   send welcome email  #
    def send_welcome_email(user)
        @utilisateur = user
        respond_to do |format|
            UserMailer.with(user: user).welcome_email.deliver_now
            format.html { redirect_to(utilisateurs_path, notice: "Message sent to #{user.email}...") }
        end
    end

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
        #send_welcome_email @utilisateur
        # Log action
        log(request.path)
        session[:return_user_id] = @utilisateur.id

        #
        # trouve les jours
        #
        @jours = Jour.where('date >= ?', Date.today-15.days).where(utilisateur: @utilisateur).order(:date, :service_id)
        @wks = Hash.new
        @duree_works = Hash.new
        @jours.each do |jour|
            WorkingList.where(jour_id: jour.id).each do |workinglist|
                @wks[jour] ||= Array.new
                @wks[jour] <<  workinglist.work.code
                @duree_works[jour] ||= 0
                @duree_works[jour] += workinglist.work.length if workinglist.work.length
            end
        end

        #
        # trouve les tâches
        #
        find_tasks(@utilisateur)
        
        #
        # trouve les absences
        #
        @absences = Hash.new
        absences = Absence.where(utilisateur: @utilisateur).where('date_fin >= ?', Date.today.beginning_of_month).order(:date, :date_fin)
        absences.each do |absence|
            (absence.date..absence.date_fin).each do |aj|
                @absences[aj] = absence
            end
        end
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
        puts "********************************* Creation utilisateur"
        @utilisateur = Utilisateur.create(utilisateur_params)
        puts "********************************* Update user"
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

        @utilisateur.profil.admin = false if @utilisateur.admin == false
        @utilisateur.user = @utilisateur.profil

        if @utilisateur.update(utilisateur_params)
            if @utilisateur.profil.save
                flash[:notice] = "Utilisateur modifié avec succès"
                redirect_to utilisateurs_path
            end
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
        params.require(:utilisateur).permit(:prenom, :nom, :email, :phone, :gsm, :groupe_id, :service_id, :admin, :inactive)
    end

    def find_utilisateur
        @utilisateur = Utilisateur.find(params[:id])
    end

    def create_user
        unless User.find_by_email(utilisateur_params[:email].downcase)
            @user = User.create(email: utilisateur_params[:email].downcase, password: "password")
            if @user.save
                flash[:notice] = "Login créé avec succès"
            else
                #puts "ERRR : #{user.errors}"
                @user.errors.full_messages.each do |err|
                    #puts "     => #{err}"
                end
                render :new
            end
        end
    end
    
end
class BugRepportsController < ApplicationController
    before_action :find_bug_repport, only: [:show, :edit, :update, :destroy]
    before_action :check_logged_in

    #############
    #   INDEX   #
    #############
    def index
        # Log action
        log(request.path)
        @bug_repports = BugRepport.order(date: :desc).page(params[:page])

        session[:return_user_id] = nil
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
        @bug_repport = BugRepport.new
        @bug_repport.date = Date.today
        find_utilisateurs if @utilisateurs.nil?

        # Log action
        log(request.path)
    end


    ##############
    #   CREATE   #
    ##############
    def create
        # Log action
        log(request.path)
        @bug_repport = BugRepport.create(bug_repport_params)
        if @bug_repport.save
            flash[:notice] = "Bug Repport créé"
            redirect_to bug_repports_path
        else
            flash[:danger] = "Erreur(s)"
            find_utilisateurs if @utilisateurs.nil?
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        # Log action
        log(request.path, I18n.t("bug_repports.index.log_update"))

        # on sauve.
        if @bug_repport.update(bug_repport_params)
            flash[:notice] = "Bug repport modifié"
            redirect_to bug_repports_path
        else 
            find_utilisateurs if @utilisateurs.nil?
            render :edit
        end
    end

    #############
    #   EDIT    #
    #############
    def edit
        # Log action
        log(request.path, I18n.t("bug_repports.index.log_edit"))
        find_utilisateurs
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        # Log action
        log(request.path, I18n.t("bug_repports.index.log_destroy"))
        @bug_repport.destroy

        if !session[:return_user_id].blank? or !session[:return_user_id].nil?
            tmp = session[:return_user_id]
            session[:return_user_id] = nil
        end
    end

    


    private 

    def bug_repport_params
        params.require(:bug_repport).permit(:date, :nom, :description, :utilisateur_id, :status)
    end

    def find_bug_repport
        @bug_repport = BugRepport.find(params[:id])
    end
    
end
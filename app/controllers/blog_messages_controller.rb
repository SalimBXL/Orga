class BlogMessagesController < ApplicationController
    before_action :find_message, only: [:show, :edit, :update, :destroy, :review]
    before_action :find_classes
    before_action :find_categories
    before_action :find_groupes
    before_action :find_services
    before_action :find_utilisateurs
    

    #############
    #   INDEX   #
    #############
    def index
        # Log action
        log(request.path)
        
        @not_yet_reviewed_messages = BlogMessage.where(logbook: true)
        @not_yet_reviewed_messages = @not_yet_reviewed_messages.where(reviewed: nil).or(@not_yet_reviewed_messages.where(reviewed: false)).size

        @blog_messages = nil
        @blog_messages = BlogMessage.where(blog_category_id: params[:blog_category_id]).order(date: :desc).page(params[:page]) if params[:blog_category_id]
        @blog_messages = BlogMessage.where(service_id: params[:service_id]).order(date: :desc).page(params[:page]) if params[:service_id] and params[:service_id] != "-1"
        @blog_messages = BlogMessage.order(date: :desc).page(params[:page]) if params[:service_id] and params[:service_id] == "-1"
        @blog_messages = BlogMessage.where(utilisateur_id: params[:utilisateur_id]).order(date: :desc).page(params[:page]) if params[:utilisateur_id]        
        @blog_messages = BlogMessage.where(classe: params[:classe]).order(date: :desc).page(params[:page]) if params[:classe]
        @blog_messages = BlogMessage.where(groupe: params[:groupe]).order(date: :desc).page(params[:page]) if params[:groupe]
        @blog_messages = BlogMessage.where("title ilike ? OR description ilike ?", "%#{params[:search]}%", "%#{params[:search]}%").order(date: :desc).page(params[:page]) if params[:search]
        @blog_messages = BlogMessage.where(logbook: true).order(date: :desc).page(params[:page]) if params[:logbook]

        # Date + Logbook
        if (params[:date] and !params[:date].blank? and params[:logbook])
            @blog_messages = @blog_messages.where("date >= ? and date <= ?", params[:date].to_datetime.strftime("%Y-%m-%d"), params[:date].to_datetime.end_of_month.strftime("%Y-%m-%d")).where(logbook: true).order(date: :desc).order(date: :desc).page(params[:page])
            @possible_to_export = true
        else
            @possible_to_export = false
        end
        
        # Date seulement
        @blog_messages = BlogMessage.where("date >= ? and date <= ?", params[:date].to_datetime.strftime("%Y-%m-%d"), params[:date].to_datetime.end_of_month.strftime("%Y-%m-%d")).order(date: :desc).page(params[:page]) if (params[:date] and !params[:date].blank? and !params[:logbook])
        
        # Logbook reviewed seulement
        @blog_messages = BlogMessage.where(logbook: true, reviewed: nil).order(date: :desc).page(params[:page]) if params[:reviewed]
        
        # Toutes les entrées...
        #@blog_messages = BlogMessage.order(date: :desc).page(params[:page]) if @blog_messages.nil?
        if @blog_messages.nil?
            params[:service_id] = @current_user.utilisateur.service_id
            @blog_messages = BlogMessage.where(service_id: params[:service_id]).order(date: :desc).page(params[:page])
        end
        
    end


    #############
    #   SHOW    #
    #############
    def show
        # Log action
        log(request.path)
        @responses = BlogResponse.where(blog_message_id: @blog_message.id)
        @reviewer = @blog_message.reviewer ? Utilisateur.find(@blog_message.reviewer).prenom_nom : nil
        wiki_id = WikiPage.where(blog_message_id: @blog_message.id).first
        @wiki_id = (wiki_id.nil?) ? nil : wiki_id.id
    end


    #############
    #    NEW    #
    #############
    def new
        # Log action
        log(request.path)
        @blog_message = BlogMessage.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        # Log action
        log(request.path)
        @blog_message = BlogMessage.create(message_params)
        if @blog_message.save
            flash[:notice] = "Article créé avec succès"
            redirect_to blog_messages_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        # Log action
        log(request.path, I18n.t("messages.index.log_update"))
        
        if @blog_message.update(message_params)
            flash[:notice] = "Article modifié avec succès"
            redirect_to blog_messages_path
        else
            redirect_to :edit
        end
    end


    #############
    #   EDIT    #
    #############
    def edit
        # Log action
        log(request.path, I18n.t("messages.index.log_edit"))
    end


    ##############
    #   DESTROY  #
    ##############
    def destroy
        # Log action
        log(request.path, I18n.t("messages.index.log_destroy"))
        @blog_message.destroy
    end


    #############
    #   REVIEW  #
    #############
    def review
        log(request.path, I18n.t("messages.index.log_review_blog"))
        @blog_message.reviewed = true if @blog_message.logbook and @blog_message.reviewed.nil?
        @blog_message.reviewer = current_user.utilisateur.id if @blog_message.reviewed = true
        if @blog_message.update(reviewed: @blog_message.reviewed, reviewer: @blog_message.reviewer)
            flash[:notice] = "Article modifié avec succès"
        end
        redirect_to blog_messages_path
    end


    

    private 

    def message_params
        params.require(:blog_message).permit(:service_id, :title, :date, :utilisateur_id, :description, :blog_category_id, :groupe, :classe, :logbook, :reviewed)
    end

    def find_message
        @blog_message = BlogMessage.find(params[:id])
    end

    def find_categories
        @categories = BlogCategory.order(:nom)
        @blog_categories = Hash.new
        @categories.each do |s|
            @blog_categories[s.id] = s.nom
        end
    end

    def find_classes
        @blog_classes = Hash.new
        Classe.all.each do |s|
            @blog_classes[s.id] = s.nom
        end
    end

    def find_groupes
        @blog_groupes = Hash.new
        Groupe.all.each do |s|
            @blog_groupes[s.id] = s.nom
        end
    end

    def find_services
        @blog_services = Hash.new
        Service.all.each do |s|
            @blog_services[s.id] = s.nom
        end
    end

    def find_utilisateurs
        @blog_utilisateurs = Hash.new
        Utilisateur.all.each do |s|
            @blog_utilisateurs[s.id] = s.prenom_nom
        end
    end

end
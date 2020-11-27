class BlogMessagesController < ApplicationController
    before_action :find_message, only: [:show, :edit, :update, :destroy]
    before_action :find_categories

    #############
    #   INDEX   #
    #############
    def index
        # Log action
        log(request.path)
        @blog_messages = BlogMessage.order(date: :desc).page(params[:page])

        ## UTILISATEURS
        utilisateurs = Hash.new
        Utilisateur.all.each do |u|
            utilisateurs[u.id] = u.prenom_nom
        end
        blog_users = Array.new
        @blog_messages.each do |u|
            blog_users << u.utilisateur_id
        end
        @blog_utilisateurs = Hash.new
        blog_users.each do |u|
            @blog_utilisateurs[u] = utilisateurs[u]
        end

        ## SERVICES
        services = Hash.new
        Service.all.each do |s|
            services[s.id] = s.nom
        end
        blog_services = Array.new
        @blog_messages.each do |u|
            blog_services << u.service_id
        end
        @blog_services = Hash.new
        blog_services.each do |s|
            @blog_services[s] = services[s]
        end

        ## CAREGORIES
        categories = Hash.new
        BlogCategory.all.each do |s|
            categories[s.id] = s.nom
        end
        blog_categories = Array.new
        @blog_messages.each do |u|
            blog_categories << u.blog_category_id
        end
        @blog_categories = Hash.new
        blog_categories.each do |s|
            @blog_categories[s] = categories[s]
        end

        ## CLASSES
        classes = Hash.new
        Classe.all.each do |s|
            classes[s.id] = s.nom
        end
        blog_classes = Array.new
        @blog_messages.each do |u|
            blog_classes << u.classe
        end
        @blog_classes = Hash.new
        blog_classes.each do |s|
            @blog_classes[s] = classes[s]
        end

        ## GROUPES
        groupes = Hash.new
        Groupe.all.each do |s|
            groupes[s.id] = s.nom
        end
        blog_groupes = Array.new
        @blog_messages.each do |u|
            blog_groupes << u.groupe
        end
        @blog_groupes = Hash.new
        blog_groupes.each do |s|
            @blog_groupes[s] = groupes[s]
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


    private 

    def message_params
        params.require(:blog_message).permit(:service_id, :title, :date, :utilisateur_id, :description, :blog_category_id, :groupe, :classe)
    end

    def find_message
        @blog_message = BlogMessage.find(params[:id])
    end

    def find_categories
        @categories = BlogCategory.order(:nom)
    end


end
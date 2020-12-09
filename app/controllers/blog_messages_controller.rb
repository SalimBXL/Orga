class BlogMessagesController < ApplicationController
    before_action :find_message, only: [:show, :edit, :update, :destroy]
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
        @blog_messages = nil
        @blog_messages = BlogMessage.where(blog_category_id: params[:blog_category_id]).order(date: :desc).page(params[:page]) if params[:blog_category_id]
        @blog_messages = BlogMessage.where(service_id: params[:service_id]).order(date: :desc).page(params[:page]) if params[:service_id]
        @blog_messages = BlogMessage.where(utilisateur_id: params[:utilisateur_id]).order(date: :desc).page(params[:page]) if params[:utilisateur_id]
        @blog_messages = BlogMessage.where(classe: params[:classe]).order(date: :desc).page(params[:page]) if params[:classe]
        @blog_messages = BlogMessage.where(groupe: params[:groupe]).order(date: :desc).page(params[:page]) if params[:groupe]
        @blog_messages = BlogMessage.order(date: :desc).page(params[:page]) if @blog_messages.nil?
    end


    #############
    #   SHOW    #
    #############
    def show
        # Log action
        log(request.path)
        @responses = BlogResponse.where(blog_message_id: @blog_message.id)
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
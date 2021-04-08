class WikiPagesController < ApplicationController
    
    before_action :find_categories
    before_action :find_groupes
    before_action :find_services
    before_action :find_utilisateurs
    before_action :find_wiki_page, only: [:show, :edit, :update, :destroy]
    

    #############
    #   INDEX   #
    #############
    def index
        # Log action
        log(request.path)
        
        @wiki_pages = nil

        # @blog_messages = BlogMessage.where(blog_category_id: params[:blog_category_id]).order(date: :desc).page(params[:page]) if params[:blog_category_id]
        # @blog_messages = BlogMessage.where(service_id: params[:service_id]).order(date: :desc).page(params[:page]) if params[:service_id]
        # @blog_messages = BlogMessage.where(utilisateur_id: params[:utilisateur_id]).order(date: :desc).page(params[:page]) if params[:utilisateur_id]        
        # @blog_messages = BlogMessage.where(classe: params[:classe]).order(date: :desc).page(params[:page]) if params[:classe]
        # @blog_messages = BlogMessage.where(groupe: params[:groupe]).order(date: :desc).page(params[:page]) if params[:groupe]
        # @blog_messages = BlogMessage.where("title ilike ? OR description ilike ?", "%#{params[:search]}%", "%#{params[:search]}%").order(date: :desc).page(params[:page]) if params[:search]
        # @blog_messages = BlogMessage.where(logbook: true).order(date: :desc).page(params[:page]) if params[:logbook]

        # Toutes les entrées...
        @wiki_pages = WikiPage.order(updated_at: :desc).page(params[:page]) if @wiki_pages.nil?
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
        @wiki_page = WikiPage.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        # Log action
        log(request.path)
        @wiki_page = WikiPage.create(message_params)
        if @wiki_page.save
            flash[:notice] = "Article Wiki créé avec succès"
            redirect_to wiki_pages_path
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
        
        if @wiki_page.update(message_params)
            flash[:notice] = "Article wiki modifié avec succès"
            redirect_to wiki_pages_path
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
        @wiki_page.destroy
    end

    private 

    def message_params
        params.require(:wiki_page).permit(:utilisateur_id, :blog_category_id, :service_id, :groupe_id, :keywords, :title, :problem_description, :solution_short, :solution_long, :blog_message_id)
    end

    def find_wiki_page
        @wiki_page = WikiPage.find(params[:id])
    end

    def find_categories
        @categories = BlogCategory.order(:nom)
        @blog_categories = Hash.new
        @categories.each do |s|
            @blog_categories[s.id] = s.nom
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
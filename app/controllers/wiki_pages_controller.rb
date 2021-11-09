class WikiPagesController < ApplicationController
    before_action :check_logged_in
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
        if params[:blog_message_id]
            @wiki_page.blog_message_id = params[:blog_message_id]
            blog_message = BlogMessage.find(@wiki_page.blog_message_id)
            if blog_message
                @wiki_page.blog_category_id = blog_message.blog_category_id
                @wiki_page.service_id = blog_message.service_id
                @wiki_page.groupe_id = blog_message.groupe
                @wiki_page.keywords = blog_message.keywords
            end
        end
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
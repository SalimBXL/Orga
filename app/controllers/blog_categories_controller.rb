class BlogCategoriesController < ApplicationController
    before_action :find_categories, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        log(request.path)
        @blog_categories = BlogCategory.order(:nom).page(params[:page])
    end


    #############
    #   SHOW    #
    #############
    def show
        log(request.path)
    end


    #############
    #    NEW    #
    #############
    def new
        log(request.path)
        @blog_category = BlogCategory.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        log(request.path)
        @blog_category = BlogCategory.create(category_params)
        if @blog_category.save
            flash[:notice] = "Catégorie créée avec succès"
            redirect_to blog_categories_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        log(request.path, I18n.t("messages.index.log_update"))
        if @blog_category.update(category_params)
            flash[:notice] = "Catégorie modifiée avec succès"
            redirect_to blog_categories_path
        else
            redirect_to :edit
        end
    end


    #############
    #   EDIT    #
    #############
    def edit
        log(request.path, I18n.t("messages.index.log_edit"))
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        log(request.path, I18n.t("messages.index.log_destroy"))
        @blog_category.destroy
    end


    private 

    def category_params
        params.require(:blog_category).permit(:nom, :description)
    end

    def find_categories
        @blog_category = BlogCategory.find(params[:id])
        
    end


end
class BlogResponsesController < ApplicationController
    before_action :check_logged_in
    before_action :find_response, only: [:edit, :update, :destroy, :hide]
    before_action :find_message, only: [:new, :edit, :update]
    before_action :find_utilisateurs
    

    
    #############
    #    NEW    #
    #############
    def new
        # Log action
        log(request.path)
        @blog_response = BlogResponse.new(blog_message_id: @blog_message_id)
    end


    ##############
    #   CREATE   #
    ##############
    def create
        # Log action
        log(request.path)
        @blog_response = BlogResponse.create(message_params)
        if @blog_response.save
            flash[:notice] = "Réponse créée avec succès"
            redirect_to blog_message_path(message_params[:blog_message_id])
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
        if @blog_response.update(message_params)
            flash[:notice] = "Réponse modifiée avec succès"
            redirect_to blog_messages_path(@blog_response.blog_message_id)
        else
            redirect_to :edit
        end
    end

    #############
    #   HIDE    #
    #############
    def hide
        #params[:hidden] = params[:hidden] == true ? nil : true
        @blog_response.hidden = params[:hidden]
        if @blog_response.update(hidden: params[:hidden])
            flash[:notice] = "Réponse modifiée avec succès"
            redirect_to blog_message_path(params[:blog_message_id])
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
        @blog_response.destroy
    end


    private 

    def message_params
        params.require(:blog_response).permit(:utilisateur_id, :description, :blog_message_id, :hidden)
    end

    

    def find_response
        @blog_response = BlogResponse.find(params[:id])
    end

    def find_message
        if params[:blog_message_id].blank? or params[:blog_message_id].empty?
            flash[:notice] = "ERROR. Blog message ID required..."
            redirect_to blog_messages_path
        end
        @blog_message_id = params[:blog_message_id]
        @message = BlogMessage.find(params[:blog_message_id])
    end

    def find_utilisateurs
        @blog_utilisateurs = Hash.new
        Utilisateur.all.each do |s|
            @blog_utilisateurs[s.id] = s.prenom_nom
        end
    end

end
class BlogResponsesController < ApplicationController
    before_action :find_response, only: [:edit, :update, :destroy]
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
            flash[:notice] = "Réponse modifiée avec succès"
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
        @blog_response.destroy
    end


    private 

    def message_params
        params.require(:blog_response).permit(:utilisateur_id, :description, :blog_message_id)
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
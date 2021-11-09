class MessagesController < ApplicationController
    before_action :check_logged_in
    before_action :find_message, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        # Log action
        log(request.path)
        @messages = Message.order(date: :desc).page(params[:page])
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
        @message = Message.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        # Log action
        log(request.path)
        @message = Message.create(message_params)
        if @message.save
            flash[:notice] = "Message créé avec succès"
            redirect_to messages_path
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
        if @message.update(message_params)
            flash[:notice] = "Message modifié avec succès"
            redirect_to messages_path
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
        @message.destroy
    end


    private 

    def message_params
        params.require(:message).permit(:service_id, :note, :date, :date_fin)
    end

    def find_message
        @message = Message.find(params[:id])
    end


end
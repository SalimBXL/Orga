class LogRepportsController < ApplicationController
    before_action :check_logged_in
    before_action :find_log_repport, only: [:show, :edit, :update, :destroy]

    def index
        @log_repports = LogRepport.order(created_at: :desc).order(:controller, :action).page(params[:page])
    end


    def show
    end


    def new
        @log_repport = LogRepport.new
    end
   

    def create
        @log_repport = LogRepport.create(log_repport_params)
        if @log_repport.save
            flash[:notice] = "Log créé avec succès"
            redirect_to log_repports_path
        else
            render :new
        end
    end


    def update
        if @log_repport.update(log_repport_params)
            flash[:notice] = "Log modifié avec succès"
            redirect_to log_repports_path
        else 
            render :edit
        end
    end


    def edit
    end


    def destroy
        @log_repport.destroy
    end


    private

    def log_repport_params
        params.require(:log_repport).permit(:controller, :action, :count, :date, :hour, :minute)
    end
    

    def find_log_repport
        @log_repport = LogRepport.find(params[:id])
    end

end
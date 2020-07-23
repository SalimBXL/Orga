class LogsController < ApplicationController
    before_action :find_log, only: [:show, :edit, :update, :destroy]

    def index
        @logs = Log.order(date: :desc).page(params[:page])
    end


    def show
    end


    def new
        @log = Log.new
    end
   

    def create
        @log = Log.create(log_params)
        if @log.save
            flash[:notice] = "Log créé avec succès"
            redirect_to logs_path
        else
            render :new
        end
    end


    def update
        if @log.update(log_params)
            flash[:notice] = "Log modifié avec succès"
            redirect_to logs_path
        else 
            render :edit
        end
    end


    def edit
    end


    def destroy
        @log.destroy
    end


    private

    def log_params
        params.require(:log).permit(:adresse, :date, :utilisateur_id, :description)
    end
    

    def find_log
        @log = Log.find(params[:id])
    end

end
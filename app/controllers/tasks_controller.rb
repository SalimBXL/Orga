class TasksController < ApplicationController
    before_action :check_logged_in
    before_action :find_task, only: [:show, :edit, :update, :destroy]
    #before_action :load_early_values, only: [:new, :show, :edit, :index]

    #############
    #   INDEX   #
    #############
    def index
        # Log action
        log(request.path)
        @tasks = is_super_admin? ? Task.order(:service_id, :classe_id, :groupe_id, :nom).page(params[:page]) : @tasks = Task.where(service: current_user.utilisateur.service).order(:service_id, :classe_id, :groupe_id, :nom).page(params[:page])

        @completion = Hash.new
        hebdos = Hebdo.where(year_id: Date.today.year)
        hebdos.each do |hebdo|
            @completion[hebdo.task_id] ||= 0
            @completion[hebdo.task_id] = @completion[hebdo.task_id] + 1
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
        @task = Task.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        # Log action
        log(request.path)
        @task = Task.create(task_params)
        if @task.save
            flash[:notice] = "Task créée avec succès"
            redirect_to tasks_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        # Log action
        log(request.path, I18n.t("tasks.index.log_update"))
        if @task.update(task_params)
            flash[:notice] = "Task modifiée avec succès"
            redirect_to tasks_path
        else 
            render :edit
        end
    end

    #############
    #   EDIT    #
    #############
    def edit
        # Log action
        log(request.path, I18n.t("tasks.index.log_edit"))
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        # Log action
        log(request.path, I18n.t("tasks.index.log_estroy"))
        @task.destroy
    end


    private 

    def task_params
        params.require(:task).permit(:nom, :description, :groupe_id, :classe_id, :service_id, :code, :mark, :repeat)
    end

    def find_task
        @task = Task.find(params[:id])
    end
end
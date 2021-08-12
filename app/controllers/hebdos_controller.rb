class HebdosController < ApplicationController
    before_action :find_hebdos, only: [:show, :edit, :update, :destroy]
    #before_action :read_konfig, only: [:specific_month, :secr_pet]

    #############
    #   INDEX   #
    #############
    def index
        # Log action
        log(request.path)

        session[:return_user_id] = nil

        if current_user.admin?
            @hebdos = Hebdo.order(numero_semaine: :desc).order(:utilisateur_id, :task_id).page(params[:page])
        else
            @hebdos = Hebdo.where(service: current_user.utilisateur.service).order(numero_semaine: :desc).order(:utilisateur_id, :task_id).page(params[:page])
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
        @hebdo = Hebdo.new
        find_utilisateurs
        @tsks = Task.order(:service_id, :groupe_id, :nom)
    end


    ##############
    #   CREATE   #
    ##############
    def create
        # Log action
        log(request.path)

        if params[:hebdo][:week]
            spl = params[:hebdo][:week].split("-")
            if spl.size == 2
                params[:hebdo][:year_id] = spl.first
                params[:hebdo][:numero_semaine] = spl.last[1..]
            end
            params[:hebdo].delete(:week)
        end

        @hebdo = Hebdo.create(hebdo_params)
        if @hebdo.save
            flash[:notice] = "Hebdo créé avec succès"
            redirect_to hebdos_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        # Log action
        log(request.path, I18n.t("hebdos.index.log_update"))

        if params[:hebdo][:week]
            spl = params[:hebdo][:week].split("-")
            if spl.size == 2
                params[:hebdo][:year_id] = spl.first
                params[:hebdo][:numero_semaine] = spl.last[1..]
            end
            params[:hebdo].delete(:week)
        end

        if @hebdo.update(hebdo_params)
            flash[:notice] = "Hebdo Modifié avec succès"    
        else 
            render :edit
        end

        redirect_to hebdos_path
    end

    #############
    #   EDIT    #
    #############
    def edit
        # Log action
        log(request.path, I18n.t("hebdos.index.log_edit"))
        find_utilisateurs
        @tsks = Task.order(:service_id, :groupe_id, :nom)
        
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        # Log action
        log(request.path, I18n.t("hebdos.index.log_destroy"))
        @hebdo.destroy
    end

    private     

    def hebdo_params
        params.require(:hebdo).permit(:utilisateur_id, :task_id, :note, :numero_semaine, :year_id, :week)
    end

    def find_hebdos
        @hebdo = Hebdo.find(params[:id])
    end
 
end
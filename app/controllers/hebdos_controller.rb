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
    end


    ##############
    #   CREATE   #
    ##############
    def create
        # Log action
        log(request.path)
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
        params.require(:hebdo).permit(:numero_semaine, :utilisateur_id, :task_id, :note, :year_id)
    end

    def find_hebdos
        @hebdo = Hebdo.find(params[:id])
    end
 
end
class FermeturesController < ApplicationController
    before_action :check_logged_in
    before_action :find_fermeture, only: [:show, :edit, :update, :destroy]

    def index
        # Log action
        log(request.path)
        if is_super_admin?
            @fermetures = Fermeture.order(date: :desc).order(:service_id).page(params[:page])
        else
            @fermetures = Fermeture.where(service: current_user.utilisateur.service).order(date: :desc).order(:service_id).page(params[:page])
        end
    end


    def show
        # Log action
        log(request.path)
    end


    def new
        # Log action
        log(request.path)
        @fermeture = Fermeture.new
    end
   

    def create
        # Log action
        log(request.path)
        @fermeture = Fermeture.create(fermeture_params)
        if @fermeture.save
            flash[:notice] = "Fermeture créée avec succès"
            redirect_to fermetures_path
        else
            render :new
        end
    end


    def update
        # Log action
        log(request.path, I18n.t("fermetures.index.log_update"))
        if @fermeture.update(fermeture_params)
            flash[:notice] = "Fermeture modifiée avec succès"
            redirect_to fermetures_path
        else 
            render :edit
        end
    end


    def edit
        # Log action
        log(request.path, I18n.t("fermetures.index.log_edit"))
    end


    def destroy
        # Log action
        log(request.path, I18n.t("fermetures.index.log_destroy"))
        @fermeture.destroy
    end


    private

    def fermeture_params
        params.require(:fermeture).permit(:nom, :date, :date_fin, :service_id, :note)
    end
    

    def find_fermeture
        @fermeture = Fermeture.find(params[:id])
    end

end
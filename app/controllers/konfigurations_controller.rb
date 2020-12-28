class KonfigurationsController < ApplicationController
    before_action :find_konfiguration, only: [:show, :edit, :update, :destroy]

    def index
        @konfigurations = Konfiguration.all.order(:key).page(params[:page])
    end


    def show
    end


    def new
        @konfiguration = Konfiguration.new
    end
   

    def create
        @konfiguration = Konfiguration.create(konfiguration_params)
        if @konfiguration.save
            flash[:notice] = "Config créée avec succès"
            redirect_to konfigurations_path
        else
            render :new
        end
    end


    def update
        if @konfiguration.update(konfiguration_params)
            flash[:notice] = "Konfiguration modifiée avec succès"
            redirect_to konfigurations_path
        else 
            render :edit
        end
    end


    def edit
    end


    def destroy
        @konfiguration.destroy
    end


    private

    def konfiguration_params
        params.require(:konfiguration).permit(:key, :value, :description)
    end
    

    def find_konfiguration
        @konfiguration = Konfiguration.find(params[:id])
    end

end
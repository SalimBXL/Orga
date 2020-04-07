class FermeturesController < ApplicationController
    before_action :find_fermeture, only: [:show, :edit, :update, :destroy]

    def index
        @fermetures = Fermeture.order(date: :desc).order(:service_id).page(params[:page])
    end


    def show
    end


    def new
        @fermeture = Fermeture.new
    end
   

    def create
        @fermeture = Fermeture.create(fermeture_params)
        if @fermeture.save
            flash[:notice] = "Fermeture créée avec succès"
            redirect_to fermetures_path
        else
            render :new
        end
    end


    def update
        if @fermeture.update(fermeture_params)
            flash[:notice] = "Fermeture modifiée avec succès"
            redirect_to fermetures_path
        else 
            render :edit
        end
    end


    def edit
    end


    def destroy
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
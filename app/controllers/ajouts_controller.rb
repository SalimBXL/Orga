class AjoutsController < ApplicationController

    def index
        render json: Ajout.last
    end

    def new
        @ajout = Ajout.new
    end
    
    def create
        @ajout = Ajout.create(ajout_params)
        if @ajout.save
            flash[:notice] = "ajout créé avec succès"
            redirect_to ajouts_path
        else
            render :new
        end
    end



    private

    def ajout_params
        params.require(:ajout).permit(:utilisateur, :work1, :work2, :work3, :work4, :work5, :date_lundi)
    end

    
end
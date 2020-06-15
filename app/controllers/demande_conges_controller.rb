class DemandeCongesController < ApplicationController
    before_action :find_demande, only: [:show, :edit, :update, :destroy]

    def index
        @demande_conges = DemandeConge.order(:date, :date_fin, :date_demande).page(params[:page])
    end


    def show
    end


    def new
        @demande_conge = DemandeConge.new
        @demande_conge.utilisateur = current_user.utilisateur
        @demande_conge.date_demande = Date.today
    end
   

    def create
        @demande_conge = DemandeConge.create(demande_params)
        @demande_conge.utilisateur = current_user.utilisateur
        @demande_conge.date_demande = Date.today
        if @demande_conge.save
            flash[:notice] = "Demande créée avec succès"
            redirect_to demande_conges_path
        else
            render :new
        end
    end


    def update
        if @demande_conge.update(demande_params)
            flash[:notice] = "Demande modifiée avec succès"
            redirect_to demande_conges_path
        else 
            render :edit
        end
    end


    def edit
    end


    def destroy
        @demande_conge.destroy
    end


    private

    def demande_params
        params.require(:demande_conge).permit(:date, :date_fin, :date_demande)
    end
    

    def find_demande
        @demande_conge = DemandeConge.find(params[:id])
    end

end
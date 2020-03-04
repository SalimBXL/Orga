class AjoutsController < ApplicationController


    def new
        @utilisateurs = Utilisateur.order(:groupe_id)
        @groupes = Groupe.all
        @works = Work.order(:classe_id, :nom)
        @classes = Classe.all

        @ajout = Ajout.new
        @ajout.utilisateur = -1
        @ajout.date_lundi = Date.today
        @ajout.numero_jour = 1
        @ajout.works = []
    end
    
    def create
        @ajout = Ajout.new
        @ajout.utilisateur = ajout_params[:utilisateur]
        @ajout.date_lundi = ajout_params[:date_lundi]
        #@ajout.works = params[:ajout][:works]

        puts "**********"
        puts "**********"
        
    end



    private

    def ajout_params
        params.require(:ajout).permit(:utilisateur, :works, :date_lundi)
    end

    
end
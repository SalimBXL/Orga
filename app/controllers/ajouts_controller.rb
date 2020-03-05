class AjoutsController < ApplicationController

    def index
        @ajout = Ajout.last
        unless @ajout.nil?
            @utilisateur = Utilisateur.find(@ajout.utilisateur)
            @works = []
            unless @ajout.Work1.nil? 
                @works << @ajout.Work1
            end
            unless @ajout.Work1.nil? 
                @works << @ajout.Work2
            end
            unless @ajout.Work1.nil? 
                @works << @ajout.Work3
            end
            unless @ajout.Work1.nil? 
                @works << @ajout.Work4
            end
            unless @ajout.Work1.nil? 
                @works << @ajout.Work5
            end
        end
    end

    def new
        @utilisateurs = Utilisateur.order(:groupe_id)
        @groupes = Groupe.all
        @works = Work.order(:classe_id, :nom)
        @classes = Classe.all

        @ajout = Ajout.new
        @ajout.utilisateur = -1
        @ajout.date_lundi = Date.today
        @ajout.numero_jour = 1
        
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
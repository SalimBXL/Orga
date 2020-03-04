class NouvelAjoutController < ApplicationController

    def new
        @nouvelAjout = nil
        @utilisateurs = Utilisateur.order(:groupe_id)
        @groupes = Groupe.all
        @works = Work.order(:classe_id, :nom)
        @classes = Classe.all
    end
    
    
end
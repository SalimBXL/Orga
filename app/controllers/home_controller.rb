class HomeController < ApplicationController

    # ACCUEIL
    def index
    end


    def new
        @nouvelAjout = nil
        @utilisateurs = Utilisateur.order(:groupe_id)
        @groupes = Groupe.all
        @works = Work.order(:classe_id, :nom)
        @classes = Classe.all
    end

end
class Api::UtilisateursController < ApiController

    #########
    # INDEX #    Renvoi la liste des utilisateurs
    #########
    def index
        render json: Utilisateur.all
    end

    ########
    # SHOW #    Renvoi les infos d'un utilisateur
    ########
    def show
        render json: Utilisateur.find(params[:id])
    end

end
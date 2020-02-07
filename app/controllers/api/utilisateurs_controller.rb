class Api::UtilisateursController < ApiController

    ########
    # SHOW #    Renvoi les infos d'un utilisateur
    ########
    def show
        render json: Utilisateur.find(params[:id])
    end

end
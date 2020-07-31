class Api::UtilisateursController < ApiController

    #########
    # INDEX #    Renvoi la liste des utilisateurs
    #########
    def index
        render json: Utilisateur.order(:service_id, :groupe_id, :prenom, :nom)
    end


    ########
    # SHOW #
    ########
    def show
        render json: Utilisateur.find(params[:id])
    end

end
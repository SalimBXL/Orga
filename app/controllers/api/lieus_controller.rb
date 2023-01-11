class Api::LieusController < ApiController
    before_action :check_if_user_signed_in

    #########
    # INDEX #    Renvoi la liste des utilisateurs
    #########
    def index
        code = :ok
        currentUser = {
            id: current_user.utilisateur.id,
            fullName: current_user.utilisateur.prenom_nom,
        }
        result = {
            signedIn: user_signed_in?,
            currentUser: currentUser,
            locations: Lieu.all
        }
        render json: result, status: code 
    end

    private

    def check_if_user_signed_in
        unless user_signed_in?
            code = :unauthorized
            result = { 
                error: "Not authorized",
                status: 403
            }
            render json: result, status: code 
        end
    end
end
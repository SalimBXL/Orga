class Api::LieusController < ApiController
    

    #########
    # INDEX #    Renvoi la liste des utilisateurs
    #########
    def index

        unless user_signed_in?
            code = :unauthorized
            result = { 
                error: "Not authorized",
                status: 403
            }
        end

        if user_signed_in?
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
        end
        render json: result, status: code 
    end

end
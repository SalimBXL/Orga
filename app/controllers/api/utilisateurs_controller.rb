class Api::UtilisateursController < ApiController
    before_action :check_if_user_signed_in

    #########
    # INDEX #    Renvoi la liste des utilisateurs
    #########
    def index
        utilisateurs = Utilisateur.order(:service_id, :groupe_id, :prenom, :nom)
        results = []
        utilisateurs.each do |utilisateur|
            result = {
                id: utilisateur.id,
                fullName: utilisateur.prenom_nom,
                details: utilisateur
            }
            results.push(result)
        end
        render json: results, status: :ok
    end


    ########
    # SHOW #
    ########
    def show
        utilisateur = Utilisateur.find(params[:id]) 
        groupe = { id: utilisateur.groupe.id, name: utilisateur.groupe.nom }
        service = { id: utilisateur.service.id, name: utilisateur.service.nom, location: utilisateur.service.lieu.nom }
        userName = { firstname: utilisateur.prenom, lastname: utilisateur.nom }
        result = {
            id: utilisateur.id,
            fullName: utilisateur.prenom_nom,
            name: userName,
            email: utilisateur.email, 
            phone: utilisateur.phone,
            gsm: utilisateur.gsm,
            groupe: groupe,
            service: service,
            updated: utilisateur.updated_at
        }
        render json: result, status: :ok
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
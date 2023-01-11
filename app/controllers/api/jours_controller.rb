class Api::JoursController < ApiController
    before_action :check_if_user_signed_in

    #########
    # INDEX #
    #########
    def index
        render json: Jour.order(:date, :service_id, :utilisateur_id, :am_pm)
    end


    ########
    # SHOW #
    ########
    def show
        jour = Jour.find(params[:id])
        groupe = { id: jour.utilisateur.groupe.id, name: jour.utilisateur.groupe.nom }
        utilisateur = { id: jour.utilisateur.id, fullName: jour.utilisateur.prenom_nom }
        service = { id: jour.utilisateur.service.id, name: jour.utilisateur.service.nom, location: jour.utilisateur.service.lieu.nom }
        date = { week: jour.numero_semaine, date: jour.date, day: jour.numero_jour, morning: jour.am_pm }
        result = {
            user: utilisateur,
            groupe: groupe,
            service: service,
            date: date,
            note: jour.note,
            updated: jour.updated_at
        }
        render json: result, status: :ok
    end

    private

    def check_if_user_signed_in
        unless user_signed_in?
            code = :unauthorized
            result = { error: "Not authorized", status: 403 }
            render json: result, status: code 
        end
    end

end
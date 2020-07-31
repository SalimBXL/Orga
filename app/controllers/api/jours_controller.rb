class Api::JoursController < ApiController

    #########
    # INDEX #    Renvoi la liste des utilisateurs
    #########
    def index
        render json: Jour.order(:date, :service_id, :utilisateur_id, :am_pm)
    end


    ########
    # SHOW #
    ########
    def show
        render json: Jour.find(params[:id])
    end

end
class Api::ServicesController < ApiController

    #########
    # INDEX #    Renvoi la liste des utilisateurs
    #########
    def index
        render json: Service.all
    end

end
class Api::GroupesController < ApiController

    #########
    # INDEX #    Renvoi la liste des utilisateurs
    #########
    def index
        render json: Groupe.all
    end

end
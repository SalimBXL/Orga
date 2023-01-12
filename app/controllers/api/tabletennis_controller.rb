class Api::TabletennisController < ApiController

    def ping(texte = 'Into API Pong !')
        render json: {response: texte}, staus: :ok
    end
end
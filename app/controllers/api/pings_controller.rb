class Api::PingsController < ApiController

    def ping(texte = 'Into API Pong !')
        render json: {response: texte}, staus: :ok
    end
    
end
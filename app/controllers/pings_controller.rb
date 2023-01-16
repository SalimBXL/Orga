class PingsController < ApiController

    def ping(texte = 'Into API Pong !')
        render json: {response: "alive"}, staus: :ok
    end
    
end
class Api::TableTennisController < ApiController
    def ping(texte = 'Into API Pong !')
        render json: {response: texte}
    end
end
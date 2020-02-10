class TableTennisController < ApplicationController
    def ping
        texte = 'Not API Pong !'
        render json: {response: texte}
    end
end
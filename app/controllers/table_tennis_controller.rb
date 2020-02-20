class TableTennisController < ApplicationController
    def ping
        texte = 'Not API Pong !'
        render json: {response: texte}
    end

    def ping_api
        #reponse = redirect_to :controller => 'api/table_tennis', :action => 'ping'
        reponse = render :controller => 'api/table_tennis', :action => 'ping'
        render json: {response: "YO"}
    end
end
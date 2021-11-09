class HelpController < ApplicationController
    before_action :check_logged_in

    # ACCUEIL
    def index
        @administrators = Utilisateur.where(admin: true)
        render 'index' and return unless session[:page_aide]
        render session[:page_aide]
    end

end
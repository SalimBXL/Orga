class HelpController < ApplicationController

    # ACCUEIL
    def index
        render 'index' and return unless session[:page_aide]
        render session[:page_aide]
    end

end
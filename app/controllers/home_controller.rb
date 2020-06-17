class HomeController < ApplicationController

    # ACCUEIL
    def index
        fichier = "app/../last_git_date.txt"
        if File.exist?(fichier)
            @last_git_date = format_last_git_date(File.read(fichier))
        else
           @last_git_date = nil
        end
    end

    # ADMIN
    def admin
        
    end

    private 

    def format_last_git_date(dt)
        formatted = dt
        unless dt.nil?
            formatted = dt.split[1..-2]
        end
        formatted.to_sentence
    end

end
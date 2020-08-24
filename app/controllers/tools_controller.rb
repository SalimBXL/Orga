class ToolsController < ApplicationController

    # ACCUEIL
    def index
        # Log action
        log(request.path)
    end

    def check_days
        @problemes = Array.new

        # on fait la liste des days
        jours = Jour.all

        # pour chaque day, on vérifie s'il y a au moins une working_list
        if jours
            jours.each do |jour|
                working_lists = jour.working_lists
                @problemes << jour if working_lists.count <1
            end
        end

        # si la liste des problèmes ext plus grande que 0, on affiche.

    end

    private 



end
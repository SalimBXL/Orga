class ApiController < ActionController::API

    # FACTORISATION des comportements communs

    def format_numero_semaine(annee, numero_semaine)
        numero_semaine<10 ? "#{annee}-W0#{numero_semaine}" : "#{annee}-W#{numero_semaine}"
    end

    def prenom_nom(utilisateur)
        utilisateur !=nil ? "#{utilisateur.prenom} #{utilisateur.nom}".titleize : "???"
    end
    
end
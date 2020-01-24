module ApplicationHelper

    def prenom_nom(utilisateur)
        utilisateur !=nil ? "#{utilisateur.prenom} #{utilisateur.nom}".titleize : "???"
    end

    def initiales(utilisateur)
        utilisateur !=nil ? "#{utilisateur.prenom[0]}#{utilisateur.nom[0]}".upcase : "???"
    end

    def am_pm(valeur)
        valeur ? "PM" : "AM"
    end
end

module ApplicationHelper
    def prenom_nom(utilisateur)
        utilisateur !=nil ? "#{utilisateur.prenom} #{utilisateur.nom}".titleize : "???"
    end
end

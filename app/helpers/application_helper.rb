module ApplicationHelper
    def prenom_nom(utilisateur)
        "#{utilisateur.prenom} #{utilisateur.nom}".titleize
    end
end

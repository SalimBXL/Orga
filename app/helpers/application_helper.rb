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

    def select_option_tag(label, id, model_id)
        if (id == model_id)
            content_tag(:option, label, selected: "selected", value: id)
        else
            content_tag(:option, label, value: id)
        end
    end

    def nom_jour(numero)
        case numero
        when 1
            nom_jour = "Lundi"
        when 2
            nom_jour = "Mardi"
        when 3
            nom_jour = "Mercredi"
        when 4
            nom_jour = "Jeudi"
        when 5
            nom_jour = "Vendredi"
        else
            nom_jour = nil
        end
    end
end

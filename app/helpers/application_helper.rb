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
end

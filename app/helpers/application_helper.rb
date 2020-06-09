module ApplicationHelper

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
            nom_jour = I18n.t("Lundi")
        when 2
            nom_jour = I18n.t("Mardi")
        when 3
            nom_jour = I18n.t("Mercredi")
        when 4
            nom_jour = I18n.t("Jeudi")
        when 5
            nom_jour = I18n.t("Vendredi")
        else
            nom_jour = nil
        end
    end

    def formatWorkListe(liste)
        etiquette = ""
        liste.each do |item|
            etiquette += ", #{item.work.code}"
        end
        return etiquette
    end

    def numeroSemaineAujourdhui
        "#{Date.today.year}-W#{Date.today.cweek<10 ? "0" : ""}#{Date.today.cweek}" 
    end

    def numeroSemainePourDate(date)
        "#{date.year}-W#{date.cweek<10 ? "0" : ""}#{date.cweek}" 
    end

end

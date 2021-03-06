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

    def nom_mois(numero)
        case numero
        when 1
            nom_jour = I18n.t("Janvier")
        when 2
            nom_jour = I18n.t("Fevrier")
        when 3
            nom_jour = I18n.t("Mars")
        when 4
            nom_jour = I18n.t("Avril")
        when 5
            nom_jour = I18n.t("Mai")
        when 6
            nom_jour = I18n.t("Juin")
        when 7
            nom_jour = I18n.t("Juillet")
        when 8
            nom_jour = I18n.t("Aout")
        when 9
            nom_jour = I18n.t("Septembre")
        when 10
            nom_jour = I18n.t("Octobre")
        when 11
            nom_jour = I18n.t("Novembre")
        when 12
            nom_jour = I18n.t("Decembre")
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

    def after_login
        if user_signed_in?
            current_user.last_connection = DateTime.current()
            current_user.save
            puts "***** >>>> USER LOGGED IN - #{current_user.utilisateur.prenom_nom} <<<<< *****"
        end
    end

    

end

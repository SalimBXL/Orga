class AgendasController < ApplicationController
    before_action :find_debut_fin, only: [:absences, :semaines, :jours, :jours]

    # ACCUEIL
    def index
        @numero_semaine_today = "#{Date.today.year}-W#{Date.today.cweek<10 ? "0" : ""}#{Date.today.cweek}"
    end

    # ALL AGENDAS
    def all
    end
    
    # ABSENCES
    def absences
        @absences = Absence.where(date: @date_depart..@date_fin)
    end

    


    private

    def find_numero_semaine
        if !params[:semaine].nil? && params[:semaine].length==8 && params[:semaine][-2..-1]!="00"
            @numero_semaine = params[:semaine]
            annee = params[:semaine][0..3].to_i
            semaine = params[:semaine][-2..-1].to_i
            @date_depart = Date.commercial(annee, semaine, 1)
            @date_fin = Date.commercial(annee, semaine, 5)
        else
            @numero_semaine = format_numero_semaine(Date.today.year, Date.today.cweek)
            @date_depart = Date.today.beginning_of_week
            @date_fin = @date_depart + 4.days
        end
    end

    def find_date_jour
        if !params[:jour].nil? && params[:jour].length==10 && params[:jour][-3]=="-"
            @date_jour = Date.parse(params[:jour])
        else
            @date_jour = Date.today
        end
        if @date_jour.cwday==6
            @date_jour = @date_jour + 2
        end
        if @date_jour.cwday==7
            @date_jour = @date_jour - 2
        end
        if !params[:service_courant].nil?
            @service_courant = params[:service_courant].to_i
        else
            @service_courant = -1
        end
    end
    
    def find_debut_fin
        unless params[:semaine].nil?
            @vue_semaine = true
            annee = params[:semaine][0..3].to_i
            semaine = params[:semaine][-2..-1].to_i
            @date_depart = Date.commercial(annee, semaine, 1)
            @date_fin = Date.commercial(annee, semaine, 5)
        else
            @vue_semaine = false
            @date_depart = Date.today.beginning_of_year - 3.months
            @date_fin = Date.today.end_of_year + 3.months
        end
    end

    def find_annee
        unless params[:annee].nil?
            @annee = params[:annee].to_i
        else
            @annee = Date.today.year
        end
        @date_depart = Date.parse("#{@annee}-01-01")
        @date_fin = Date.parse("#{@annee}-12-31")
    end

    def format_numero_semaine(annee, numero_semaine)
        numero_semaine<10 ? "#{annee}-W0#{numero_semaine}" : "#{annee}-W#{numero_semaine}"
    end
    

end
class AgendasController < ApplicationController

    # ACCUEIL
    def index
    end

    # ALL AGENDAS
    def all
    end
    
    # ABSENCES
    def absences
        @date_depart = Date.today.beginning_of_year - 3.months
        date_fin = Date.today.end_of_year + 3.months
        @absences = Absence.where(date: @date_depart..date_fin)
    end

    # CONGES
    def conges
        @date_depart = Date.today.beginning_of_year - 3.months
        date_fin = Date.today.end_of_year + 3.months
        @conges = Conge.where(date: @date_depart..date_fin)
    end

    # SEMAINES
    def semaines
        @semaines = Semaine.order(numero_semaine: :desc, slug: :asc).page(params[:page])
    end

    # JOBS
    def jobs
        @jobs = Job.where().order(semaine_id: :desc).order(:numero_jour, :am_pm).page(params[:page])
    end

end
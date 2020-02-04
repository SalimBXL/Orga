class AgendasController < ApplicationController

    # ACCUEIL
    def index
    end

    # ALL AGENDAS
    def all
    end
    
    # ABSENCES
    def absences
        @absences = Absence.order(:date).order(:type_absence_id).page(params[:page])
        @current_absences = Absence.where(date: (Date.today-3.months)..(Date.today+9.month))
    end

    # CONGES
    def conges
        @conges = Conge.order(date: :desc).order(:accord).page(params[:page])
        @current_conges = Conge.where(date: (Date.today-3.months)..(Date.today+9.month))
    end

    # SEMAINES
    def semaines
        @semaines = Semaine.order(numero_semaine: :desc, slug: :asc).page(params[:page])
    end

end
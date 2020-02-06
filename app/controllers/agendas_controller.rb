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
        @date_depart = Date.today.beginning_of_year - 3.months
        date_fin = Date.today.end_of_year + 3.months
        @semaines = Semaine.where(date_lundi: @date_depart..date_fin)
    end

    # JOBS
    def jobs
        @jobs = Hash.new
        @date_depart = Date.today.beginning_of_year - 3.months
        date_fin = Date.today.end_of_year + 3.months
        semaines = Semaine.where(date_lundi: @date_depart..date_fin)
        semaines.each do |semaine|
            jobs = Job.where(semaine: semaine)
            7.times do |n|
                numero_jour = n+1
                key = "#{semaine.numero_semaine}_#{numero_jour}"
                unless @jobs.key?(key)
                    @jobs[key] = Array.new    
                end
                @jobs[key] << jobs.where(numero_jour: numero_jour)
            end
        end
    end

    # JOURS
    def jours
        @jobs = Hash.new
        @date_depart = Date.today.beginning_of_year - 3.months
        date_fin = Date.today.end_of_year + 3.months
        @absences = Absence.where(date: @date_depart..date_fin)
        @conges = Conge.where(date: @date_depart..date_fin)
        semaines = Semaine.where(date_lundi: @date_depart..date_fin)
        semaines.each do |semaine|
            jobs = Job.where(semaine: semaine)
            7.times do |n|
                numero_jour = n+1
                key = "#{semaine.numero_semaine}_#{numero_jour}"
                unless @jobs.key?(key)
                    @jobs[key] = Array.new    
                end
                @jobs[key] << jobs.where(numero_jour: numero_jour)
            end
        end
    end

end
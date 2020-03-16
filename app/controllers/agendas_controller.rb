class AgendasController < ApplicationController
    before_action :find_debut_fin, only: [:absences, :conges, :semaines, :jobs, :jours]
    before_action :find_numero_semaine, only: :une_semaine

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

    # CONGES
    def conges
        @conges = Conge.where(date: @date_depart..@date_fin)
    end

    # SEMAINES
    def semaines
        @semaines = Semaine.where(date_lundi: @date_depart..@date_fin)

        @conges = Hash.new
        Conge.where(date: @date_depart..@date_fin).each do |conge|
            key = format_numero_semaine(conge.date.year, conge.date.cweek)
            unless @conges.has_key?(key)
                @conges[key] = Hash.new
            end
            unless @conges[key].has_key?(conge.utilisateur.id)
                @conges[key][conge.utilisateur.id] = []
            end
            @conges[key][conge.utilisateur.id] << conge
        end

        @absences = Hash.new
        Absence.where(date: @date_depart..@date_fin).each do |absence|
            key = format_numero_semaine(absence.date.year, absence.date.cweek)
            unless @absences.has_key?(key)
                @absences[key] = Hash.new
            end
            unless @absences[key].has_key?(absence.utilisateur.id)
                @absences[key][absence.utilisateur.id] = []
            end
            @absences[key][absence.utilisateur.id] << absence
        end
    end

    # JOBS
    def jobs
        @jobs = Hash.new
        semaines = Semaine.where(date_lundi: @date_depart..@date_fin)
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

    # SEMAINE (pour une seule semaine...)
    def une_semaine
        @semaines = Semaine.where(numero_semaine: @numero_semaine)
        @conges = Conge.where(date: @date_depart..@date_fin)
        @works = Work.all
        @semaines = Semaine.where(numero_semaine: @numero_semaine)
    end

    # JOUR (pour un seul jour...)
    def un_jour
        @absences = []
        @conges = []
        Absence.where(date: Date.today).each do |absence|
            @absences << absence.utilisateur
        end
        Conge.where(date: Date.today).each do |conge|
            @conges << conge.utilisateur
        end
        @jobs = Hash.new
        numero_jour_aujourdhui = Date.today.cwday
        numero_semaine = format_numero_semaine(Date.today.year, Date.today.cweek)
        semaines = Semaine.where(numero_semaine: numero_semaine)
        semaines.each do |semaine|
            jobs = Job.where(semaine: semaine, numero_jour: numero_jour_aujourdhui).order(:am_pm)
            jobs.each do |job|
                key = semaine.utilisateur
                unless @jobs.key?(key)
                    @jobs[key] = []
                end
                @jobs[key] << job
            end
        end
    end

    # JOURS (pour PLUSIEURS jours...)
    def jours
        @jobs = Hash.new
        @absences = Absence.where(date: @date_depart..@date_fin)
        @conges = Conge.where(date: @date_depart..@date_fin)
        semaines = Semaine.where(date_lundi: @date_depart..@date_fin)
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

    private

    def find_numero_semaine
        unless params[:semaine].nil?
            @numero_semaine = params[:semaine]
            annee = params[:semaine][0..3].to_i
            semaine = params[:semaine][-2..-1].to_i
            @date_depart = Date.commercial(annee, semaine, 1)
            @date_fin = Date.commercial(annee, semaine, 5)
        else
            @numero_semaine = format_numero_semaine(Date.today.year, Date.today.cweek)
            @date_depart = Date.today.beginning_of_week
            @date_fin = @date_depart + 5.days
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


    def format_numero_semaine(annee, numero_semaine)
        numero_semaine<10 ? "#{annee}-W0#{numero_semaine}" : "#{annee}-W#{numero_semaine}"
    end

end
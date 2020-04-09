class AgendasController < ApplicationController
    before_action :find_debut_fin, only: [:absences, :conges, :semaines, :jobs, :jours]
    before_action :find_numero_semaine, only: :une_semaine
    before_action :find_date_jour, only: :un_jour
    before_action :find_annee, only: :conges_absences

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

    # CONGES & ABSENCES
    def conges_absences
        @absences = Hash.new
        @conges_ok = Hash.new
        @conges_wait = Hash.new
        @utilisateurs = Hash.new

        premier = Date.parse("#{@annee}-01-01")

        Utilisateur.order(:service_id, :groupe_id, :prenom, :nom).each do |utilisateur|
            @utilisateurs[utilisateur.id] = utilisateur
        end
        absences = Absence.where("date >= ? OR date_fin <= ?", premier.beginning_of_year, premier.end_of_year).order(:utilisateur_id, :date)
        conges = Conge.where("date >= ? OR date_fin <= ?", premier.beginning_of_year, premier.end_of_year).order(:utilisateur_id, :date)

        
        absences.each do |absence|
            unless @absences.has_key?(absence.utilisateur_id)
                @absences[absence.utilisateur_id] = Array.new
            end
            (((absence.date_fin - absence.date).to_i) + 1).times do |tour|
                jour = absence.date + tour
                @absences[absence.utilisateur_id] << jour.to_s
            end
        end


        conges_ok = conges.where(accord: true)
        conges_wait = conges.where(accord: false)
        
        conges_ok.each do |conge|
                unless @conges_ok.has_key?(conge.utilisateur_id)
                    @conges_ok[conge.utilisateur_id] = Array.new
                end
                (((conge.date_fin - conge.date).to_i) + 1).times do |tour|
                    jour = conge.date + tour
                    @conges_ok[conge.utilisateur_id] << jour.to_s
                end
        end
        conges_wait.each do |conge|
            unless @conges_wait.has_key?(conge.utilisateur_id)
                @conges_wait[conge.utilisateur_id] = Array.new
            end
            (((conge.date_fin - conge.date).to_i) + 1).times do |tour|
                jour = conge.date + tour
                @conges_wait[conge.utilisateur_id] << jour.to_s
            end
        end
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
        @works = Work.all
        @conges = Hash.new
        (@date_depart..@date_fin).each do |d|
            a = Conge.where("date <= ? AND date_fin >= ?", d, d)
            a.each do |item|
                if !@conges.key?(item.utilisateur)
                    @conges[item.utilisateur] = Array.new
                end
                if !@conges[item.utilisateur].include?(d)
                    @conges[item.utilisateur] << d.to_s
                end
            end
        end
        @absences = Hash.new
        (@date_depart..@date_fin).each do |d|
            a = Absence.where("date <= ? AND date_fin >= ?", d, d)
            a.each do |item|
                if !@absences.key?(item.utilisateur)
                    @absences[item.utilisateur] = Array.new
                end
                if !@absences[item.utilisateur].include?(d)
                    @absences[item.utilisateur] << d.to_s
                end
            end
        end
    end

    # JOUR (pour un seul jour...)
    def un_jour
        @services = Hash.new
        srvs = Service.order(:nom)
        @services[-1] = "---"
        

        @absences = []
        @conges = []
        @jobs = Hash.new
        [false, true].each do |ap|
            unless @jobs.key?(ap)
                @jobs[ap] = Hash.new
            end
        end
        Absence.where("date <= ? AND date_fin >= ?", @date_jour, @date_jour).each do |absence|
            @absences << absence
        end
        Conge.where("date <= ? AND date_fin >= ?", @date_jour, @date_jour).each do |conge|
            @conges << conge
        end
        numero_jour_aujourdhui = @date_jour.cwday
        numero_semaine = format_numero_semaine(@date_jour.year, @date_jour.cweek)
        semaines = Semaine.where(numero_semaine: numero_semaine)
        semaines.each do |semaine|
            [false, true].each do |ap|
                jobs = Job.where(semaine: semaine, numero_jour: numero_jour_aujourdhui, am_pm: ap)
                jobs.each do |job|
                    key = semaine.utilisateur
                    unless @jobs[ap].key?(key)
                        @jobs[ap][key] = Array.new
                    end
                    job.working_lists.each do |wl|
                        service = wl.work.service
                        @services[service.id] = service.nom
                    end
                    @jobs[ap][key] << job
                end
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
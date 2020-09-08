class HomeController < ApplicationController

    # ACCUEIL
    def index
        session[:page_aide] = "index"
        
        # Log action
        log(request.path)

        fichier = "app/../last_git_date.txt"
        if File.exist?(fichier)
            @last_git_date = format_last_git_date(File.read(fichier))
        else
           @last_git_date = nil
        end

        # Charge le cache
        if user_signed_in?
            find_utilisateurs if @utilisateurs.nil?
            find_groupes if @groupes.nil?
            find_works if @works.nil?
            find_classes if @classes.nil?
            find_services if @services.nil?
        end

        # Check les jobs du user courant
        get_today if user_signed_in?
    end

    private 

    def format_last_git_date(dt)
        formatted = dt
        unless dt.nil?
            formatted = dt.split[1..-2]
        end
        formatted.to_sentence
    end


    def get_today
        # Log action
        log(request.path, "Get Horaire du jour")
        @specific_day_works = Hash.new
        @absence = Hash.new

        # Détermine la date
        date = Date.today
        @specific_day_jours = Jour.today_of(current_user.utilisateur.id).select([:id, :utilisateur_id, :service_id, :am_pm, :note]).includes(utilisateur: :groupe)

        # Parse les jours
        @specific_day_jours.each do |jour|
            @specific_day_works[jour] = WorkingList.for(jour).includes(:work)
        end

        # Check les absences
        @absence = false
        abs = Absence.today_for_user(current_user.utilisateur)
        if abs.count > 0
            @absence = abs
        end


        # Charge les Events
        @events = Hash.new
        charge_events(@date)
        
    end
end
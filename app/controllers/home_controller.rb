class HomeController < ApplicationController

    # ACCUEIL
    def index
        session[:page_aide] = "index"
        
        # Log action
        log(request.path)

        fichier = "app/../last_git_date.txt"
        @last_git_date = File.exist?(fichier) ? format_last_git_date(File.read(fichier)) : @last_git_date = nil

        # Check les jobs du user courant
        get_today if user_signed_in?

        #check les postits
        get_postits if user_signed_in?

        # Charge les dernières connections 
        get_lasts_connected if user_signed_in?

        # Nombre de bugs en attente
        get_bugs_in_queue if user_signed_in? 
        
    end

    private

    def get_bugs_in_queue
        if is_super_admin?
            @bugs_new = BugRepport.where(status: "outlined_flag").size
            @bugs_test = BugRepport.where(status: "sync_problem").size
        end
    end

    def get_postits
        @postits = Postit.order(level: :desc)
    end

    def format_last_git_date(dt)
        formatted = dt
        unless dt.nil?
            formatted = dt.split[1..-2]
        end
        formatted.to_sentence
    end

    def get_lasts_connected
        if is_super_admin?
            @last_connects = User.where.not(last_connection: nil).order(last_connection: :desc).limit(5)
        end
    end

    def get_today
        # Log action
        log(request.path, "Get Horaire du jour")
        @specific_day_works = Hash.new
        @absence = Hash.new

        # Détermine la date
        @specific_day_jours = Jour.today_of(current_user.utilisateur.id)

        # Parse les jours
        @specific_day_jours.each do |jour|
            @specific_day_works[jour] = WorkingList.for(jour)
        end

        # Check les absences
        @absence = false
        abs = Absence.today_for_user(current_user.utilisateur)
        if abs.count > 0
            @absence = abs
        end

        # Charge les Events
        @events = Hash.new
        charge_events(Date.today, current_user.utilisateur.service)

        # Charge les messages
        @messages = Array.new
        charge_messages(Date.today)

        # Charge les tâches
        find_tasks(current_user.utilisateur, true)
    end
end
class HomeController < ApplicationController

    # ACCUEIL
    def index
        session[:page_aide] = "index"
        
        # Log action
        log(request.path)

        fichier = "app/../last_git_date.txt"
        @last_git_date = File.exist?(fichier) ? format_last_git_date(File.read(fichier)) : @last_git_date = nil


        redirect_to "/users/sign_in" unless user_signed_in?

        # Check les jobs du user courant
        get_today if user_signed_in?

        

        # check les postits
        get_postits if user_signed_in?

        # check si maintenance dans les quinzes prochains jours
        get_maintenances if user_signed_in?



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
        @postits = Postit.order(level: :desc).to_a
    end

    def get_maintenances
        @maintenances = Maintenance.where("DATE_START <= ? AND DATE_END >= ?", Date.today + 15.days, Date.today).order(:date_start, :date_end)
        #@postits = @postits.to_a
        @maintenances.each do |maintenance|
            if maintenance.isWithinTwoWeeks? or maintenance.isWithinFiveDays?
                if !maintenance.isToday?
                    ressource = maintenance.maintenance_ressource
                    delay = "two weeks" if maintenance.isWithinTwoWeeks?
                    delay = "five days" if maintenance.isWithinFiveDays?
                    level = 3 if maintenance.isWithinTwoWeeks?
                    level = 4 if maintenance.isWithinFiveDays?

                    created = DateTime.now()
                    depart = maintenance.date_start
                    utilisateur = Utilisateur.find(maintenance.contact_id)
                    taken = utilisateur
                    titre = "MAINTENANCE"
                    service = maintenance.maintenance_ressource.service
                    id = -1

                    message = "(#{depart}) Maintenance #{ressource.name} in less than #{delay}."
                    
                    postit = Postit.new(
                        id: id, 
                        title: titre, 
                        body: message, 
                        level: level, 
                        utilisateur: utilisateur, 
                        taken: utilisateur, 
                        service: service,
                        created_at: created
                    )
                    @postits.unshift(postit)
                end
            end
        end
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
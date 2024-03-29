class JoursController < ApplicationController
    before_action :check_logged_in
    before_action :find_jour, only: [:show, :edit, :update, :destroy]
    before_action :read_konfig, only: [:specific_month, :secr_pet]

    #############
    #   INDEX   #
    #############
    def index
        log(request.path)
        session[:return_user_id] = nil

        @jours = is_super_admin? ? Jour.order(numero_semaine: :desc).order(numero_jour: :desc).order(:service_id, :am_pm, :utilisateur_id).page(params[:page]) : @jours = Jour.where(service: current_user.utilisateur.service).order(numero_semaine: :desc).order(numero_jour: :desc).order(:service_id, :am_pm, :utilisateur_id).page(params[:page])
    end


    #############
    #   SHOW    #
    #############
    def show
        log(request.path)
    end


    #############
    #    NEW    #
    #############
    def new
        log(request.path)
        @jour = Jour.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        log(request.path)
        @jour = Jour.create(jour_params)
        
        if @jour.save
            flash[:notice] = "Jour créé avec succès"
            redirect_to jours_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        log(request.path, I18n.t("jours.index.log_update"))

        # Swap batch entre deux users
        if params[:swap]
            user1 = Utilisateur.find(params[:swap].to_i) if params[:swap]
            user2 = Utilisateur.find(params[:jour][:utilisateur_id].to_i)
            job1 = @jour
            job2 = Jour.where(utilisateur_id: user2.id, date: @jour.date, am_pm: @jour.am_pm).first

            ## Repart vers la page edit si on a pas les deux utilisateurs
            render :edit unless user1 and user2

            ## Si on a pas de job pour le second user, 
            ## on effectue un simple update
            ## Sinon on update d'abord le second, puis update normal.
            job1.utilisateur_id = user2.id
            if job1.update(utilisateur_id: user2.id)
                # ok
                if job2
                    job2.utilisateur_id = user1.id
                    if job2.update(utilisateur_id: user1.id)
                        flash[:notice] = "Jour Modifié avec succès"
                    else 
                        :edit
                    end
                end
            else
                flash[:notice] = "Un problème a été rencontré !"
                render :edit
            end
        end
            
        # Update normal
        if @jour.update(jour_params)
            flash[:notice] = "Jour Modifié avec succès"    
        else 
            render :edit
        end

        if params[:swap]
            redirect_to utilisateur_path(user1)
        else 
            #redirect_to jours_path
            redirect_to utilisateur_path(@jour.utilisateur_id)
        end
    end

    #############
    #   EDIT    #
    #############
    def edit
        log(request.path, I18n.t("jours.index.log_edit"))
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        log(request.path, I18n.t("jours.index.log_destroy"))
        @jour.destroy
    
        if !session[:return_user_id].blank? or !session[:return_user_id].nil?
            tmp = session[:return_user_id]
            session[:return_user_id] = nil
            redirect_to utilisateur_path(id: tmp)
        end

    end


    #############
    #   TODAY   #
    #############
    def specific_day
        log(request.path)
        @specific_day_works = Hash.new
        @absence = Hash.new

        # Détermine la date
        unless params[:date]
            @date = Date.today
            specific_day_jours = Jour.today.order(:utilisateur_id).select([:id, :utilisateur_id, :service_id, :am_pm, :note]).includes(utilisateur: :groupe)
        else
            @date = params[:date].to_date
            specific_day_jours = Jour.at_day(@date).order(:utilisateur_id).select([:id, :utilisateur_id, :service_id, :am_pm, :note]).includes(utilisateur: :groupe)
        end

        # Check les absences
        Absence.where('date_fin >= ? AND date <= ?', @date, @date).order(:utilisateur_id, :date, :date_fin).each do |absence|
            @absence[absence.utilisateur] = absence
        end
        specific_day_jours.each do |jour|
            @absence[jour.utilisateur] ||= nil
        end

        # Charge les tasks pour la journée
        @hebdos = Hash.new
        h = Hebdo.where(numero_semaine: @date.cweek)
        h.each do |hh|
            @hebdos[hh.utilisateur] ||= Array.new
            noeud = Array.new
            noeud << hh.task.code
            noeud << hh.task.nom
            @hebdos[hh.utilisateur] << [noeud, hh.utilisateur.prenom_nom]
        end
        
        
        # Parse les jours
        @specific_day_jours = Hash.new
        specific_day_jours.each do |jour|
            @specific_day_jours[jour.service] ||= Hash.new
            @specific_day_jours[jour.service][jour.utilisateur] ||= Hash.new
            @specific_day_jours[jour.service][jour.utilisateur][jour.am_pm] ||= Array.new
            @specific_day_jours[jour.service][jour.utilisateur][jour.am_pm] = WorkingList.for(jour.id).includes(:work)
            @specific_day_jours[jour.service][jour.utilisateur]["notes"] ||= Hash.new
            @specific_day_jours[jour.service][jour.utilisateur]["notes"][jour.am_pm] = jour.note
            find_tasks(jour.utilisateur)
            @specific_day_jours[jour.service][jour.utilisateur][:task] = @tasks[@date.cweek]
        end

        # Charges les services
        if is_super_admin?
            @services = Service.order(:lieu_id, :nom)
        else
            @services = current_user.utilisateur.services
        end
            
        # @services = Array.new
        # @services.push(current_user.utilisateur.service)
        # current_user.utilisateur.services.each do |s|
        #     @services.push(s.service)
        # end
        #find_services if @services.nil?

        # Charge les Events
        @events = Hash.new
        charge_events(@date)
 
    end

    ############
    #   Month   #
    ############
    def specific_month
        # Log action
        log(request.path)

        # Réglage des dates de début et fin de période
        unless params[:date]
            date_tmp = Date.today
        else
            date_tmp = params[:date].to_date
        end
        if date_tmp.beginning_of_month.cwday == 7
            date_tmp = date_tmp.beginning_of_month + 1.day
        elsif date_tmp.beginning_of_month.cwday == 6
            date_tmp = date_tmp.beginning_of_month + 2.days
        else
            date_tmp = date_tmp.beginning_of_month
        end
        @date = date_tmp.beginning_of_week
        @date2 = date_tmp.end_of_month.end_of_week

        @jours = Hash.new

        # Liste des utilisateurs
        utilisateurs = Utilisateur.order(:service_id, :groupe_id, :prenom, :nom)
        utilisateurs.each do |utilisateur|
            @jours[utilisateur.service] ||= Hash.new
            @jours[utilisateur.service][utilisateur.groupe] ||= Hash.new
            @jours[utilisateur.service][utilisateur.groupe][utilisateur] ||= Hash.new
        end

        # Liste des attributions
        utilisateurs_jours = Jour.where(date: @date..@date2).order(:service_id, :utilisateur_id, :date, :am_pm)
        utilisateurs_jours.each do |utilisateur_jour|
            unless @jours[utilisateur_jour.service].nil?
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur.groupe] ||= Hash.new
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur.groupe][utilisateur_jour.utilisateur] ||= Hash.new
                dd = utilisateur_jour.date.to_s
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur.groupe][utilisateur_jour.utilisateur][dd] ||= Hash.new
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur.groupe][utilisateur_jour.utilisateur][dd][utilisateur_jour.am_pm] = WorkingList.for(utilisateur_jour.id).includes(:work)
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur.groupe][utilisateur_jour.utilisateur][dd]["notes"] ||= Hash.new
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur.groupe][utilisateur_jour.utilisateur][dd]["notes"][utilisateur_jour.am_pm] = utilisateur_jour.note
            end
        end

        # Charges les jobs tous services confondus
        jobs_autre_jours = Jour.where(date: @date..@date2).order(:utilisateur_id, :service_id, :date, :am_pm)
        @job_autre ||= Hash.new
        jobs_autre_jours.each do |job|
            @job_autre[job.utilisateur_id] ||= Hash.new
            dd = job.date.to_s
            @job_autre[job.utilisateur_id][dd] ||= Hash.new
            @job_autre[job.utilisateur_id][dd][job.service.nom] ||= Hash.new
            @job_autre[job.utilisateur_id][dd][job.service.nom][job.am_pm] ||= WorkingList.for(job.id).includes(:work)
        end

        # Charge les fermetures
        charge_fermetures(@date, @date2)        

        # Charge les absences
        @absences = Hash.new
        absences = Absence.where('date_fin >= ? AND date <= ?', @date, @date2).order(:utilisateur_id, :date, :date_fin)
        absences.each do |absence|
            (absence.date..absence.date_fin).each do |aj|
                @absences[absence.utilisateur_id] ||= Hash.new
                @absences[absence.utilisateur_id][aj.to_s] = Array.new
                if @konfiguration[:jours_specific_month]
                    @absences[absence.utilisateur_id][aj.to_s][0] = (absence.type_absence.code.downcase == @konfiguration[:jours_specific_month].downcase) ? "" : absence.type_absence.code 
                    @absences[absence.utilisateur_id][aj.to_s][1] = absence.accord
                    @absences[absence.utilisateur_id][aj.to_s][2] = absence.halfday
                else
                    @absences[absence.utilisateur_id][aj.to_s][0] = absence.type_absence.code
                    @absences[absence.utilisateur_id][aj.to_s][1] = absence.accord
                    @absences[absence.utilisateur_id][aj.to_s][2] = absence.halfday
                end

            end
        end

        # Charges les services
        if is_super_admin?
            @services = Service.order(:lieu_id, :nom)
        else
            @services = current_user.utilisateur.services
        end
        # @services = Array.new
        # @services.push(current_user.utilisateur.service)
        # current_user.utilisateur.services.each do |s|
        #     @services.push(s.service)
        # end
        #find_services if @services.nil?

        # Charge les Events
        @events = Hash.new
        nombre_de_jours = (@date2-@date).to_i
        nombre_de_jours.times do |i|
            charge_events((@date + i.day))
        end

        @templates = Template.all.order(:service_id, :nom)
        @service = Array.new
        Service.all.order(:nom).each {|service| @service[service.id] = service.nom}

        #
        # trouve les tâches
        #
        utilisateurs.each do |utilisateur|
            @tasks_profil ||= Hash.new
            #@tasks_profil[utilisateur.id] = find_tasks_for_month(utilisateur, @date.month, @date.year)
            #tasks_profil[utilisateur.id]
            hebdos = Hebdo.where('year_id >= ?', @date.year).order(:utilisateur_id, :year_id, :numero_semaine)
            hebdos.each do |hebdo|
                @tasks_profil[hebdo.utilisateur_id] ||= Hash.new
                @tasks_profil[hebdo.utilisateur_id][hebdo.year_id] ||= Hash.new
                @tasks_profil[hebdo.utilisateur_id][hebdo.year_id][hebdo.numero_semaine] ||= Array.new
                @tasks_profil[hebdo.utilisateur_id][hebdo.year_id][hebdo.numero_semaine] << hebdo
            end
        end

        #
        # Trouve mes maintenances
        #
        _maintenances = Maintenance.where("date_start <= ? AND date_end >= ?", @date2, @date).order(:date_start, :name)
        @maintenances ||= Hash.new
        _maintenances.each do |maintenance|
            srv = maintenance.maintenance_ressource.service
            @maintenances[srv] ||= Hash.new
            @maintenances[srv][maintenance.date_start] ||= Array.new
            @maintenances[srv][maintenance.date_start] << maintenance
        end

        # mode edition ?
        unless params[:edit_mode]
            @edit_mode = false
        else
            if params[:edit_mode].downcase == 'true'
                @edit_mode = true
            else
                @edit_mode = false
            end
        end

        # mode new day ?
        unless params[:new_day_mode]
            @new_day_mode = false
        else
            if params[:new_day_mode].downcase == 'true'
                @new_day_mode = true
            else
                @new_day_mode = false
            end
        end


        if user_signed_in? && (is_manager_or_super_admin?)
            find_utilisateurs
            find_classes
            find_works
        end
        
    end

    ############
    #   Week   #
    ############
    def specific_week
        # Log action
        log(request.path)
        unless params[:date]
            @date = Date.today
        else
            @date = params[:date].to_date
        end
        @absences = Hash.new
        @off = Hash.new
        @specific_day_works = Hash.new
        @specific_day_note = Hash.new
        @jours = Hash.new
        utilisateurs_jours = Jour.where(numero_semaine: numeroSemainePourDate(@date)).order(:service_id, :utilisateur_id).select([:utilisateur_id, :service_id]).distinct.includes(:utilisateur, :service)
        utilisateurs_jours.each do |utilisateur_jour|
            @jours[utilisateur_jour.service] ||= Hash.new
            @jours[utilisateur_jour.service][utilisateur_jour.utilisateur] ||= Hash.new
            find_tasks(utilisateur_jour.utilisateur)
            @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][:task] = @tasks
            5.times do |i|
                i += 1
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][i] ||= Hash.new
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][i][false] = Jour.where(numero_semaine: numeroSemainePourDate(@date), numero_jour: i, utilisateur_id: utilisateur_jour.utilisateur_id, service_id: utilisateur_jour.service, am_pm: false).order(:service_id, :utilisateur_id, :numero_jour, :am_pm)
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][i][true] = Jour.where(numero_semaine: numeroSemainePourDate(@date), numero_jour: i, utilisateur_id: utilisateur_jour.utilisateur_id, service_id: utilisateur_jour.service, am_pm: true).order(:service_id, :utilisateur_id, :numero_jour, :am_pm)

                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][i][false].each do |jour|
                    @specific_day_works[jour] = WorkingList.for(jour).includes(:work)
                    @specific_day_note[jour] = jour.note
                end
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][i][true].each do |jour|
                    @specific_day_works[jour] = WorkingList.for(jour).includes(:work)
                    @specific_day_note[jour] = jour.note
                end

                abs = Absence.at_for_user(@date.beginning_of_week+i.days, utilisateur_jour.utilisateur)
                abs.each do |a|
                    @absences[utilisateur_jour.utilisateur] ||= Hash.new
                    @absences[utilisateur_jour.utilisateur][i+1] = Array.new
                    if a.accord
                        @absences[utilisateur_jour.utilisateur][i+1][0] = true
                    else
                        @absences[utilisateur_jour.utilisateur][i+1][0] =  false
                    end
                    if a.halfday
                        @absences[utilisateur_jour.utilisateur][i+1][1] = true
                    else
                        @absences[utilisateur_jour.utilisateur][i+1][1] = false
                    end
                    @absences[utilisateur_jour.utilisateur][i+1][2] = a.type_absence.code.downcase
                end
            end
        end

        charge_fermetures(@date.beginning_of_week, @date.beginning_of_week+5.days)

        # Charge les services
        if is_super_admin?
            @services = Service.order(:lieu_id, :nom)
        else
            @services = current_user.utilisateur.services
        end
        # @services = Array.new
        # @services.push(current_user.utilisateur.service)
        # current_user.utilisateur.services.each do |s|
        #     @services.push(s.service)
        # end

        # Charge les Events
        @events = Hash.new
        5.times do |i|
            charge_events(@date.beginning_of_week+i.day)
        end

        # Charge les tasks pour la semaine
        @hebdos = Hash.new
        h = Hebdo.where(numero_semaine: @date.cweek)
        h.each do |hh|
            @hebdos[hh.utilisateur] ||= Array.new
            noeud = Array.new
            noeud << hh.task.code
            noeud << hh.task.nom
            @hebdos[hh.utilisateur] << [noeud, hh.utilisateur.prenom_nom]
        end
    end


    ################
    #   Secr_pet   #
    ################
    def secr_pet
        # Log action
        log(request.path)

        # Réglage des dates de début et fin de période
        unless params[:date]
            date_tmp = Date.today
        else
            date_tmp = params[:date].to_date
        end
        if date_tmp.beginning_of_month.cwday == 7
            date_tmp = date_tmp.beginning_of_month + 1.day
        elsif date_tmp.beginning_of_month.cwday == 6
            date_tmp = date_tmp.beginning_of_month + 2.days
        else
            date_tmp = date_tmp.beginning_of_month
        end
        @date = date_tmp.beginning_of_week
        @date2 = date_tmp.end_of_month.end_of_week

        @jours = Hash.new

        # Liste des utilisateurs
        utilisateurs = Utilisateur.order(:service_id, :groupe_id, :prenom, :nom)
        utilisateurs.each do |utilisateur|
            @jours[utilisateur.service] ||= Hash.new
            @jours[utilisateur.service][utilisateur.groupe] ||= Hash.new
            @jours[utilisateur.service][utilisateur.groupe][utilisateur] ||= Hash.new
        end

        # Liste des attributions
        utilisateurs_jours = Jour.where(date: @date..@date2).order(:service_id, :utilisateur_id, :date, :am_pm)
        utilisateurs_jours.each do |utilisateur_jour|
            unless @jours[utilisateur_jour.service].nil?
                if @jours[utilisateur_jour.service][utilisateur_jour.utilisateur.groupe].nil?
                    @jours[utilisateur_jour.service][utilisateur_jour.utilisateur.groupe] ||= Hash.new
                    
                end

                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur.groupe][utilisateur_jour.utilisateur] ||= Hash.new
                                    
                dd = utilisateur_jour.date.to_s
                dw = utilisateur_jour.date.wday

                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur.groupe][utilisateur_jour.utilisateur][dd] ||= Hash.new

                wksl = WorkingList.for(utilisateur_jour.id).includes(:work)
                wksl.each do  |w|

                    if dw == 6
                        @jours[utilisateur_jour.service][utilisateur_jour.utilisateur.groupe][utilisateur_jour.utilisateur][dd][utilisateur_jour.am_pm] = wksl
                        
                    else
                        if w.work.early_value 
                            if !@jours[utilisateur_jour.service][utilisateur_jour.utilisateur.groupe][utilisateur_jour.utilisateur][dd][utilisateur_jour.am_pm]
                                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur.groupe][utilisateur_jour.utilisateur][dd][utilisateur_jour.am_pm] = [w.work.service_id, w.work.early_value]
                            else
                                if @jours[utilisateur_jour.service][utilisateur_jour.utilisateur.groupe][utilisateur_jour.utilisateur][dd][utilisateur_jour.am_pm][1] > w.work.early_value
                                    @jours[utilisateur_jour.service][utilisateur_jour.utilisateur.groupe][utilisateur_jour.utilisateur][dd][utilisateur_jour.am_pm] = [w.work.service_id, w.work.early_value]
                                end
                            end
                        end
                    end
                end

                
            end
        end

        # Charge les fermetures
        charge_fermetures(@date, @date2)        

        # Charge les absences
        @absences = Hash.new
        absences = Absence.where('date_fin >= ? AND date <= ?', @date, @date2).order(:utilisateur_id, :date, :date_fin)
        absences.each do |absence|
            (absence.date..absence.date_fin).each do |aj|
                @absences[absence.utilisateur_id] ||= Hash.new
                @absences[absence.utilisateur_id][aj.to_s] = Array.new
                if @konfiguration[:jours_secr_pet]
                    @absences[absence.utilisateur_id][aj.to_s][0] = (absence.type_absence.code.downcase == @konfiguration[:jours_secr_pet].downcase) ? "" : absence.type_absence.code
                    @absences[absence.utilisateur_id][aj.to_s][1] = absence.accord
                    @absences[absence.utilisateur_id][aj.to_s][2] = absence.halfday
                else
                    @absences[absence.utilisateur_id][aj.to_s][0] = absence.type_absence.code
                    @absences[absence.utilisateur_id][aj.to_s][1] = absence.accord
                    @absences[absence.utilisateur_id][aj.to_s][2] = absence.halfday
                end
            end
        end

        # Charges les services
        find_services if @services.nil?

        # Charge les Events
         @events = Hash.new
        # nombre_de_jours = (@date2-@date).to_i
        # nombre_de_jours.times do |i|
        #     charge_events(@date + i.day)
        # end

        @values = ["Early 1", "Early 2", "Regular"]
        
    end


    private     

    def jour_params
        params.require(:jour).permit(:date, :utilisateur_id, :am_pm, :service_id, :edit_mode, :new_day_mode, :note)
    end

    def find_jour
        @jour = Jour.find(params[:id])
    end
 
end
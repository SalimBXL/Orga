class JoursController < ApplicationController
    before_action :find_jour, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        # Log action
        log(request.path)

        session[:return_user_id] = nil

        if current_user.admin?
            @jours = Jour.order(numero_semaine: :desc).order(numero_jour: :desc).order(:service_id, :am_pm, :utilisateur_id).page(params[:page])
        else
            @jours = Jour.where(service: current_user.utilisateur.service).order(numero_semaine: :desc).order(numero_jour: :desc).order(:service_id, :am_pm, :utilisateur_id).page(params[:page])
        end
    end


    #############
    #   SHOW    #
    #############
    def show
        # Log action
        log(request.path)
    end


    #############
    #    NEW    #
    #############
    def new
        # Log action
        log(request.path)
        @jour = Jour.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        # Log action
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
        # Log action
        log(request.path, I18n.t("jours.index.log_update"))

        if params[:swap]

            # Swap batch entre deux users
        
            user1 = Utilisateur.find(params[:swap].to_i) if params[:swap]
            user2 = Utilisateur.find(params[:jour][:utilisateur_id].to_i)
            job1 = @jour
            job2 = Jour.where(utilisateur_id: user2.id, date: @jour.date, am_pm: @jour.am_pm).first

            ## Repart vers la page edit si on a pas les deux utilisateurs
            render :edit unless user1 and user2

            puts "***************************************"
            puts "***************************************"
            puts " USER 1 => #{user1.prenom_nom}"
            puts " USER 2 => #{user2.prenom_nom}"
            puts " JOB 1 => #{job1}"
            puts " JOB 2 => #{job2}"
            puts "***************************************"
            puts "***************************************"

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

        redirect_to jours_path
    end

    #############
    #   EDIT    #
    #############
    def edit
        # Log action
        log(request.path, I18n.t("jours.index.log_edit"))



    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        # Log action
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
        # Log action
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

        # Parse les jours
        @specific_day_jours = Hash.new
        specific_day_jours.each do |jour|
            @specific_day_jours[jour.service] ||= Hash.new
            @specific_day_jours[jour.service][jour.utilisateur] ||= Hash.new
            @specific_day_jours[jour.service][jour.utilisateur][jour.am_pm] ||= Array.new
            @specific_day_jours[jour.service][jour.utilisateur][jour.am_pm] = WorkingList.for(jour.id).includes(:work)
            @specific_day_jours[jour.service][jour.utilisateur]["notes"] ||= Hash.new
            @specific_day_jours[jour.service][jour.utilisateur]["notes"][jour.am_pm] = jour.note
        end

        # Charges les services
        find_services if @services.nil?

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
            @jours[utilisateur.service][utilisateur] ||= Hash.new
        end

        # Liste des attributions
        utilisateurs_jours = Jour.where(date: @date..@date2).order(:service_id, :utilisateur_id, :date, :am_pm)
        utilisateurs_jours.each do |utilisateur_jour|
            unless @jours[utilisateur_jour.service].nil?
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur] ||= Hash.new
                dd = utilisateur_jour.date.to_s
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][dd] ||= Hash.new
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][dd][utilisateur_jour.am_pm] = WorkingList.for(utilisateur_jour.id).includes(:work)
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][dd]["notes"] ||= Hash.new
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][dd]["notes"][utilisateur_jour.am_pm] = utilisateur_jour.note
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
                @absences[absence.utilisateur_id][aj.to_s] = absence.accord
            end
        end

        # Charges les services
        find_services if @services.nil?

        # Charge les Events
        @events = Hash.new
        nombre_de_jours = (@date2-@date).to_i
        nombre_de_jours.times do |i|
            charge_events(@date + i.day)
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


        if user_signed_in? && (current_user.admin? or current_user.utilisateur.admin)
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
                    if a.accord
                        @absences[utilisateur_jour.utilisateur][i+1] =  true
                    else
                        @absences[utilisateur_jour.utilisateur][i+1] =  false
                    end
                end
            end
        end

        charge_fermetures(@date.beginning_of_week, @date.beginning_of_week+5.days)

        # Charge les services
        find_services if @services.nil?

        # Charge les Events
        @events = Hash.new
        5.times do |i|
            charge_events(@date.beginning_of_week+i.day)
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
            @jours[utilisateur.service][utilisateur] ||= Hash.new
        end

        # Liste des attributions
        utilisateurs_jours = Jour.where(date: @date..@date2).order(:service_id, :utilisateur_id, :date, :am_pm)
        utilisateurs_jours.each do |utilisateur_jour|
            unless @jours[utilisateur_jour.service].nil?
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur] ||= Hash.new
                dd = utilisateur_jour.date.to_s
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][dd] ||= Hash.new

                #@jours[utilisateur_jour.service][utilisateur_jour.utilisateur][dd][utilisateur_jour.am_pm] = WorkingList.for(utilisateur_jour.id).includes(:work)
                WorkingList.for(utilisateur_jour.id).includes(:work).each do  |w|
                    if w.work.early_value 
                        if !@jours[utilisateur_jour.service][utilisateur_jour.utilisateur][dd][utilisateur_jour.am_pm]
                            #@jours[utilisateur_jour.service][utilisateur_jour.utilisateur][dd][utilisateur_jour.am_pm] = w.work.early_value
                            @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][dd][utilisateur_jour.am_pm] = [w.work.service_id, w.work.early_value]
                        else
                            if @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][dd][utilisateur_jour.am_pm][1] > w.work.early_value
                                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][dd][utilisateur_jour.am_pm] = [w.work.service_id, w.work.early_value]
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
                @absences[absence.utilisateur_id][aj.to_s] = absence.accord
            end
        end

        # Charges les services
        find_services if @services.nil?

        # Charge les Events
        @events = Hash.new
        #nombre_de_jours = (@date2-@date).to_i
        #nombre_de_jours.times do |i|
        #    charge_events(@date + i.day)
        #end

        # mode edition ?
        #unless params[:edit_mode]
        #    @edit_mode = false
        #else
        #    if params[:edit_mode].downcase == 'true'
        #        @edit_mode = true
        #    else
        #        @edit_mode = false
        #    end
        #end

        # mode new day ?
        #unless params[:new_day_mode]
        #    @new_day_mode = false
        #else
        #    if params[:new_day_mode].downcase == 'true'
        #        @new_day_mode = true
        #    else
        #        @new_day_mode = false
        #    end
        #end


        if user_signed_in? && (current_user.admin? or current_user.utilisateur.admin)
            find_utilisateurs
            find_classes
            find_works
        end

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
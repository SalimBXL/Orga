class AbsencesController < ApplicationController
    before_action :find_absence, only: [:show, :edit, :update, :destroy, :remove_one_day]
    before_action :check_logged_in
    before_action :find_utilisateurs, only: [:grille, :edit]

    #############
    #   INDEX   #
    #############

    def index

        @absences = is_manager_or_super_admin? ? Absence.order(date: :desc).page(params[:page]) : Absence.where(utilisateur: current_user.utilisateur).order(date: :desc).page(params[:page])
        is_manager_or_super_admin? && (@utilisateurs = Utilisateur.order(:service_id, :groupe_id, :prenom, :nom))
        
        # Log action
        log(request.path)

        session[:return_user_id] = nil
    end


    #####################
    # NOT YET VALIDATED #
    #####################
    def not_yet_validated
        @absences = Absence.where(accord: false).or(Absence.where(accord: nil)).where('date_fin >= ?', Date.today).order(:date, :date_fin).page(params[:page])
        log(request.path)
    end

    #############
    # VALIDATED #
    #############
    def validated
        @absences = Absence.where('date_fin >= ?', Date.today).where(accord: true).order(date: :desc).order(:date_fin).page(params[:page])
        log(request.path)
    end


    #############
    #   SHOW    #
    #############
    def show
    end


    #############
    #    NEW    #
    #############
    def new
        @absence = Absence.new
        @absence.date = Date.today
        @absence.date_fin = @absence.date
        find_utilisateurs if @utilisateurs.nil?
        log(request.path)
    end


    ##############
    #   CREATE   #
    ##############
    def create
        log(request.path)

        @absence = Absence.create(absence_params)
        @absence.check_date_fin

        list_abs = @absence.conflict_exists?
        if list_abs
            texte = "Date conflict with an existing absence : "
            list_abs.each do |line|
                texte = texte + "[ID: #{line.id} - DATE: #{line.date} - DATE_FIN: #{line.date_fin}]"
            end
            flash[:alert] = texte
            find_utilisateurs if @utilisateurs.nil?
            render :edit
        else

            if @absence.save
                flash[:notice] = "Absence(s) créée(s)"
                redirect_to absences_path
            else
                flash[:alert] = "Erreur(s)"
                render :new
            end

        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        log(request.path, I18n.t("absences.index.log_update"))

        @absence.check_date_fin

        # Si absence déjà accordée, 
        # on annule l'accord car absence est modifiée.
        @absence.non_accord

        # on sauve.
        if @absence.update(absence_params)
            flash[:notice] = "Absence modifiée"
            redirect_to absences_path
        else 
            render :edit
        end
    end

    #############
    #   EDIT    #
    #############
    def edit
        log(request.path, I18n.t("absences.index.log_edit"))
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        log(request.path, I18n.t("absences.index.log_destroy"))
        @absence.destroy

        if !session[:return_user_id].blank? or !session[:return_user_id].nil?
            tmp = session[:return_user_id]
            session[:return_user_id] = nil
            redirect_to utilisateur_path(id: tmp)
        else 
            redirect_to absences_path()
        end

    end

    ##########
    # GRILLE #
    ##########
    def grille
        log(request.path, "Show grille absences")

        # Réglage des dates de début et fin de période
        date_tmp = params[:date] ? date_tmp = params[:date].to_date : date_tmp = Date.today
        
        date_tmp = (date_tmp.beginning_of_month.cwday == 7) ? 
            date_tmp.beginning_of_month + 1.day : 
            (date_tmp.beginning_of_month.cwday == 6) ? 
            date_tmp = date_tmp.beginning_of_month + 2.days :
            date_tmp = date_tmp.beginning_of_month

        @date = date_tmp.beginning_of_week
        @date2 = (date_tmp.end_of_month+180.days).end_of_week
        
        # Charge les absences
        @absences = Hash.new
        absences = Absence.where('date_fin >= ? AND date <= ?', @date, @date2).order(:utilisateur_id, :date, :date_fin)
        absences.each do |absence|
            (absence.date..absence.date_fin).each do |aj|
                @absences[absence.utilisateur_id] ||= Hash.new
                @absences[absence.utilisateur_id][aj] = absence
            end
        end
    end

    def remove_one_day
        day_to_remove = params[:day]

        #Supprimer premier jour ? => avancer la date de départ de un jour
        if day_to_remove.to_s == @absence.date.to_s
            @absence.date = (@absence.date + 1.day)
            if @absence.update(@absence.as_json)
                flash[:notice] = "Absence modifiée =>  #{@absence.date} - #{@absence.date_fin}"
                redirect_to utilisateur_path(@absence.utilisateur)
            end
        
        #Supprimer un autre jour ? => reculer la date de fin de un jour
        elsif day_to_remove.to_s == @absence.date_fin.to_s
            @absence.date_fin = (@absence.date_fin - 1.day)
            if @absence.update(@absence.as_json)
                flash[:notice] = "Absence modifiée =>  #{@absence.date} - #{@absence.date_fin}"
                redirect_to utilisateur_path(@absence.utilisateur)
            end
        else

            #Supprimer autre jour ? => Split 
            #   a: date départ -> jour pointé-1
            #   b: Jour pointé +1 -> date de fin
            backup_date = @absence.date_fin
            @absence.date_fin = (day_to_remove.to_date - 1.day)
            if @absence.update(@absence.as_json)
                @absence.date = (day_to_remove.to_date + 1.day)
                @absence.date_fin = backup_date
                @absence.id = nil
                @absence = Absence.create(@absence.as_json)
                redirect_to utilisateur_path(@absence.utilisateur)
            end
        end
    end


    private 

    def absence_params
        params[:absence][:date_fin] = params[:absence][:date] if params[:absence][:halfday] == true
        if params[:date_fin] and params[:date]
            params[:date_fin] = params[:date] if params[:date_fin] < params[:date]
        end
        params.require(:absence).permit(:date, :date_fin, :type_absence_id, :utilisateur_id, :remarque, :accord, :halfday)
    end

    def find_absence
        @absence = Absence.find(params[:id])
    end
    
end
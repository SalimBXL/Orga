class AbsencesController < ApplicationController
    before_action :find_absence, only: [:show, :edit, :update, :destroy]
    before_action :check_logged_in

    #############
    #   INDEX   #
    #############
    def index
        #@absences = Absence.order(:accord).order(date: :desc).page(params[:page])
        @absences = Absence.where(accord: true).order(date: :desc).page(params[:page])
        @absences_non_validees = Absence.where(accord: !true).order(date: :desc)
        
        # Log action
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
        # Log action
        log(request.path)
    end


    ##############
    #   CREATE   #
    ##############
    def create
        # Log action
        log(request.path)
        @absence = Absence.create(absence_params)
        if @absence.save
            flash[:notice] = "Absence(s) créée(s)"
            redirect_to absences_path
        else
            flash[:danger] = "Erreur(s)"
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        # Log action
        log(request.path, I18n.t("absences.index.log_update"))

        # On ajuste la date de fin
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
        # Log action
        log(request.path, I18n.t("absences.index.log_edit"))
        find_utilisateurs
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        # Log action
        log(request.path, I18n.t("absences.index.log_destroy"))
        @absence.destroy
    end

    ##########
    # GRILLE #
    ##########
    def grille
        log(request.path, "Show grille absences")

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
        @date2 = (date_tmp.end_of_month+10.days).end_of_week
        
        # Charge les absences
        @absences = Hash.new
        absences = Absence.where('date_fin >= ? AND date <= ?', @date, @date2).order(:utilisateur_id, :date, :date_fin)
        absences.each do |absence|
            (absence.date..absence.date_fin).each do |aj|
                @absences[absence.utilisateur_id] ||= Hash.new
                @absences[absence.utilisateur_id][aj] = absence
            end
        end

        find_utilisateurs

    end


    private 

    def absence_params
        if params[:date_fin] and params[:date]
            params[:date_fin] = params[:date] if params[:date_fin] < params[:date]
        end
        params.require(:absence).permit(:date, :date_fin, :type_absence_id, :utilisateur_id, :remarque, :accord)        
    end

    def find_absence
        @absence = Absence.find(params[:id])
    end
    
end
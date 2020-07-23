class AbsencesController < ApplicationController
    before_action :find_absence, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        @absences = Absence.order(date: :desc).order(:type_absence_id).page(params[:page])
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
        # Log action
        log(request.path)
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        # Log action
        log(request.path, I18n.t("absences.index.log_destroy"))
        @absence.destroy
    end


    private 

    def absence_params
        params.require(:absence).permit(:date, :date_fin, :type_absence_id, :utilisateur_id, :remarque, :accord)
    end

    def find_absence
        @absence = Absence.find(params[:id])
    end
    
end
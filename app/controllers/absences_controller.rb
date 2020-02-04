class AbsencesController < ApplicationController
    before_action :find_absence, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        @absences = Absence.order(:date).order(:type_absence_id).page(params[:page])
        #@current_absences = Absence.where(date: (Date.today-3.months)..(Date.today+9.month))
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
    end


    ##############
    #   CREATE   #
    ##############
    def create
        @absence = Absence.create(absence_params)
        if @absence.save
            flash[:notice] = "Absence créée"
            redirect_to absences_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
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
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        @absence.destroy
        #redirect_to absences_path
    end


    private 

    def absence_params
        params.require(:absence).permit(:date, :type_absence_id, :utilisateur_id, :remarque)
    end

    def find_absence
        @absence = Absence.find(params[:id])
    end
    
end
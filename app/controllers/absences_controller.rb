class AbsencesController < ApplicationController

    #############
    #   INDEX   #
    #############
    def index
        @absences = Absence.all
    end


    #############
    #   SHOW    #
    #############
    def show
        @absence = Absence.find(params[:id])
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
        @absence = Absence.create(params.require(:absence).permit(:date, :type_absence, :remarque))
        if @absence.save
            redirect_to absences_path
        else
            render :new
        end
    end
end
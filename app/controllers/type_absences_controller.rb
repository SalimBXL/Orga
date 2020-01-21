class TypeAbsencesController < ApplicationController
    before_action :find_groupe, only: [:show, :edit, :update]

    #############
    #   INDEX   #
    #############
    def index
        @type_absences = TypeAbsence.order(:nom)
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
        @type_absence = TypeAbsence.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        @type_absence = TypeAbsence.create(type_absence_params)
        if @type_absence.save
            redirect_to type_absences_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        if @type_absence.update(type_absence_params)
            redirect_to type_absences_path
        else 
            render :edit
        end
    end

    #############
    #   EDIT    #
    #############
    def edit
    end


    private 

    def type_absence_params
        params.require(:type_absence).permit(:nom, :description)
    end

    def find_groupe
        @type_absence = TypeAbsence.find(params[:id])
    end
    
end
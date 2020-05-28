class TypeAbsencesController < ApplicationController
    before_action :find_type_absence, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        @type_absences = TypeAbsence.order(:nom).page(params[:page])
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
            flash[:notice] = "Type d'absence créé avec succès"
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
            flash[:notice] = "Type d'absence modifié avec succès"
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

    ##############
    #   DESTROY  #
    ##############
    def destroy
        @type_absence.destroy
    end


    private 

    def type_absence_params
        params.require(:type_absence).permit(:nom, :description, :code)
    end

    def find_type_absence
        @type_absence = TypeAbsence.find(params[:id])
    end
    
end
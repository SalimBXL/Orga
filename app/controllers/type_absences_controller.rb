class TypeAbsencesController < ApplicationController
    before_action :find_type_absence, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        # Log action
        log(request.path)
        @type_absences = TypeAbsence.order(:code, :nom).page(params[:page])
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
        @type_absence = TypeAbsence.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        # Log action
        log(request.path)
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
        # Log action
        log(request.path, I18n.t("type_absences.index.log_update"))
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
        # Log action
        log(request.path, I18n.t("type_absences.index.log_edit"))
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        # Log action
        log(request.path, I18n.t("type_absences.index.log_destroy"))
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
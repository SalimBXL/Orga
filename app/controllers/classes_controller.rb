class ClassesController < ApplicationController
    before_action :find_classe, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        # Log action
        log(request.path)
        @classes = Classe.order(:nom).page(params[:page])
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
        @classe = Classe.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        # Log action
        log(request.path)
        @classe = Classe.create(classe_params)
        if @classe.save
            flash[:notice] = "Classe créée avec succès"
            redirect_to classes_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        # Log action
        log(request.path, I18n.t("classes.index.log_update"))
        if @classe.update(classe_params)
            flash[:notice] = "Classe modifiée avec succès"
            redirect_to classes_path
        else 
            render :edit
        end
    end

    #############
    #   EDIT    #
    #############
    def edit
        # Log action
        log(request.path, I18n.t("classes.index.log_edit"))
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        # Log action
        log(request.path, I18n.t("classes.index.log_destroy"))
        @classe.destroy
    end


    private 

    def classe_params
        params.require(:classe).permit(:nom, :description)
    end

    def find_classe
        @classe = Classe.find(params[:id])
    end
    
end
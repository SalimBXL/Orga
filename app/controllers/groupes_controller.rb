class GroupesController < ApplicationController
    before_action :find_groupe, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        @groupes = Groupe.order(:nom).page(params[:page])
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
        @groupe = Groupe.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        @groupe = Groupe.create(groupe_params)
        if @groupe.save
            flash[:notice] = "Groupe créé avec succès"
            redirect_to groupes_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        if @groupe.update(groupe_params)
            flash[:notice] = "Groupe modifié avec succès"
            redirect_to groupes_path
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
        @groupe.destroy
        #redirect_to groupes_path
    end


    private 

    def groupe_params
        params.require(:groupe).permit(:nom, :description)
    end

    def find_groupe
        @groupe = Groupe.find(params[:id])
    end
    
end
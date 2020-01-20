class GroupesController < ApplicationController
    before_action :find_groupe, only: [:show, :edit, :update]

    #############
    #   INDEX   #
    #############
    def index
        @groupes = Groupe.order(:nom)
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


    private 

    def groupe_params
        params.require(:groupe).permit(:nom, :description)
    end

    def find_groupe
        @groupe = Groupe.find(params[:id])
    end
    
end
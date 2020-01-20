class GroupesController < ApplicationController

    #############
    #   INDEX   #
    #############
    def index
        @groupes = Groupe.all
    end


    #############
    #   SHOW    #
    #############
    def show
        @groupe = Groupe.find(params[:id])
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
        @groupe = Groupe.create(params.require(:groupe).permit(:nom, :description))
        if @groupe.save
            redirect_to groupes_path
        else
            render :new
        end
    end


    

end
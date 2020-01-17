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
end
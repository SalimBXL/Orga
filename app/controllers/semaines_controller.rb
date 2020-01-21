class SemainesController < ApplicationController
    before_action :find_semaine, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        @semaines = Semaine.order(:numero_semaine).order(:date_lundi).order(:utilisateur_id)
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
        @semaine = Semaine.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        @semaine = Semaine.create(semaine_params)

        # ajuste la date pour qu'elle corresponde à un lundi
        if @semaine.date_lundi.cwday != 1
            @semaine.date_lundi = @semaine.date_lundi-@semaine.date_lundi.cwday+1
        end

        # vérifie et formatte le numéro de semaine
        # sur base de la date du lundi
        if @semaine.date_lundi != nil
            num = "#{@semaine.date_lundi.cweek}"
            if @semaine.date_lundi.cweek < 10
                num = "0"+num
            end
            @semaine.numero_semaine = "#{@semaine.date_lundi.year}-W#{num}"
        end

        if @semaine.save
            redirect_to semaines_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        if @semaine.update(semaine_params)
            redirect_to semaines_path
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
        @semaine.destroy
        redirect_to semaines_path
    end


    private 

    def semaine_params
        params.require(:semaine).permit(:numero_semaine, :date_lundi, :note, :utilisateur_id)
    end

    def find_semaine
        @semaine = Semaine.find(params[:id])
    end
    
end
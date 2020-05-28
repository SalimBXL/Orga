class JoursController < ApplicationController
    before_action :find_jour, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        @jours = Jour.order(numero_semaine: :desc).order(:numero_jour, :service_id, :am_pm, :utilisateur_id).page(params[:page])
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
        @jour = Jour.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        @jour = Jour.create(jour_params)
        if @jour.save
            flash[:notice] = "Jour créé avec succès"
            redirect_to jours_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        if @jour.update(jour_params)
            flash[:notice] = "Jour Modifié avec succès"
            redirect_to jours_path
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
        @jour.destroy
    end


    private 

    def jour_params
        params.require(:jour).permit(:date, :utilisateur_id, :am_pm, :service_id)
    end

    def find_jour
        @jour = Jour.find(params[:id])
    end
    
end
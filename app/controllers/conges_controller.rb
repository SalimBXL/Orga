class CongesController < ApplicationController
    before_action :find_conge, only: [:show, :edit, :update, :destroy]
    before_action :conge_params_semaine, only: [:plage]

    #############
    #   INDEX   #
    #############
    def index
        @conges = Conge.order(date: :desc).order(:accord).page(params[:page])
    end


    #############
    #   SHOW    #
    #############
    def show
    end

    #   PLAGE   #
    def plage
        @conges = Conge.where("date <= ? AND date_fin >= ?", @dateDepart, @dateFin).order(:date, :accord)
    end


    #############
    #    NEW    #
    #############
    def new
        @conge = Conge.new
    end


    ##############
    #   CREATE   #
    ##############
    def create
        @conge = Conge.create(conge_params)
        verif_accord
        if @conge.save
            flash[:notice] = "Congé créé avec succès"
            redirect_to conges_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        verif_accord
        if @conge.update(conge_params)
            flash[:notice] = "Congé modifié avec succès"
            redirect_to conges_path
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
        @conge.destroy
        #redirect_to conges_path
    end


    private 

    def verif_accord
        if @conge.accord!=true || @conge.accord==nil
            @conge.accord = false
        end
    end

    def conge_params
        params.require(:conge).permit(:date, :date_fin, :utilisateur_id, :accord, :remarque)
    end

    def find_conge
        @conge = Conge.find(params[:id])
    end

    def conge_params_semaine
        params.require(:conge).permit(:dateDepart, :dateFin)
    end
    
end
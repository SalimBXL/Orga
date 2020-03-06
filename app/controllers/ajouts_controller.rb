class AjoutsController < ApplicationController

    #############
    #   INDEX   #
    #############
    def index
        @ajouts = Ajout.all
        if @ajouts.count > 1
            dernier = @ajouts.last
            @ajouts.each do |ajout|
                unless ajout == dernier
                    ajout.destroy
                    @ajouts.delete(ajout)
                end
            end
        end
        @works = Work.all
        @semaines = Semaine.where(date_lundi: Ajout.last.date_lundi).order(:utilisateur_id)
    end


    ##########
    #   NEW  #
    ##########
    def new
        @ajout = Ajout.new
    end
    

    ##############
    #   CREATE   #
    ##############
    def create
        @ajout = Ajout.create(ajout_params)
        @ajout.numero_jour = @ajout.date_lundi.cwday
        @ajout.date_lundi = @ajout.date_lundi.beginning_of_week
        if @ajout.save
            flash[:notice] = "ajout créé avec succès"
            redirect_to ajouts_path
        else
            render :new
        end
    end

    private

    def ajout_params
        params.require(:ajout).permit(:utilisateur, :work1, :work2, :work3, :work4, :work5, :date_lundi)
    end

    
end
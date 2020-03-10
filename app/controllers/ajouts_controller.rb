class AjoutsController < ApplicationController
    before_action :find_ajout, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        liste = Ajout.all
        liste.each do |item|
            utilisateur = Utilisateur.find(item.utilisateur)
            slug = "#{utilisateur.prenom_nom} #{item.date_lundi.year}-W#{item.date_lundi.cweek<10 ? "0" : ""}#{item.date_lundi.cweek}".parameterize
            semaines = Semaine.where(slug: slug)
            semaines.each do |semaine|
                semaine.jobs.where(numero_jour: item.numero_jour).find_each do |job|
                    job.working_lists.each do |work|
                        if item.works.include?(work.work_id)
                            item.destroy
                        end
                    end
                end
            end
        end
        @ajouts = Ajout.all
        @works = @ajouts.count>0 ? Work.all : Array.new
        @semaines = @ajouts.count>0 ? Semaine.where(date_lundi: @ajouts.last.date_lundi).order(:utilisateur_id) : Array.new
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


    #############
    #   EDIT    #
    #############
    def edit
    end
    

    ##############
    #   DESTROY  #
    ##############
    def destroy
        @ajout.destroy
    end


    private

    def ajout_params
        params.require(:ajout).permit(:utilisateur, :work1, :work2, :work3, :work4, :work5, :date_lundi)
    end

    def find_ajout
        @ajout = Ajout.find(params[:id])
    end
end
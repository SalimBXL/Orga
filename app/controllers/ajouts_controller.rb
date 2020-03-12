class AjoutsController < ApplicationController
    before_action :find_ajout, only: [:show, :edit, :update, :destroy, :valider]

    #############
    #   INDEX   #
    #############
    def index
        @ajouts = Ajout.all
        @works = Work.all
        @semaines = Semaine.where(date_lundi: @ajouts.last.date_lundi).order(:utilisateur_id)
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


    #############
    #   UPDATE  #
    #############
    def update
        if @ajout.update(ajout_params)
            flash[:notice] = "Ajout modifiée avec succès"
            redirect_to ajouts_path
        else 
            render :edit
        end
    end
    

    ##############
    #   DESTROY  #
    ##############
    def destroy
        @ajout.destroy
    end


    ##############
    #   VALIDER  #
    ##############
    def valider

        utilisateur = Utilisateur.find(@ajout.utilisateur)

        puts "===================="
        puts " * Utilisateur    : #{@ajout.utilisateur}"
        puts " * Date Lundi     : #{@ajout.date_lundi}"
        puts " * Numero Jour    : #{@ajout.numero_jour}"
        puts " * Works          : #{@ajout.works}"
        numero_semaine = format_numero_semaine(@ajout.date_lundi.year, @ajout.date_lundi.cweek)
        slug = "#{utilisateur.prenom_nom} #{numero_semaine}".parameterize
        puts " * Numero Semaine : #{numero_semaine}"
        puts " * Slug           : #{slug}"


        # Semaine
        # Check si semaine existe. Sinon, on la crée.
        unless Semaine.exists?(slug: slug)
            semaine = Semaine.create(numero_semaine: numero_semaine, utilisateur: utilisateur, date_lundi: @ajout.date_lundi)
            unless semaine.save
                flash[:danger] = "Impossible de créer la semaine..."
                redirect_to ajouts_path
            end
        else
            semaine = Semaine.find_by_slug(slug)
        end

        # Job
        # Check si job existe. Sinon, on le crée.
        jobs = semaine.jobs.where(numero_jour: @ajout.numero_jour)
        if jobs.count<1
            # aucun job pour cette semaine au jour donné
            # on doit créer le job
            
        end

        

        # Working_list

        
        
        puts "===================="

        render json: {action: "VALIDER id : #{@ajout.id}"}
    end


    private

    def ajout_params
        params.require(:ajout).permit(:utilisateur, :work1, :work2, :work3, :work4, :work5, :date_lundi)
    end

    def find_ajout
        @ajout = Ajout.find(params[:id])
    end
end
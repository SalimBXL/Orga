class SemainesController < ApplicationController
    before_action :find_semaine, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        @semaines = Semaine.order(:numero_semaine).order(:slug).page(params[:page])
    end


    #################
    #   THIS WEEK   #
    #################
    def this_week
        @semaines = semaines_at(Date.today)
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
        semaine_courrante_si_vide
        fait_un_lundi
        format_numero_semaine

        if !duo_semaine_utilisateur_unique?
            flash[:danger] = "Il existe déjà une semaine pour cet utilisateur."
            redirect_to new_semaine_path
            return
        end

        if @semaine.save
            flash[:notice] = "Semaine créée avec succès"
            redirect_to semaines_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        semaine_courrante_si_vide
        fait_un_lundi
        format_numero_semaine

        if @semaine.update(semaine_params)
            flash[:notice] = "Semaine modifiée avec succès"
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
        #redirect_to semaines_path
    end


    private 

    def semaine_params
        params.require(:semaine).permit(:numero_semaine, :date_lundi, :note, :utilisateur_id)
    end

    def find_semaine
        @semaine = Semaine.find_by_id(params[:identifier])
        @semaine ||= Semaine.find_by_slug(params[:identifier])
        raise ActionController::RoutingError.new("Not found") unless @semaine
    end

    def duo_semaine_utilisateur_unique?
        Semaine.where(utilisateur_id: @semaine.utilisateur_id).where(numero_semaine: @semaine.numero_semaine).count > 0 ? false : true
    end

    def semaine_courrante_si_vide
        if @semaine.date_lundi.blank? || @semaine.date_lundi.nil?
            @semaine.date_lundi = Date.today
        end
    end

    def fait_un_lundi
        # ajuste la date pour qu'elle corresponde à un lundi
        if @semaine.date_lundi.cwday != 1
            @semaine.date_lundi = @semaine.date_lundi-@semaine.date_lundi.cwday+1
        end
    end

    def format_numero_semaine
        # vérifie et formatte le numéro de semaine
        # sur base de la date du lundi
        if @semaine.date_lundi != nil
            num = "#{@semaine.date_lundi.cweek}"
            if @semaine.date_lundi.cweek < 10
                num = "0"+num
            end
            @semaine.numero_semaine = "#{@semaine.date_lundi.year}-W#{num}"
        end
    end
    
end
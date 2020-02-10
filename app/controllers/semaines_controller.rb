class SemainesController < ApplicationController
    before_action :find_semaine, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        @semaines = Semaine.order(numero_semaine: :desc, slug: :asc).page(params[:page])
        @numero_semaine_precedente = -1
    end


    ########################
    # SEMAINES UTILISATEUR #
    ########################
    def semaines_utilisateur
        @utilisateur = Utilisateur.find_by_id(params[:id])
        @semaines = @utilisateur.semaines.order(:slug).page(params[:page])
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
        @utilisateurs = getUtilisateurs
        @groupes = Groupe.order(:nom)
    end


    ##############
    #   CREATE   #
    ##############
    def create
        utilisateurs = Array.new
        unless params[:semaine][:utilisateurs]
            utilisateurs << params[:semaine][:utilisateur_id]
        else
            params[:semaine][:utilisateurs].each do |u|
                unless u.blank?
                    utilisateurs << u
                end
            end
        end
        type_erreur = 0
        message_erreur = ""
        utilisateurs.each do |utilisateur_id|
            @semaine = Semaine.create(semaine_params)
            @semaine.utilisateur_id = utilisateur_id
            semaine_courrante_si_vide
            fait_un_lundi
            format_numero_semaine
            if !duo_semaine_utilisateur_unique?
                type_erreur = 1
                message_erreur += "Il existe déjà une semaine pour l'utilisateur ID #{@semaine.utilisateur_id} \n"
            else 
                if !@semaine.save
                    type_erreur = 2
                    message_erreur += "Problème lors de la sauvegarde en base pour l'utilisateur ID #{@semaine.utilisateur_id} \n"
                end
            end
        end
        if type_erreur!=0
            flash[:alert] = message_erreur
        end
        if type_erreur == 1
            redirect_to new_semaine_path
        elsif type_erreur == 2
            render :new
        else
            flash[:notice] = "Semaine(s) créée(s) avec succès"
            redirect_to semaines_path
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
        @utilisateurs = getUtilisateurs
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        @semaine.destroy
        #redirect_to semaines_path
    end


    private 

    def getUtilisateurs
        Utilisateur.order(groupe_id: :asc, prenom: :asc, nom: :asc)
    end

    def semaine_params
        params.require(:semaine).permit(:numero_semaine, :date_lundi, :note, :utilisateur_id, :utilisateurs)
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
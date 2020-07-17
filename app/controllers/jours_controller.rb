class JoursController < ApplicationController
    before_action :find_jour, only: [:show, :edit, :update, :destroy]

    #############
    #   INDEX   #
    #############
    def index
        @jours = Jour.order(:numero_semaine, :numero_jour, :service_id, :am_pm, :utilisateur_id).page(params[:page])
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


    #############
    #   TODAY   #
    #############
    def specific_day
        @specific_day_works = Hash.new
        @absence = Hash.new

        # Détermine la date
        unless params[:date]
            @date = Date.today
            @specific_day_jours = Jour.today.select([:id, :utilisateur_id, :service_id, :am_pm, :note]).includes(utilisateur: :groupe)
        else
            @date = params[:date].to_date
            @specific_day_jours = Jour.at_day(@date).select([:id, :utilisateur_id, :service_id, :am_pm, :note]).includes(utilisateur: :groupe)
        end

        # Parse les jours
        @specific_day_jours.each do |jour|
            @specific_day_works[jour] = WorkingList.for(jour).includes(:work)
            @absence[jour.utilisateur] ||= false
            if Absence.today_for_user(jour.utilisateur).count > 0
                @absence[jour.utilisateur] = true
            end
        end

        # Charges les services
        @services = Service.order(:nom).select([:id,:nom])
        # Détermine le service à afficher
        unless params[:service]
            @current_service = nil
        else 
            @current_service = @services.find_by_id(params[:service])
        end
    end

    ############
    #   Month   #
    ############
    def specific_month

        # Réglage des dates de début et fin de période
        unless params[:date]
            date_tmp = Date.today
        else
            date_tmp = params[:date].to_date
        end
        if date_tmp.beginning_of_month.cwday == 7
            date_tmp = date_tmp.beginning_of_month + 1.day
        elsif date_tmp.beginning_of_month.cwday == 6
            date_tmp = date_tmp.beginning_of_month + 2.days
        else
            date_tmp = date_tmp.beginning_of_month
        end
        @date = date_tmp.beginning_of_week
        @date2 = date_tmp.end_of_month.end_of_week


        @jours = Hash.new

        # Liste des utilisateurs
        utilisateurs = Utilisateur.order(:service_id, :groupe_id, :prenom, :nom)
        utilisateurs.each do |utilisateur|
            @jours[utilisateur.service] ||= Hash.new
            @jours[utilisateur.service][utilisateur] ||= Hash.new
        end

        # Liste des attributions
        utilisateurs_jours = Jour.where(date: @date..@date2).order(:service_id, :utilisateur_id, :date, :am_pm)
        utilisateurs_jours.each do |utilisateur_jour|
            unless @jours[utilisateur_jour.service].nil?
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur] ||= Hash.new
                dd = utilisateur_jour.date.to_s
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][dd] ||= Hash.new
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][dd][utilisateur_jour.am_pm] = WorkingList.for(utilisateur_jour.id).includes(:work)
            end
        end

        @fermetures = Hash.new
        fermetures = Fermeture.where('date_fin >= ? AND date <= ?', @date, @date2).order(:service_id, :date, :date_fin)
        fermetures.each do |fermeture|
            (fermeture.date..fermeture.date_fin).each do |fj|
                @fermetures[fermeture.service_id] ||= Hash.new
                @fermetures[fermeture.service_id][fj.to_s] = fermeture.nom
            end
        end

        @absences = Hash.new
        absences = Absence.where('date_fin >= ? AND date <= ?', @date, @date2).order(:utilisateur_id, :date, :date_fin)
        absences.each do |absence|
            (absence.date..absence.date_fin).each do |aj|
                @absences[absence.utilisateur_id] ||= Hash.new
                @absences[absence.utilisateur_id][aj.to_s] = absence.accord
            end
        end

        # Charges les services
        @services = Service.order(:nom).select([:id,:nom])
        # Détermine le service à afficher
        unless params[:service]
            @current_service = nil
        else 
            @current_service = @services.find_by_id(params[:service])
        end

    end

    ############
    #   Week   #
    ############
    def specific_week
        unless params[:date]
            @date = Date.today
        else
            @date = params[:date].to_date
        end
        @absences = Hash.new
        @off = Hash.new
        @specific_day_works = Hash.new
        @jours = Hash.new
        utilisateurs_jours = Jour.where(numero_semaine: numeroSemainePourDate(@date)).order(:service_id, :utilisateur_id).select([:utilisateur_id, :service_id]).distinct.includes(:utilisateur, :service)
        utilisateurs_jours.each do |utilisateur_jour|
            @jours[utilisateur_jour.service] ||= Hash.new
            @jours[utilisateur_jour.service][utilisateur_jour.utilisateur] ||= Hash.new
            5.times do |i|
                i += 1
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][i] ||= Hash.new
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][i][false] = Jour.where(numero_semaine: numeroSemainePourDate(@date), numero_jour: i, utilisateur_id: utilisateur_jour.utilisateur_id, service_id: utilisateur_jour.service, am_pm: false).order(:service_id, :utilisateur_id, :numero_jour, :am_pm)
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][i][true] = Jour.where(numero_semaine: numeroSemainePourDate(@date), numero_jour: i, utilisateur_id: utilisateur_jour.utilisateur_id, service_id: utilisateur_jour.service, am_pm: true).order(:service_id, :utilisateur_id, :numero_jour, :am_pm)

                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][i][false].each do |jour|
                    @specific_day_works[jour] = WorkingList.for(jour).includes(:work)
                end
                @jours[utilisateur_jour.service][utilisateur_jour.utilisateur][i][true].each do |jour|
                    @specific_day_works[jour] = WorkingList.for(jour).includes(:work)
                end

                abs = Absence.at_for_user(@date.beginning_of_week+i.days, utilisateur_jour.utilisateur)
                abs.each do |a|
                    @absences[utilisateur_jour.utilisateur] ||= Hash.new
                    if a.accord
                        @absences[utilisateur_jour.utilisateur][i+1] =  true
                    else
                        @absences[utilisateur_jour.utilisateur][i+1] =  false
                    end
                end

                if Fermeture.at_for_service?(@date.beginning_of_week+i.days, utilisateur_jour.service)
                    @off[utilisateur_jour.service] ||= Array.new
                    @off[utilisateur_jour.service] << i
                end
            end
        end

        # Charges les services
        @services = Service.order(:nom).select([:id,:nom])
        # Détermine le service à afficher
        unless params[:service]
            @current_service = nil
        else 
            @current_service = @services.find_by_id(params[:service])
        end
    end


    private 

    def jour_params
        params.require(:jour).permit(:date, :utilisateur_id, :am_pm, :service_id)
    end

    def find_jour
        @jour = Jour.find(params[:id])
    end
    
end
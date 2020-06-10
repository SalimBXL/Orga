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
        unless params[:date]
            @date = Date.today
            @specific_day_jours = Jour.today.select([:id, :utilisateur_id, :service_id, :am_pm, :note]).includes(utilisateur: :groupe)
        else
            @date = params[:date].to_date
            @specific_day_jours = Jour.at_day(@date).select([:id, :utilisateur_id, :service_id, :am_pm, :note]).includes(utilisateur: :groupe)
        end
        @specific_day_jours.each do |jour|
            @specific_day_works[jour] = WorkingList.for(jour).includes(:work)
        end
    end

    ############
    #   Week   #
    ############
    def specific_week
        @specific_day_works = Hash.new
        @date = Date.today
        @jours = Hash.new
        utilisateurs_jours = Jour.where(numero_semaine: numeroSemainePourDate(@date)).order(:service_id).select([:utilisateur_id, :service_id]).distinct.includes(:utilisateur, :service)
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
            end
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
class HebdosController < ApplicationController
    before_action :find_hebdos, only: [:show, :edit, :update, :destroy]
    #before_action :read_konfig, only: [:specific_month, :secr_pet]

    #############
    #   INDEX   #
    #############
    def index
        # Log action
        log(request.path)

        session[:return_user_id] = nil

        if current_user.admin?
            @hebdos = Hebdo.order(numero_semaine: :desc).order(:utilisateur_id, :task_id).page(params[:page])
        else
            @hebdos = Hebdo.where(service: current_user.utilisateur.service).order(numero_semaine: :desc).order(:utilisateur_id, :task_id).page(params[:page])
        end
    end


    #############
    #   SHOW    #
    #############
    def show
        # Log action
        log(request.path)
    end


    #############
    #    NEW    #
    #############
    def new
        # Log action
        log(request.path)
        @hebdo = Hebdo.new
        find_utilisateurs
        @tsks = Task.order(:service_id, :groupe_id, :nom)
    end


    ##############
    #   CREATE   #
    ##############
    def create
        # Log action
        log(request.path)

        if params[:hebdo][:week]
            spl = params[:hebdo][:week].split("-")
            if spl.size == 2
                params[:hebdo][:year_id] = spl.first
                params[:hebdo][:numero_semaine] = spl.last[1..]
            end
            params[:hebdo].delete(:week)
        end

        @hebdo = Hebdo.create(hebdo_params)
        if @hebdo.save
            flash[:notice] = "Hebdo créé avec succès"
            redirect_to hebdos_path
        else
            render :new
        end
    end

    #############
    #   UPDATE  #
    #############
    def update
        # Log action
        log(request.path, I18n.t("hebdos.index.log_update"))

        if params[:hebdo][:week]
            spl = params[:hebdo][:week].split("-")
            if spl.size == 2
                params[:hebdo][:year_id] = spl.first
                params[:hebdo][:numero_semaine] = spl.last[1..]
            end
            params[:hebdo].delete(:week)
        end

        if @hebdo.update(hebdo_params)
            flash[:notice] = "Hebdo Modifié avec succès"    
        else 
            render :edit
        end

        redirect_to hebdos_path
    end

    #############
    #   EDIT    #
    #############
    def edit
        # Log action
        log(request.path, I18n.t("hebdos.index.log_edit"))
        find_utilisateurs
        @tsks = Task.order(:service_id, :groupe_id, :nom)
        
    end

    ##############
    #   DESTROY  #
    ##############
    def destroy
        # Log action
        log(request.path, I18n.t("hebdos.index.log_destroy"))
        @hebdo.destroy
    end


    ##########
    # GRILLE #
    ##########
    def grille
        log(request.path, "Show grille hebdos")

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
        annee = @date.year
        @date2 = (date_tmp.end_of_month+180.days).end_of_week
        annee2 = @date2.year
        
        # Charge les hebdos
        @completion = Hash.new
        @hebdos = Hash.new
        hebdos = Hebdo.where('year_id >= ?', @date.year).order(:utilisateur_id, :year_id, :numero_semaine)

        hebdos.each do |hebdo|
            @hebdos[hebdo.utilisateur_id] ||= Hash.new
            @hebdos[hebdo.utilisateur_id][hebdo.year_id] ||= Hash.new
            @hebdos[hebdo.utilisateur_id][hebdo.year_id][hebdo.numero_semaine] = hebdo

            @completion[hebdo.year_id] ||= Hash.new
            @completion[hebdo.year_id][hebdo.task_id] ||= 0
            @completion[hebdo.year_id][hebdo.task_id] = @completion[hebdo.year_id][hebdo.task_id] + 1
        end

        find_utilisateurs
    end
    

    private     

    def hebdo_params
        params.require(:hebdo).permit(:utilisateur_id, :task_id, :note, :numero_semaine, :year_id, :week)
    end

    def find_hebdos
        @hebdo = Hebdo.find(params[:id])
    end
 
end
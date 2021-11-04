class EventsController < ApplicationController
    before_action :check_logged_in
    before_action :find_event, only: [:show, :edit, :update, :destroy]

    def index
        # Log action
        log(request.path)
        if is_super_admin?
            @events = Event.order(date: :desc).order(:service_id).page(params[:page])
        else
            @events = Event.where(service: current_user.utilisateur.service).order(date: :desc).order(:service_id).page(params[:page])
        end
    end


    def show
        # Log action
        log(request.path)
    end


    def new
        # Log action
        log(request.path)
        @event = Event.new
    end
   

    def create
        # Log action
        log(request.path)
        @event = Event.create(event_params)
        if @event.save
            flash[:notice] = "Event créé avec succès"
            redirect_to events_path
        else
            render :new
        end
    end


    def update
        # Log action
        log(request.path, I18n.t("events.index.log_update"))
        if @event.update(event_params)
            flash[:notice] = "Event modifié avec succès"
            redirect_to events_path
        else 
            render :edit
        end
    end


    def edit
        # Log action
        log(request.path, I18n.t("events.index.log_edit"))
    end


    def destroy
        # Log action
        log(request.path, I18n.t("events.index.log_destroy"))
        @event.destroy
    end


    private

    def event_params
        params.require(:event).permit(:nom, :date, :service_id, :note)
    end
    

    def find_event
        @event = Event.find(params[:id])
    end

end
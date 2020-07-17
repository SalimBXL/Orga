class EventsController < ApplicationController
    before_action :find_event, only: [:show, :edit, :update, :destroy]

    def index
        @events = Event.order(date: :desc).order(:service_id).page(params[:page])
    end


    def show
    end


    def new
        @event = Event.new
    end
   

    def create
        @event = Event.create(event_params)
        if @event.save
            flash[:notice] = "Event créé avec succès"
            redirect_to events_path
        else
            render :new
        end
    end


    def update
        if @event.update(event_params)
            flash[:notice] = "Event modifié avec succès"
            redirect_to events_path
        else 
            render :edit
        end
    end


    def edit
    end


    def destroy
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
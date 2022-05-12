class PostitsController < ApplicationController
    before_action :check_logged_in
    before_action :find_postit, only: [:show, :edit, :update, :destroy, :take_it, :done]
    before_action :find_services, only: [:new, :edit]
    

    def index
        @postits = Postit.order(level: :desc).order(id: :desc).page(params[:page])
    end


    def show
    end


    def new
        @postit = Postit.new
    end


    def create
        @postit = Postit.create(postit_params)
        set_postit_utilisateur
        set_postit_level
        if @postit.save
            flash[:notice] = "Postit créé avec succès"
            redirect_to postits_path
        else
            render :new
        end
    end

    
    def update
        set_postit_utilisateur
        set_postit_level

        @postit.taken_id = current_user.utilisateur.id if @postit.level == 0 && !@postit.done_at.nil? && @postit.taken_id.nil?
        

        if @postit.update(postit_params)
            flash[:notice] = "postit modifié avec succès"
            redirect_to postits_path
        else
            render :edit
        end
    end


    def edit
    end

    
    def destroy
        @postit.destroy
    end


    def take_it
        if params[:id] != "-1"
            @postit.taken_id = current_user.utilisateur.id
            flash[:notice] = "postit modifié avec succès" if @postit.update(taken_id: current_user.utilisateur.id)
        end
        redirect_to home_path
    end

    def done
        @postit.done_at = Date.today()
        flash[:notice] = "postit modifié avec succès" if @postit.update(taken_id: current_user.utilisateur.id)
        redirect_to home_path
    end


    private 

    def postit_params
        params.require(:postit).permit(:title, :body, :level, :is_private, :taken_id, :done_at)
    end

    def find_postit
        @postit = Postit.find(params[:id]) if params[:id] != "-1"
    end

    def find_services
        @services = Service.order(:lieu_id, :nom)
    end

end
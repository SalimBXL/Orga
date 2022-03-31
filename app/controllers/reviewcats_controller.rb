class ReviewcatsController < ApplicationController
    before_action :check_logged_in
    before_action :find_reviewcats, only: [:show, :edit, :update, :destroy]

    def index
        @reviewcats = Reviewcat.page(params[:page])
    end


    def show
    end


    def new
        @reviewcat = Reviewcat.new
    end


    def create
        @reviewcat = Reviewcat.create(reviewcat_params)
        if @reviewcat.save
            flash[:notice] = "Cat créée avec succès"
            redirect_to reviewcats_path
        else
            render :new
        end
    end

    
    def update
        if @reviewcat.update(reviewcat_params)
            flash[:notice] = "Cat modifiée avec succès"
            redirect_to reviewcats_path
        else
            render :edit
        end
    end


    def edit
    end

    
    def destroy
        @reviewcat.destroy
    end

    private 

    def reviewcat_params
        params.require(:reviewcat).permit(:cat)
    end

    def find_reviewcats
        @reviewcat = Reviewcat.find(params[:id])
    end

end
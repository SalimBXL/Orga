class ProdDestinationsController < ApplicationController
  before_action :set_prod_destination, only: %i[ show edit update destroy ]

  # GET /prod_destinations or /prod_destinations.json
  def index
    @prod_destinations = ProdDestination.all
  end

  # GET /prod_destinations/1 or /prod_destinations/1.json
  def show
  end

  # GET /prod_destinations/new
  def new
    @prod_destination = ProdDestination.new
  end

  # GET /prod_destinations/1/edit
  def edit
  end

  # POST /prod_destinations or /prod_destinations.json
  def create
    @prod_destination = ProdDestination.new(prod_destination_params)

    respond_to do |format|
      if @prod_destination.save
        format.html { redirect_to prod_destinations_url(), notice: "Prod destination was successfully created." }
        format.json { render :show, status: :created, location: @prod_destination }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @prod_destination.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prod_destinations/1 or /prod_destinations/1.json
  def update
    respond_to do |format|
      if @prod_destination.update(prod_destination_params)
        format.html { redirect_to prod_destinations_url(), notice: "Prod destination was successfully updated." }
        format.json { render :show, status: :ok, location: @prod_destination }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @prod_destination.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prod_destinations/1 or /prod_destinations/1.json
  def destroy
    @prod_destination.destroy

    respond_to do |format|
      format.html { redirect_to prod_destinations_url, notice: "Prod destination was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prod_destination
      @prod_destination = ProdDestination.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def prod_destination_params
      params.require(:prod_destination).permit(:name)
    end
end

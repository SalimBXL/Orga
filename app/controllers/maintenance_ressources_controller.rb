class MaintenanceRessourcesController < ApplicationController
  before_action :set_maintenance_ressource, only: %i[ show edit update destroy ]

  # GET /maintenance_ressources or /maintenance_ressources.json
  def index
    @maintenance_ressources = MaintenanceRessource.order(:service_id, :name).page(params[:page])
  end

  # GET /maintenance_ressources/1 or /maintenance_ressources/1.json
  def show
  end

  # GET /maintenance_ressources/new
  def new
    @maintenance_ressource = MaintenanceRessource.new
    @services = Service.order(:nom);
  end

  # GET /maintenance_ressources/1/edit
  def edit
    @services = Service.order(:nom);
  end

  # POST /maintenance_ressources or /maintenance_ressources.json
  def create
    @maintenance_ressource = MaintenanceRessource.new(maintenance_ressource_params)

    respond_to do |format|
      if @maintenance_ressource.save
        format.html { redirect_to maintenance_ressources_url, notice: "Maintenance ressource was successfully created." }
        format.json { render :show, status: :created, location: @maintenance_ressource }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @maintenance_ressource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maintenance_ressources/1 or /maintenance_ressources/1.json
  def update
    respond_to do |format|
      if @maintenance_ressource.update(maintenance_ressource_params)
        format.html { redirect_to maintenance_ressources_url, notice: "Maintenance ressource was successfully updated." }
        format.json { render :show, status: :ok, location: @maintenance_ressource }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @maintenance_ressource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintenance_ressources/1 or /maintenance_ressources/1.json
  def destroy
    @maintenance_ressource.destroy

    respond_to do |format|
      format.html { redirect_to maintenance_ressources_url, notice: "Maintenance ressource was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maintenance_ressource
      @maintenance_ressource = MaintenanceRessource.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def maintenance_ressource_params
      params.require(:maintenance_ressource).permit(:name, :service_id)
    end
end

class MaintenancesController < ApplicationController
  before_action :set_maintenance, only: %i[ show edit update destroy ]

  # GET /maintenances or /maintenances.json
  def index
    @maintenances = Maintenance.order(date_start: :desc).page(params[:page])
    
  end

  # GET /maintenances/1 or /maintenances/1.json
  def show
  end

  # GET /maintenances/new
  def new
    @maintenance = Maintenance.new
    @ressources = MaintenanceRessource.order(:service_id, :name);
  end

  # GET /maintenances/1/edit
  def edit
    @ressources = MaintenanceRessource.order(:service_id, :name);
    @maintenance.creator_id = current_user.utilisateur.id
    @maintenance.contact_id = @maintenance.creator_id if @maintenance.contact_id.nil?
  end

  # POST /maintenances or /maintenances.json
  def create
    @maintenance = Maintenance.new(maintenance_params)
    @ressources = MaintenanceRessource.order(:service_id, :name);

    @maintenance.creator_id = current_user.utilisateur.id
    @maintenance.contact_id = @maintenance.creator_id if @maintenance.contact_id.nil?

    respond_to do |format|
      if @maintenance.save
        format.html { redirect_to maintenances_url, notice: "Maintenance was successfully created." }
        format.json { render :show, status: :created, location: @maintenance }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @maintenance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maintenances/1 or /maintenances/1.json
  def update
    @ressources = MaintenanceRessource.order(:service_id, :name);
    @maintenance.creator_id = current_user.utilisateur.id
    @maintenance.contact_id = @maintenance.creator_id if @maintenance.contact_id.nil?
    respond_to do |format|
      if @maintenance.update(maintenance_params)
        format.html { redirect_to maintenances_url, notice: "Maintenance was successfully updated." }
        format.json { render :show, status: :ok, location: @maintenance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @maintenance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintenances/1 or /maintenances/1.json
  def destroy
    @maintenance.destroy

    respond_to do |format|
      format.html { redirect_to maintenances_url, notice: "Maintenance was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  ##########
    # GRILLE #
    ##########
    def grille
      log(request.path, "Show grille maintenance")

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
      
      # Charge les maintenances
      @maintenances = Hash.new
      maintenances = Maintenance.where('date_end >= ?', @date).order(:date_start)

      maintenances.each do |maintenance|
        service = maintenance.maintenance_ressource.service
        @maintenances[maintenance.date_start] ||= Hash.new
        @maintenances[maintenance.date_start][service] ||= Hash.new
        @maintenances[maintenance.date_start][service][maintenance.maintenance_ressource] ||= Hash.new
        @maintenances[maintenance.date_start][service][maintenance.maintenance_ressource] = maintenance
      end

      @ressources = MaintenanceRessource.order(:service_id, :name)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maintenance
      @maintenance = Maintenance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def maintenance_params
      params.require(:maintenance).permit(:name, :date_start, :date_end, :contact_id, :maintenance_ressource_id)
    end

end

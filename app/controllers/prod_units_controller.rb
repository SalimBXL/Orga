class ProdUnitsController < ApplicationController
  before_action :set_prod_unit, only: %i[ show edit update destroy ]

  # GET /prod_units or /prod_units.json
  def index
    @prod_units = ProdUnit.all
  end

  # GET /prod_units/1 or /prod_units/1.json
  def show
  end

  # GET /prod_units/new
  def new
    @prod_unit = ProdUnit.new
  end

  # GET /prod_units/1/edit
  def edit
  end

  # POST /prod_units or /prod_units.json
  def create
    @prod_unit = ProdUnit.new(prod_unit_params)

    respond_to do |format|
      if @prod_unit.save
        format.html { redirect_to prod_unit_url(@prod_unit), notice: "Prod unit was successfully created." }
        format.json { render :show, status: :created, location: @prod_unit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @prod_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prod_units/1 or /prod_units/1.json
  def update
    respond_to do |format|
      if @prod_unit.update(prod_unit_params)
        format.html { redirect_to prod_unit_url(@prod_unit), notice: "Prod unit was successfully updated." }
        format.json { render :show, status: :ok, location: @prod_unit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @prod_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prod_units/1 or /prod_units/1.json
  def destroy
    @prod_unit.destroy

    respond_to do |format|
      format.html { redirect_to prod_units_url, notice: "Prod unit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prod_unit
      @prod_unit = ProdUnit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def prod_unit_params
      params.require(:prod_unit).permit(:name)
    end
end

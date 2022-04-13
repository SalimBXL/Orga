class TraceursController < ApplicationController
  before_action :set_traceur, only: %i[ show edit update destroy ]

  # GET /traceurs or /traceurs.json
  def index
    @traceurs = Traceur.all
  end

  # GET /traceurs/1 or /traceurs/1.json
  def show
  end

  # GET /traceurs/new
  def new
    @traceur = Traceur.new
  end

  # GET /traceurs/1/edit
  def edit
  end

  # POST /traceurs or /traceurs.json
  def create
    @traceur = Traceur.new(traceur_params)

    respond_to do |format|
      if @traceur.save
        format.html { redirect_to traceur_url(@traceur), notice: "Traceur was successfully created." }
        format.json { render :show, status: :created, location: @traceur }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @traceur.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /traceurs/1 or /traceurs/1.json
  def update
    respond_to do |format|
      if @traceur.update(traceur_params)
        format.html { redirect_to traceur_url(@traceur), notice: "Traceur was successfully updated." }
        format.json { render :show, status: :ok, location: @traceur }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @traceur.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /traceurs/1 or /traceurs/1.json
  def destroy
    @traceur.destroy

    respond_to do |format|
      format.html { redirect_to traceurs_url, notice: "Traceur was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_traceur
      @traceur = Traceur.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def traceur_params
      params.require(:traceur).permit(:code, :name)
    end
end

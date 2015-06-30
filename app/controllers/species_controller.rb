class SpeciesController < ApplicationController
  before_action :set_species, only: [:show, :update, :destroy]

  # GET /species
  # GET /species.json
  def index
    @species = Species.where(query_params)
    render json: @species
  end

  # GET /species/1
  # GET /species/1.json
  def show
    render json: @species
  end

  # POST /species
  # POST /species.json
  def create
    @species = Species.new(species_params)

    if @species.save
      render json: @species, status: :created, location: @species
    else
      render json: @species.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /species/1
  # PATCH/PUT /species/1.json
  def update
    @species = Species.find(params[:id])

    if @species.update(species_params)
      head :no_content
    else
      render json: @species.errors, status: :unprocessable_entity
    end
  end

  # DELETE /species/1
  # DELETE /species/1.json
  def destroy
    @species.destroy

    head :no_content
  end

  private

    def set_species
      @species = Species.find(params[:id])
    end

    def species_params
      params.require(:species).permit(:name, :diet, :aasm_state)
    end

    def query_params
      params.permit(:name, :diet, :aasm_state)
    end
end

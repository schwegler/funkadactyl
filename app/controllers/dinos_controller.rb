class DinosController < ApplicationController
  before_action :set_dino, only: [:show, :update, :destroy]

  # GET /dinos
  # GET /dinos.json
  def index
    @dinos = Dino.where(query_params)
    render json: @dinos
  end

  # GET /dinos/1
  # GET /dinos/1.json
  def show
    render json: @dino
  end

  # POST /dinos
  # POST /dinos.json
  def create
    @dino = Dino.new(dino_params)

    if @dino.save
      render json: @dino, status: :created, location: @dino
    else
      render json: @dino.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dinos/1
  # PATCH/PUT /dinos/1.json
  def update
    @dino = Dino.find(params[:id])

    if @dino.update(dino_params)
      head :no_content
    else
      render json: @dino.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dinos/1
  # DELETE /dinos/1.json
  def destroy
    @dino.destroy

    head :no_content
  end

  private

    def set_dino
      @dino = Dino.find(params[:id])
    end

    def dino_params
      params.require(:dino).permit(:name, :species_id, :cage_id)
    end

    def query_params
      params.permit(:name, :species_id, :cage_id)
    end
end

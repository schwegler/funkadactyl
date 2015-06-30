class CagesController < ApplicationController
  before_action :set_cage, only: [:show, :update, :destroy]

  # GET /cages
  # GET /cages.json
  def index
    @cages = Cage.where(query_params)
    render json: @cages
  end

  # GET /cages/1
  # GET /cages/1.json
  def show
    render json: @cage
  end

  # POST /cages
  # POST /cages.json
  def create
    @cage = Cage.new(cage_params)

    if @cage.save
      render json: @cage, status: :created, location: @cage
    else
      render json: @cage.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cages/1
  # PATCH/PUT /cages/1.json
  def update
    @cage = Cage.find(params[:id])

    if @cage.update(cage_params)
      head :no_content
    else
      render json: @cage.errors, status: :unprocessable_entity
    end
  end

  def power_down
    @cage = Cage.find(params[:id])
    if @cage.may_power_down? 
      @cage.power_down!
      head :no_content
    else
      render :json => {:error => "Cage is occupied, so it can't power down."}.to_json, :status => 403
    end
  end

  # DELETE /cages/1
  # DELETE /cages/1.json
  def destroy
    @cage.destroy

    head :no_content
  end

  private

    def set_cage
      @cage = Cage.find(params[:id])
    end

    def cage_params
      params.require(:cage).permit(:capacity)
    end

    def query_params
      params.permit(:capacity, :aasm_state)
    end
end

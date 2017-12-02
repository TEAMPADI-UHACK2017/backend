class TipeesController < ApplicationController
  before_action :set_tipee, only: [:show, :edit, :update, :destroy]

  # GET /tipees
  # GET /tipees.json
  def index
    @tipees = Tipee.all
    json_response(@tipees)
  end

  # GET /tipees/1
  # GET /tipees/1.json
  def show
  end

  # GET /tipees/new
  def new
    @tipee = Tipee.new
  end

  # GET /tipees/1/edit
  def edit
  end

  # POST /tipees
  # POST /tipees.json
  def create
    @tipee = Tipee.new(tipee_params)

    respond_to do |format|
      if @tipee.save
        format.html { redirect_to @tipee, notice: 'Tipee was successfully created.' }
        format.json { render :show, status: :created, location: @tipee }
      else
        format.html { render :new }
        format.json { render json: @tipee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipees/1
  # PATCH/PUT /tipees/1.json
  def update
    respond_to do |format|
      if @tipee.update(tipee_params)
        format.html { redirect_to @tipee, notice: 'Tipee was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipee }
      else
        format.html { render :edit }
        format.json { render json: @tipee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipees/1
  # DELETE /tipees/1.json
  def destroy
    @tipee.destroy
    respond_to do |format|
      format.html { redirect_to tipees_url, notice: 'Tipee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipee
      @tipee = Tipee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipee_params
      params.fetch(:tipee, {})
    end
end

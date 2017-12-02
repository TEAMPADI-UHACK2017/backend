class TippersController < ApplicationController
  # before_action :authenticate_tipper!
  before_action :set_tipper, only: [:show, :edit, :update, :destroy]

  # GET /tippers
  # GET /tippers.json
  def index
    @tippers = Tipper.all
    json_response(@tippers)
  end

  # GET /tippers/1
  # GET /tippers/1.json
  def show
  end

  # GET /tippers/<email>
  # GET /tippers/<email>.json
  def find
    @tipper = Tipper.find_by(email: params[:email])
    json_response(@tipper)
  end

  # GET /tippers/new
  def new
    @tipper = Tipper.new
  end

  # GET /tippers/1/edit
  def edit
  end

  # POST /tippers
  # POST /tippers.json
  def create
    @tipper = Tipper.new(tipper_params)

    respond_to do |format|
      if @tipper.save
        format.html { redirect_to @tipper, notice: 'Tipper was successfully created.' }
        format.json { render :show, status: :created, location: @tipper }
      else
        format.html { render :new }
        format.json { render json: @tipper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tippers/1
  # PATCH/PUT /tippers/1.json
  def update
    respond_to do |format|
      if @tipper.update(tipper_params)
        format.html { redirect_to @tipper, notice: 'Tipper was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipper }
      else
        format.html { render :edit }
        format.json { render json: @tipper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tippers/1
  # DELETE /tippers/1.json
  def destroy
    @tipper.destroy
    respond_to do |format|
      format.html { redirect_to tippers_url, notice: 'Tipper was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipper
      @tipper = Tipper.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipper_params
      params.fetch(:tipper, {})
    end
end

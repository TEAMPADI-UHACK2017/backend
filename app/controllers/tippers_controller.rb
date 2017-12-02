class TippersController < ApplicationController
  # before_action :authenticate_tipper!
  before_action :set_tipper, only: [:show, :edit, :update, :destroy]
  before_action :set_tipee, only: [:transfer]

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

  def transfer
    # meron sa SECRETS na mga shizzzz
    # transfer_tipper POST   /tippers/:id/transfer(.:format)
    # tippers#transfer
    # RestClient.get 'http://example.com/resource', {params: {id: 50, 'foo' => 'bar'}}
    bank_client.get_token(params[:code])
    details = {
      account_no: @tipee.account_num,
      amount: params[:amount],
      remarks: 'Tip',
      particulars: 'Transfer particulars',
      info: [
          {
              index: 1,
              name: 'Recipient',
              value: @tipee.name
          },
          {
              index: 2,
              name: 'Message',
              value: '...'
          }
      ]
    }
    response = bank_client.transfer(details)
    response_body = JSON.parse(response.body)
    json_response(response_body)
  end

  def get_token
    json_response({url: bank_client.login_url})
  end

  def bank_client
    @bank_client ||= UnionbankClient.new(
        client_id:  Rails.application.secrets.unionbank_client_id,
        client_secret:  Rails.application.secrets.unionbank_client_secret,
        base_url:  Rails.application.secrets.unionbank_client_url,
        redirect_url:  Rails.application.secrets.unionbank_client_redirect_url
    )
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

  def set_tipee
    @tipee = Tipee.find(params[:tipee_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tipper_params
    params.fetch(:tipper, {})
  end
end

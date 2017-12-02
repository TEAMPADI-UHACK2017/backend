class UnionbankClient
  attr_accessor :client_id, :client_secret, :base_url, :redirect_url, :access_token

  def initialize(client_id: nil, client_secret: nil, base_url: 'https://api-uat.unionbankph.com/partners/sb', redirect_url: nil)
    @client_id = client_id
    @client_secret = client_secret
    @base_url = base_url
    @redirect_url = redirect_url
  end

  def self.foo
    {
        client_id:  Rails.application.secrets.unionbank_client_id,
        client_secret:  Rails.application.secrets.unionbank_client_secret,
        base_url:  Rails.application.secrets.unionbank_client_url,
        redirect_url:  Rails.application.secrets.unionbank_client_redirect_url
    }
  end

  def login_url
    "#{base_url}/convergent/v1/oauth2/authorize?client_id=#{client_id}&response_type=code&scope=transfers&redirect_uri=#{redirect_url}"
  end

  #   curl -X POST \
  # https://api-uat.unionbankph.com/partners/sb/convergent/v1/oauth2/token \
  # -H 'accept: {{accept}}' \
  # -H 'cache-control: no-cache' \
  # -H 'content-type: application/x-www-form-urlencoded' \
  # -H 'postman-token: 76107703-f02b-0e7d-bdec-c0bfa470f111' \
  # -d 'grant_type=authorization_code&client_id=9e095597-9cab-4073-a061-b4da4aa2d267&code=AAL0Do9kQGKWWo5WMo45yOvBfY-ivzOExeUvhT_9TpgFkjSQAJ9s1A-3qRlJMZNJlU7gGnV-pkzewO_ScAsPo8DYt7XSPESE91ck35kEthdfkwS6dl2BWD7h5Wcmz7VGb6tJDQQ21m_VI-Vy5gNl4em_7goVUnKjFrXblUadBxCzf9EfT03znGd2PfBpENPziLYWi8LhUxldgvwMi3C8iNotq5IOgp3fsW06kIy4g-zQzVJTCPpmWYnbNZABPxc6FRnRfbOhUNWe_dgYftEzEsimaxnfsCOeWWH26gwbnTYE2UIgchkOFuQiBx7gHRQ2wVuo7x491dOTiKmRwRabLXYAKJgEo5cEfJ-QjyiopmiSeA&redirect_uri=http%3A%2F%2Ftipkuu.herokuapp.com%2Fmerchants%2Funionbank_callback'
  def get_token(code)
    url = "#{base_url}/convergent/v1/oauth2/token"
    payload = "grant_type=authorization_code&client_id=#{client_id}&code=#{code}&redirect_uri=#{redirect_url}"
    headers = {accept: 'text/html', content_type: 'application/x-www-form-urlencoded'}
    puts "url=#{url.ai}]"
    puts "headers=#{headers.ai}"
    puts "payload=#{payload.ai}"
    response = RestClient.post url, payload, headers
    body_hash = JSON.parse(response.body)
    @access_token = body_hash['access_token']
    body_hash
  end


  # curl -X POST \
  # https://api-uat.unionbankph.com/partners/sb/online/v1/transfers/single \
  # -H 'accept: application/json' \
  # -H 'authorization: Bearer AAEkOWUwOTU1OTctOWNhYi00MDczLWEwNjEtYjRkYTRhYTJkMjY37F404czFfBSnbGSiQIQXko4W0C6a-b9trISx1yyUkEw5plVEeomhAU7r0RvSeCp3bTn_yvESszpSAhnmbe4wPhnnzJJf7FkWGeGiM40HY5k20Vvg7Hcc7QckaMvBu3t1MyuE4zYd3ylzr-vybhhbMQAj9CP6tz5iHFKL2paf7fLacPgonup04IOJsct4i0sR1I1ybrCtI61odjQ4Znxn4aEkqrkB5XhUVzcELUR1A3LxQQFScaCvuEOLmx2qTT7yNUOI8N-SxeoSD7MMvxjBoco9s_NEGwOAJKsf_yRSggGmNe8oDyhQP_HkZ4efsn42Ndb1aic4uSW6SxjY1YYoQw' \
  # -H 'cache-control: no-cache' \
  # -H 'content-type: application/json' \
  # -H 'postman-token: 3b3488e6-2067-4f6a-eb47-5ef4bed6de24' \
  # -H 'x-ibm-client-id: 9e095597-9cab-4073-a061-b4da4aa2d267' \
  # -H 'x-ibm-client-secret: H7aB1sR2vX1pI3uN6rY5pV3iU5pN4nN3fB4oS6hQ3dL8mQ5pN5' \
  # -d '{
  #       "senderTransferId":"00001",
  #       "transferRequestDate":"2017-12-02T12:11:50Z",
  #       "accountNo":"106826413545",
  #       "amount": {
  #         "currency":"PHP",
  #         "value":"100"
  #       },
  #       "remarks":"Transfer remarks",
  #       "particulars":"Transfer particulars",
  #       "info": [
  #         {
  #           "index":1,
  #           "name":"Recipient",
  #           "value":"Person 2"
  #         },
  #         {
  #           "index":2,
  #           "name":"Message",
  #           "value":"Happy Birthday"
  #         }
  #       ]
  #   }'
  #

  def transfer(account_no: nil, amount: 0, remarks: '', particulars: '', info: [])
    raise ArgumentError.new('No Account Number') if account_no.blank?
    url = "#{base_url}/online/v1/transfers/single"
    headers = {
        accept: 'application/json',
        authorization: "Bearer #{@access_token}",
        content_type: 'application/json',
        x_ibm_client_id: @client_id,
        x_ibm_client_secret: @client_secret,
    }
    payload = {
        senderTransferId: '00001',
        transferRequestDate:  DateTime.now.strftime('%FT%TZ'),
        accountNo: account_no,
        amount:{
            currency: 'PHP',
            value: amount.to_s
        },
        remarks: remarks,
        particulars: particulars,
        info: info
    }.to_json
    puts "url=#{url.ai}]"
    puts "headers=#{headers.ai}"
    puts "payload=#{payload.ai}"
    response = RestClient.post url, payload, headers
    response
  end
end
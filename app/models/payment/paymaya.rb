class Payment
  class PayMaya
    require 'base64'
    require 'rest_client'

    attr_accessor :public_key, :secret, :invoice, :user
    attr_accessor :buyer, :items, :redirect_url
    attr_accessor :request_reference_number, :headers

    def initialize(invoice)
      @invoice = invoice
      @user = invoice.user
      @plan = @user.plan
      @public_key = Rails.application.config.paymaya_public
      @secret_key = Rails.application.config.paymaya_secret
      @endpoint = Rails.application.config.paymaya_endpoint
    end

    def build_auth_headers
      @combined_secret = "#{@public_key}:"
      @headers = {
        'Content-Type' : 'application/json'
        'Authorization': "Basic #{Base64.encode64(@combined_secret)}"
      }
    end

    def build_payload
      @payload = {
        "totalAmount" : {
          "value":"#{@invoice.amount}",
          "currency":"PHP"
        },
        "buyer" : { 
          "firstName": "#{@user.name}",
          "lastName": "#{@user.nickname}",
          "contact" : {
             "email": "#{@user.email}"
          },
          "shippingAddress": {
            "line1": "23 ADB Ave.",
            "city": "Pasig",
            "state": "Manila",
            "zipCode": "1605",
            "countryCode": "PH"
          },
          "ipAddress": "125.60.148.241"
        },
        "items" : {
          "name": "#{@plan.pricing.name}",
          "quantity": "1",
          "totalAmount": {
            "value": "#{@plan.pricing.price}"
          }
        },
        "redirectUrl": {
          "success": "http://localhost:3000/v1/payment/success?id=#{@invoice.id}",
          "failure": "http://localhost:3000/v1/payment/failure?id=#{@invoice.id}",
          "cancel": "http://localhost:3000/v1/payment/cancel?id=#{@invoice.id}"
        },
        "requestReferenceNumber": "INV-0#{@invoice.id}",
        "metadata": {}
      }
    end

    def send_paymaya_request
      response = RestClient.post @endpoint, build_payload, build_auth_headers
      if response.success?
        redirect_to response.body[:redirectUrl]
      end
    end
  end
end

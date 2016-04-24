class Payment
  class Paymaya
    require 'base64'

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
        "Content-Type": "application/json",
        "Authorization": "Basic #{Base64.strict_encode64("pk-iaioBC2pbY6d3BVRSebsJxghSHeJDW4n6navI7tYdrN:")}"
      }.as_json
    end

    def build_payload
      @payload = {
        "totalAmount": {
          "value": "#{sprintf('%.2f', @invoice.amount)}",
          "currency":"PHP"
        },
        "buyer": { 
          "firstName": "#{@user.name}",
          "lastName": "#{@user.nickname}",
          "contact": {
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
        "items": [{
          "name": "#{@plan.pricing.name}",
          "quantity": "1",
          "totalAmount": {
            "value": "#{sprintf('%.1f', @plan.pricing.price)}"
          }
        }],
        "redirectUrl": {
          "success": "http://localhost:3000/v1/payment/success?id=#{@invoice.id}",
          "failure": "http://localhost:3000/v1/payment/failure?id=#{@invoice.id}",
          "cancel": "http://localhost:3000/v1/payment/cancel?id=#{@invoice.id}"
        },
        "requestReferenceNumber": "INV-0#{@invoice.id}",
        "metadata": {}
      }.to_json
    end

    def link
      response = RestClient.post @endpoint, build_payload, build_auth_headers
      if response.net_http_res.code == "200"
        return JSON.parse(response.body)['redirectUrl']
      end
    end
  end
end

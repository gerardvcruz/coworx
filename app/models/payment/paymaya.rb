class Payment
  class Paymaya
    require "base64"

    attr_accessor :key, :secret, :invoice, :user
    attr_accessor :buyer, :items, :redirect_url
    attr_accessor :request_reference_number, :headers

    def initialize(invoice)
      @invoice = invoice
    end

    def auth_headers
      @combined_secret = "#{@key}:"
      @headers = {
        'Content-Type' : 'application/json'
        'Authorization': "Basic #{Base64.encode64(@combined_secret)}"
      }
    end

    def total_amount
      %Q{
        "value":"#{invoice.amount}",
        "currency":"PHP"
      }
    end
  end
end

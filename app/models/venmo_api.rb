class VenmoApi
    include ActiveModel::Model

    attr_accessor :call_venmo_api

    def self.return_venmo_json(sellerId, buyerPhone, note, price)
        return call_venmo_api(sellerId, buyerPhone, note, price)
    end

    def self.call_venmo_api(sellerId, buyerPhone, note, price)

        #This is the real URI
        #https://api.venmo.com/v1/payments

        #This is the sandbox URI
        uri = URI('https://sandbox-api.venmo.com/v1/payments')
        params = { :access_token => sellerId, 
                  :amount => price, 
                  :phone => buyerPhone, 
                  :note => note ||= "Buckbucket",
                  :email => email ||= nil,
                  :uid => uid ||= nil }

        response = Net::HTTP.post_form(uri, params)
        response_json = JSON.parse(response.body)

        return response_json
    end

    private_class_method :call_venmo_api
end
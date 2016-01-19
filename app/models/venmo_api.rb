class VenmoApi
    include ActiveModel::Model

    attr_accessor :call_venmo_api

    def self.return_venmo_json(claim)
        marker = Marker.find(claim.marker_id)
        owner = User.find(claim.owner_id)
        claimer = User.find(claim.claimer_id)
        owner_access_token = Identity.find_by(user_id: owner.id).venmo_access_token
        note = marker.title
        price = marker.price

        params = { :access_token => owner_access_token,
                  :amount => price, 
                  :phone => claimer.phone, 
                  :note => note ||= "Buckbucket",
                  :email => email ||= nil,
                  :uid => uid ||= nil }

        return call_venmo_api(params)
    end

    def self.call_venmo_api(params)

        #This is the real URI
        #https://api.venmo.com/v1/payments

        #This is the sandbox URI
        uri = URI('https://sandbox-api.venmo.com/v1/payments')

        response = Net::HTTP.post_form(uri, params)
        response_json = JSON.parse(response.body)

        return response_json
    end

    def expired?
        expires_at < Time.now
    end

    def fresh_token
        refresh! if expired?
        access_token
    end

    private_class_method :call_venmo_api
end
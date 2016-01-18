class Identity < ActiveRecord::Base
    belongs_to :user

    def self.find_or_create_with_omniauth(auth_hash)
        identity = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])

        if identity.provider == 'venmo'
            identity.venmo_access_token = auth_hash['credentials']['token']
            identity.venmo_refresh_token = auth_hash['credentials']['refresh_token']
            identity.expires = auth_hash['credentials']['expires_in'].to_s
            identity.expires_on = Time.now + (auth_hash['credentials']['expires_in'].to_i).seconds
        end

        identity.save!
        return identity

    end
end

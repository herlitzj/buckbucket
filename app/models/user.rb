class User < ActiveRecord::Base
    has_many :markers, dependent: :destroy
    has_many :identities

    def self.create_with_omniauth(auth_hash)
        user = create()
        user.name = auth_hash['info']['name']
        if auth_hash["provider"] == 'google'
            user.email ||= auth_hash['info']['email']
        elsif auth_hash["provider"] == 'twitter'
            user.location ||= auth_hash['info']['location']
            user.nickname ||= auth_hash['info']['nickname']
            user.url ||= auth_hash['info']['urls']['Twitter']
        elsif auth_hash["provider"] == 'facebook'
            user.email ||= auth_hash['info']['email']
        elsif auth_hash["provider"] =='venmo'
            user.email ||= auth_hash['info']['email']
            user.phone ||= auth_hash['info']['phone']
            user.url ||= auth_hash['info']['urls']['profile']
        end
        user.save!
        user
    end
end

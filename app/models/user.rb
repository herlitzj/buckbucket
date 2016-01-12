class User < ActiveRecord::Base
    has_many :markers, dependent: :destroy

    class << self
      def from_omniauth(auth_hash)
        user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
            user.name = auth_hash['info']['name']
        if user.provider == 'google'
            user.email = auth_hash['info']['email']
        elsif user.provider == 'twitter'
            user.location = auth_hash['info']['location']
            user.nickname = auth_hash['info']['nickname']
            user.url = auth_hash['info']['urls']['Twitter']
        elsif user.provider == 'facebook'
            user.email = auth_hash['info']['email']
        elsif user.provider =='venmo'
            user.email = auth_hash['info']['email']
            user.phone = auth_hash['info']['phone']
            user.venmo_token = auth_hash['credentials']['token']
            user.venmo_refresh_token = auth_hash['credentials']['refresh_token']
            user.url = auth_hash['info']['urls']['profile']
        end
        user.save!
        user
      end
    end

end

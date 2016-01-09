class User < ActiveRecord::Base
    has_many :markers, dependent: :destroy

    class << self
      def from_omniauth(auth_hash)
        user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
        user.name = auth_hash['info']['name']
        user.location = auth_hash['info']['location']
        user.email = auth_hash['info']['email']
        user.save!
        user
      end
    end

end

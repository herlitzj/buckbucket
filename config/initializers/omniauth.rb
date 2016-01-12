Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_SECRET"],
    image_aspect_ratio: 'square', image_size: 48, access_type: 'online', name: 'google'
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :venmo, ENV['VENMO_CLIENT_ID'], ENV['VENMO_CLIENT_SECRET'],
    :scope => 'access_profile,access_email,access_phone,make_payments'
end
if Rails.env.production?
  Geokit::Geocoders::GoogleGeocoder.api_key = ENV['GOOGLE_GEOCODE_KEY']
end

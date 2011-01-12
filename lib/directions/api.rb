module Directions
  class Api
    include HTTParty

    base_uri 'http://maps.google.com/maps/api/directions'

    default_params :sensor => false, :alternatives => false

    format :json

    def self.request(params)
      get('/json', :query => params)
    end
  end
end


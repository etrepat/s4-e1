module Directions
  class Api
    include HTTParty

    base_uri 'http://maps.google.com/maps/api/directions'

    default_params :sensor => false, :alternatives => false

    format :json

    def get_directions(query_params)
      self.class.get('/json', :query => query_params) rescue nil
    end
  end
end


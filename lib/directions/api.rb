module Directions
  class Api
    include HTTParty

    base_uri 'http://maps.google.com/maps/api/directions'

    default_params :sensor => false, :alternatives => false

    format :json

    def initalize(query_params)
      @query_params = query_params
    end

    attr_reader :query_params

    def get
      self.class.get('/json', :query => query_params) rescue nil
    end
  end
end


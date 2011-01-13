module Directions
  class Location
    def initialize(lat=0.0, lng=0.0)
      @lat = lat
      @lng = lng
    end

    attr_accessor :lat, :lng
  end
end


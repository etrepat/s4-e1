module Directions
  class Route
    attr_accessor :summary, :legs

    def initialize(attribs={})
      attribs.each do |k, v|
        m = "#{k}=".to_sym
        self.send(m, v) if self.respond_to?(m)
      end

      @summary ||= ''
      @legs    ||= []
    end

    def self.build_from_api_data(data)
      route = Directions::Route.new(:summary => data['summary'])
      data['legs'].each do |leg|
        route.legs << Directions::Leg.build_from_api_data(leg)
      end

      return route
    end
  end
end


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

    # TODO: calculate total route distance as the sum of all of its legs
    def distance
      return legs.last.distance unless legs.empty?
      Directions::Distance.new
    end

    # TODO: calculate total duration as the sum of all of its legs
    def duration
      return legs.last.duration unless legs.empty?
      Directions::Duration.new
    end

    def describe
      output = "Route: #{summary}"
      output << "\nFrom: #{legs.first.start_address}, to: #{legs.last.end_address}"
      output << "\n#{distance} - #{duration}\n"

      legs.each { |leg| output << "\n#{leg.describe}" }

      output
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


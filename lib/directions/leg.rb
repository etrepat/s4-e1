module Directions
  class Leg
    attr_accessor :steps, :distance, :duration, :start_location,
      :end_location, :start_address, :end_address

    def initialize(attribs={})
      attribs.each do |k, v|
        m = "#{k}=".to_sym
        self.send(m, v) if self.respond_to?(m)
      end

      @steps           ||= []
      @distance        ||= Directions::Distance.new
      @duration        ||= Directions::Duration.new
      @start_location  ||= Directions::Location.new
      @end_location    ||= Directions::Location.new
      @start_address   ||= ''
      @end_address     ||= ''
    end

    def self.build_from_api_data(data)
      attribs = {}
      attribs[:start_location]  = data['start_location']
      attribs[:end_location]    = data['end_location']
      attribs[:start_address]   = data['start_address']
      attribs[:end_address]     = data['end_address']

      attribs[:distance]        = Directions::Distance.new(
        data['distance']['value'].to_i, data['distance']['text']
      ) if data['distance']

      attribs[:duration]        = Directions::Duration.new(
        data['duration']['value'].to_i, data['duration']['text']
      ) if data['duration']

      leg = Directions::Leg.new(attribs)
      data['steps'].each do |step|
        leg.steps << Directions::Step.build_from_api_data(step)
      end

      return leg
    end
  end
end


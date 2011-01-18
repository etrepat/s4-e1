module Directions
  class Leg
    attr_accessor :steps, :distance, :duration, :start_location,
      :end_location, :start_address, :end_address

    def initialize(attribs={})
      @steps          = attribs.fetch(:steps, [])
      @distance       = attribs.fetch(:distance, Directions::Distance.new)
      @duration       = attribs.fetch(:duration, Directions::Duration.new)
      @start_location = attribs.fetch(:start_location, Directions::Location.new)
      @end_location   = attribs.fetch(:end_location, Directions::Location.new)
    end

    def to_s
      output = "#{start_address}"
      steps.each_with_index { |s,idx| output << "\n#{(idx+1).to_s}. #{s}" }
      output << "\n---\n#{distance} - #{duration}\n#{end_address}"
      output
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


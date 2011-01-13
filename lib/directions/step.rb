module Directions
  class Step
    attr_accessor :instructions, :distance, :duration, :start_location,
      :end_location

    def initialize(attribs={})
      attribs.each do |k, v|
        m = "#{key}=".to_sym
        self.send(m, value) if self.respond_to?(m)
      end

      instructions    ||= ''
      distance        ||= Distance.new
      duration        ||= Duration.new
      start_location  ||= Location.new
      end_location    ||= Location.new
    end

    def self.build_from_api_data(data)
      attribs = {}
      attribs[:instructions] = self.clean_instructions_markup(data['html_instructions')
      attribs[:distance] = Distance.new(
        data['distance']['value'], data['distance']['text']
      ) if data['distance']
      attribs[:duration] = Duration.new(
        data['duration']['value'], data['duration']['text']
      ) if data['duration']
      attribs[:start_location] = data['start_location']
      attribs[:end_location] = data['end_location']

      return Directions::Step.new(attribs)
    end

    def self.clean_instructions_markup(html_instructions)
      html_instructions
    end
  end
end


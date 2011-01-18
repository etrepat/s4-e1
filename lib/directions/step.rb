module Directions
  class Step
    attr_accessor :instructions, :distance, :duration, :start_location,
      :end_location

    def initialize(attribs={})
      @instructions   = attribs.fetch(:instructions, '')
      @distance       = attribs.fetch(:distance, Directions::Distance.new)
      @duration       = attribs.fetch(:duration, Directions::Duration.new)
      @start_location = attribs.fetch(:start_location, Directions::Location.new)
      @end_location   = attribs.fetch(:end_location, Directions::Location.new)
    end

    def describe
      "(#{distance}) #{instructions}"
    end

    def self.build_from_api_data(data)
      attribs = {}
      attribs[:instructions]    = self.clean_instructions_markup(data['html_instructions'])
      attribs[:start_location]  = data['start_location']
      attribs[:end_location]    = data['end_location']

      attribs[:distance]        = Directions::Distance.new(
        data['distance']['value'].to_i, data['distance']['text']
      ) if data['distance']

      attribs[:duration]        = Directions::Duration.new(
        data['duration']['value'].to_i, data['duration']['text']
      ) if data['duration']

      return Directions::Step.new(attribs)
    end

    def self.clean_instructions_markup(html_instructions)
      html = html_instructions.strip.chomp
      return Directions::Tools::HtmlToAnsi.convert(html)
    end
  end
end
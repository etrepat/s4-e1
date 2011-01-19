module Directions
  class Step
    attr_accessor :instructions, :distance, :duration, :start_location,
      :end_location

    def initialize(attribs={})
      @instructions   = attribs.fetch(:instructions, '')
      @distance       = attribs.fetch(:distance, Directions::Measure.new(0, :meters))
      @duration       = attribs.fetch(:duration, Directions::Measure.new(0, :seconds))
      @start_location = attribs.fetch(:start_location, Directions::Location.new)
      @end_location   = attribs.fetch(:end_location, Directions::Location.new)
    end

    def to_s
      "(#{distance}) #{instructions}"
    end

    def self.build_from_api_data(data)
      attribs = {}
      attribs[:instructions]    = self.clean_instructions_markup(data['html_instructions'])
      attribs[:start_location]  = data['start_location']
      attribs[:end_location]    = data['end_location']

      attribs[:distance]        = Directions::Measure.new(
        data['distance']['value'].to_i, :meters, data['distance']['text']
      ) if data['distance']

      attribs[:duration]        = Directions::Measure.new(
        data['duration']['value'].to_i, :seconds, data['duration']['text']
      ) if data['duration']

      return Directions::Step.new(attribs)
    end

    def self.clean_instructions_markup(html_instructions)
      html = html_instructions.strip.chomp
      return Directions::Tools::HtmlToAnsi.convert(html)
    end
  end
end
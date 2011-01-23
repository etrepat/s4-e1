module Directions
  class Measure
    BadUnitsError = Class.new(StandardError)

    VALID_UNITS = %w(meters seconds)

    def initialize(value, units='meters', text='')
      @value = value
      raise BadUnitsError unless VALID_UNITS.include?(units.to_s)
      @units = units
      @text = text
    end

    attr_accessor :value, :units, :text

    # for rapid printing
    def to_s
      return text unless text.strip.empty?
      "#{value} #{units}"
    end

    # this way we should be able to compare measures
    def eql?(measure)
      units == measure.units && @value == measure.value
    end
    
    alias_method :eql?, :==

    include Comparable

    def <=>(measure)
      raise TypeError, 'Incompatible types!' unless units == measure.units
      value <=> measure.value
    end
  end
end


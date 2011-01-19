module Directions
  class Measure
    class BadUnitsError < StandardError; end
    
    VALID_UNITS = %w(meters seconds)
    
    def initialize(value, units='meters', text='')
      @value = value
      @units = units
      raise BadUnitsError unless units_valid?
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

    include Comparable

    def <=>(measure)
      raise TypeError, 'Incompatible types!' unless units == measure.units
      value <=> measure.value
    end

    # TODO: should add operators for measures but I don't know how to automatically
    # re-localize measures text strings as they are returned by the Directions API
    #def +(measure)
    #  raise TypeError, 'Incompatible types!' unless self.class.equal?(measure.class)
    #end
    
    protected
    
    def units_valid?
      VALID_UNITS.include?(units.to_s)
    end
  end
end


module Directions
  class Measure
    def initialize(value=0, text='')
      @value = value
      @text = text
    end

    attr_accessor :value, :text

    # for rapid printing
    def to_s
      return text unless text.strip.empty?
      return value.to_s if value.to_i != 0
      'unknown'
    end

    # this way we should be able to compare measures
    def eql?(measure)
      self.class.equal?(measure.class) && @value == measure.value
    end

    include Comparable

    def <=>(measure)
      raise TypeError, 'Incompatible types!' unless self.class.equal?(measure.class)
      value <=> measure.value
    end

    # TODO: should add operators for measures but I don't know how to automatically
    # re-localize measures text strings as they are returned by the Directions API
    #def +(measure)
    #  raise TypeError, 'Incompatible types!' unless self.class.equal?(measure.class)
    #end
  end

  # values from duration are expressed in seconds
  class Duration < Measure; end

  # values from distance are expressed in meters
  class Distance < Measure; end
end

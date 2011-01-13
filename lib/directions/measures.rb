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

    # didn't know this but irb complained about not having an inspect method ¿?
    # it seems that this class inherits from BasicObject which does not have an
    # "inspect" method defined... well, here it is ;)
    def inspect
      inspect_id = "%x" % (object_id * 2)
      %(#<#{self.class}:0x#{inspect_id} @value=#{value.inspect}, @text=#{text.inspect}>)
    end
    
    # this way we should be able to compare measures
    def eql?(measure)
      self.class.equal?(measure) && @value == measure.value
    end
    
    include Comparable
    
    def <=>(measure)
      raise TypeError, 'Incompatible types!' unless self.class.equal?(measure)
      value <=> measure.value
    end
    
    def +(measure)
      raise TypeError, 'Incompatible types!' unless self.class.equal?(measure)
      # TODO: add functionality
    end
  end

  # values from duration are expressed in seconds
  class Duration < Measure; end

  # values from distance are expressed in meters
  class Distance < Measure; end
end


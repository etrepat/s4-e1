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
      return value if value.to_i != 0
      'unknown'
    end

    # didn't know this but irb complained about not having an inspect method ¿?
    # it seems that this class inherits from BasicObject which does not have an
    # "inspect" method defined... well, here it is ;)
    def inspect
      inspect_id = "%x" % (object_id * 2)
      %(#<#{self.class}:0x#{inspect_id} @value=#{value.inspect}, @text=#{text.inspect}>)
    end
  end

  # values from duration are expressed in seconds
  class Duration < Measure; end

  # values from distance are expressed in meters
  class Distance < Measure; end
end


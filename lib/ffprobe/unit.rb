require 'ruby_units'

class FFProbe
  class Unit < ::Unit
    def to_i
      scalar.to_i
    end
    
    def to_f
      scalar.to_f
    end
  end
end
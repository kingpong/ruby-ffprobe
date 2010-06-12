class FFProbe
  class Entity
    
    def self.from_hash(hash,units=false)
      target = new
      target.units = units
      hash.each {|k,v| target.__send__("#{k}=", v) }
      target
    end
    
    attr_accessor :units
    alias :units? :units
    
    def self.units(mapping)
      mapping.each do |property,unit|
        self.class_eval <<-EOF
          def #{property}=(val)
            if units?
              if val.nil?
                @#{property} = nil
              else
                @#{property} = Unit.new("\#{val} #{unit}")
              end
            else
              @#{property} = val
            end
          end
        EOF
      end
    end
    
  end
end
class FFProbe
  class Entity
    
    def self.from_hash(hash)
      target = new
      hash.each {|k,v| target.__send__("#{k}=", v) }
      target
    end
    
    @@class_units = {}
    def self.units(mapping)
      mapping.each do |property,unit|
        (@@class_units[self] ||= {})[property.to_sym] = unit
      end
    end
  end
end
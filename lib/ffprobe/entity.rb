class FFProbe
  class Entity
    
    def self.from_hash(hash)
      target = new
      hash.each {|k,v| target.instance_variable_set("@#{k}", v) }
      target
    end
    
  end
end
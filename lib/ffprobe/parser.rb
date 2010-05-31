class FFProbe
  class Parser
    
    def parse_stream(io)
      result = {}
      dest = nil
      io.each_line do |line|
        line.chomp!
        case line
        when /\A\[(\w+)\]\Z/
          (result[$1.to_sym] ||= []).push( dest = {} )
        when /\A\[\/(\w+)\]\Z/
          # ignored, stanzas can't nest.
        when /\A(\w+)=(.*)/
          if dest
            dest[$1.to_sym] = $2
          end
        end
      end
      result
    end
    
  end
end
class FFProbe
  class Parser
    
    def parse_stream(io)
      result = {}
      dest = nil
      io.each_line do |line|
        # $stderr.puts line
        line.chomp!
        case line
        when /\A\[(\w+)\]\Z/
          (result[$1.to_sym] ||= []).push( dest = {} )
        when /\A\[\/(\w+)\]\Z/
          # ignored, stanzas can't nest.
        when /\A(\w+)=(.*)/
          if dest
            dest[$1.to_sym] = $2 == "N/A" ? nil : $2.strip
          end
        else
          (result[:EXTRA] ||= []).push(line)
        end
      end
      result
    end
    
  end
end

class FFProbe
  class Result
    
    def self.from_stream(io,units=false)
      from_hash(Parser.new.parse_stream(io), units)
    end

    def self.from_hash(hash,units=false)
      target = new
      target.units = units
      hash.each do |key,value|
        case key
        when :FILE
          target.file = FileInfo.from_hash(value[0], units)
        when :FRAME
          target.frames += value.map {|f| FrameInfo.from_hash(f, units) }
        when :PACKET
          target.packets += value.map {|p| PacketInfo.from_hash(p, units) }
        when :STREAM
          target.streams += value.map {|s| StreamInfo.from_hash(s, units) }
        when :TAGS
          target.tags = TagsInfo.from_hash(value[0], units)
        when :EXTRA
          target.extra = Array.new(value)
        end
      end
      target
    end
    
    attr_accessor :file
    attr_accessor :frames
    attr_accessor :packets
    attr_accessor :streams
    attr_accessor :tags
    attr_accessor :extra

    attr_accessor :pretty
    alias :pretty? :pretty
    
    attr_accessor :success
    alias :success? :success
    
    attr_accessor :units
    alias :units? :units
    
    def initialize
      @file = FileInfo.new
      @frames = []
      @packets = []
      @streams = []
      @tags = TagsInfo.new
      @extra = []
    end
    
  end
end

class FFProbe
  class Result
    
    def self.from_stream(io)
      from_hash(Parser.new.parse_stream(io))
    end

    def self.from_hash(hash)
      target = new
      hash.each do |key,value|
        case key
        when :FILE
          target.file = FileInfo.from_hash(value[0])
        when :FRAME
          target.frames += value.map {|f| FrameInfo.from_hash(f) }
        when :PACKET
          target.packets += value.map {|p| PacketInfo.from_hash(p) }
        when :STREAM
          target.streams += value.map {|s| StreamInfo.from_hash(s) }
        when :TAGS
          target.tags = TagsInfo.from_hash(value[0])
        when :EXTRA
          target.extra = Array.new(value)
        else
          warn "encountered unexpected hash key #{key}"
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
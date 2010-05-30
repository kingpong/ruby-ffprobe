class FFProbe
  class Info
    
    attr_reader :file, :frames, :packets, :streams, :tags
    
    def initialize
      @file    = FileInfo.new
      @frames  = []
      @packets = []
      @streams = []
      @tags    = TagsInfo.new
    end
    
  end
end
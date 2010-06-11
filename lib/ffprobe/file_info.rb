class FFProbe
  class FileInfo < Entity
    
    attr_reader :filename, :nb_streams, :demuxer_name, :demuxer_long_name,
                :start_time, :duration, :size, :bit_rate
    
  end
end
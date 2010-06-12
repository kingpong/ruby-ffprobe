class FFProbe
  class FileInfo < Entity
    
    attr_accessor :filename, :nb_streams, :demuxer_name, :demuxer_long_name,
                  :start_time, :duration, :size, :bit_rate,
                  :probed_size, :probed_nb_pkts, :probed_nb_frames

    units :start_time => "s",
          :duration => "s",
          :size => "byte",
          :bit_rate => "bit/s"

  end
end
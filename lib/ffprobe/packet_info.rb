class FFProbe
  class PacketInfo < Entity
    
    attr_accessor :codec_type, :stream_index, :pts, :pts_time, :dts, :dts_time,
                  :size, :file_pkt_nb, :stream_pkt_nb, :duration_ts, :duration_time, :flag_key
                
    units :pts_time => "s",
          :dts_time => "s",
          :size => "byte",
          :duration_time => "s"

  end
end

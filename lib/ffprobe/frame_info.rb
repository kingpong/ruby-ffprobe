class FFProbe
  class FrameInfo < Entity
    
    attr_accessor :codec_type, :pict_type, :quality, :coded_picture_number, :display_picture_number,
                  :interlaced_frame, :repeat_pict, :reference, :samples_size, :stream_index,
                  :size, :pkt_pts, :pkt_dts, :pkt_duration, :file_pkt_nb, :stream_pkt_nb, :pkt_flag_key

    units :size => "byte",
          :pkt_pts => "s",
          :pkt_dts => "s",
          :pkt_duration => "s",
          :samples_size => "byte"

  end
end
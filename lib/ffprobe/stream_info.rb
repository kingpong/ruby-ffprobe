class FFProbe
  class StreamInfo < Entity
    
    attr_accessor :codec_name, :codec_long_name, :codec_time_base,
                  :codec_tag_string, :decoder_time_base, :codec_type, :codec_tag,
                  :r_frame_rate, :r_frame_rate_num, :r_frame_rate_den,
                  :width, :height, :gop_size, :has_b_frames, :sample_aspect_ratio,
                  :display_aspect_ratio, :pix_fmt, :index, :time_base,
                  :start_time, :duration, :nb_frames, :avg_frame_rate,
                  :sample_rate, :channels, :bits_per_sample,
                  :probed_size, :probed_nb_pkts, :probed_nb_frames

    units :start_time => "s",
          :sample_rate => "kHz",
          :duration => "s"

  end
end

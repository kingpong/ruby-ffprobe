class FFProbe
  class StreamInfo < Entity
    
    attr_reader :codec_name, :decoder_time_base, :codec_type, :r_frame_rate,
                :r_frame_rate_num, :r_frame_rate_den,
                :width, :height, :gop_size, :has_b_frames, :sample_aspect_ratio,
                :display_aspect_ratio, :pix_fmt, :index, :time_base,
                :start_time, :duration, :nb_frames,
                :sample_rate, :channels, :bits_per_sample

  end
end

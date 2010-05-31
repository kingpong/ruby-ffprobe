#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__),"..","helper.rb")

class TestFfprobe
  class TestParser < Test::Unit::TestCase

    context "A Parser" do
    
      setup do
        @parser = @instance = FFProbe::Parser.new
      end
      
      should_respond_to :parse_stream
      
      context "given empty ffprobe results" do
        setup do
          @parsed = @parser.parse_stream(open_testcase("no_args"))
        end
        
        should "return an empty hash" do
          assert_equal @parsed, {}
        end
      end
      
      context "given movie ffprobe results" do
        setup do
          @parsed = @parser.parse_stream(open_testcase("files_streams_tags"))
        end
        
        should "return a non-empty result" do
          assert_not_equal 0, @parsed.length
        end
        
        should "have only Symbol keys" do
          @parsed.keys.each {|key| assert_kind_of Symbol, key }
        end

        should "have only Array values" do
          @parsed.values.each {|value| assert_kind_of Array, value }
        end
        
        context "in FILE stanza" do
          setup do
            @files = @parsed[:FILE]
            @file = @files.first if @files
          end
          
          should "have one" do
            assert_equal 1, @files.length
          end
          
          should "have a filename" do
            assert_match /./, @file[:filename]
          end
          
          should "have a number of streams" do
            assert_match /\A\d+\Z/, @file[:nb_streams]
          end
          
          should "have a demuxer name" do
            assert_match /./, @file[:demuxer_name]
          end
          
          should "have a demuxer long name" do
            assert_match /./, @file[:demuxer_long_name]
          end
          
          should "have a start time" do
            assert_match /\d/, @file[:start_time]
          end
          
          should "have a duration" do
            assert_match /\d/, @file[:duration]
          end
          
          should "have a size" do
            assert_match /\d/, @file[:size]
          end
          
          should "have a bit rate" do
            assert_match /\d/, @file[:bit_rate]
          end
        end
        
        context "in STREAM stanzas" do
          setup do
            @streams = @parsed[:STREAM]
            @video_stream = @streams.first if @streams
            @audio_stream = @streams.last if @streams
          end

          should "have a video stream and an audio stream" do
            assert_equal 2, @streams.length
            assert_equal "video", @video_stream[:codec_type]
            assert_equal "audio", @audio_stream[:codec_type]
          end
          
          should_have_string_value :@video_stream, %w(
            codec_name codec_type pix_fmt
          )
          should_have_numeric_value :@video_stream, %w(
            decoder_time_base r_frame_rate r_frame_rate_num r_frame_rate_den
            width height gop_size has_b_frames sample_aspect_ratio display_aspect_ratio
            index time_base start_time nb_frames
          )
          
          should_have_string_value :@audio_stream, %w(
            codec_name codec_type
          )
          should_have_numeric_value :@audio_stream, %w(
            decoder_time_base sample_rate channels bits_per_sample index
            time_base start_time duration nb_frames
          )
        end
                
        context "in TAGS stanza" do
          setup do
            @tags_stanzas = @parsed[:TAGS]
            @tags = @tags_stanzas.first if @tags_stanzas
          end

          should "have one" do
            assert_equal 1, @tags_stanzas.length
          end
          
          should "have keys from id3v1" do
            assert_equal %w(track title author copyright comment album year genre).sort,
                         @tags.keys.map(&:to_s).sort
          end

        end

   
      end
      
    end
    
  end
end







#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__),"..","helper.rb")

class TestFfprobe
  class TestFileInfo < Test::Unit::TestCase

    context "A FileInfo instance" do
      
      context "that is new" do
        setup do
          @instance = FFProbe::FileInfo.new
        end
        
        should_respond_to :@instance, 
                          :filename, :nb_streams, :demuxer_name, :demuxer_long_name,
                          :start_time, :duration, :size, :bit_rate
      end
      
    end
    
  end
end







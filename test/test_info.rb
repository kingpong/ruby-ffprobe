#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__),"helper.rb")

class FFProbe
  class InfoTest < Test::Unit::TestCase

    context "A blank Info instance" do
      setup do
        @info = FFProbe::Info.new
      end
    
      should "have a file object" do
        assert_kind_of FileInfo, @info.file
      end
      
      should "have an array of frames" do
        assert_kind_of Array, @info.frames
      end
      
      should "have an array of packets" do
        assert_kind_of Array, @info.packets
      end
      
      should "have an array of streams" do
        assert_kind_of Array, @info.streams
      end
      
      should "have a tags object" do
        assert_kind_of TagsInfo, @info.tags
      end
    end
    
  end
end
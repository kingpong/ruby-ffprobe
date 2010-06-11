#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__),"helper.rb")

class FFProbe
  class ResultTest < Test::Unit::TestCase

    context "An Result instance" do
      
      context "that is new" do
        setup do
          @result = FFProbe::Result.new
        end
    
        should "have a file object" do
          assert_kind_of FileInfo, @result.file
        end
      
        should "have an array of frames" do
          assert_kind_of Array, @result.frames
        end
        
        should "have no frames" do
          assert_equal 0, @result.frames.length
        end
      
        should "have an array of packets" do
          assert_kind_of Array, @result.packets
        end
        
        should "have no packets" do
          assert_equal 0, @result.packets.length
        end
      
        should "have an array of streams" do
          assert_kind_of Array, @result.streams
        end
        
        should "have no streams" do
          assert_equal 0, @result.streams.length
        end
      
        should "have a tags object" do
          assert_kind_of TagsInfo, @result.tags
        end
      end
      
    end
    
  end
end

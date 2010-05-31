#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__),"..","helper.rb")

class TestFfprobe
  class TestFileInfo < Test::Unit::TestCase

    context "A FileInfo instance" do
      
      context "that is new" do
        setup do
          @info = FFProbe::FileInfo.new
        end
    
        should "respond to #filename" do
          assert_respond_to @info, :filename
        end
        
        should "respond to #nb_streams" do
          assert_respond_to @info, :nb_streams
        end
        
        should "respond to demuxer_name" do
          assert_respond_to @info, :demuxer_name
        end
        
        should "respond to demuxer_long_name" do
          assert_respond_to @info, :demuxer_long_name
        end
        
        should "respond to start_time" do
          assert_respond_to @info, :start_time
        end
        
        should "respond to duration" do
          assert_respond_to @info, :duration
        end
        
        should "respond to size" do
          assert_respond_to @info, :size
        end
        
        should "respond to bit_rate" do
          assert_respond_to @info, :bit_rate
        end
        
      end
      
    end
    
  end
end







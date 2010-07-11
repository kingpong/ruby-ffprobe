#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__),"..","helper.rb")

class TestFfprobe
  class TestFfprobe < Test::Unit::TestCase

    context "A default FFProbe instance" do
    
      setup do
        @ffprobe = FFProbe.new
      end
      
      should "not have any features enabled" do
        assert @ffprobe.features.length == 0
      end
      
      should "not be :pretty?" do
        assert !@ffprobe.pretty?
      end
    
    end
    
    context "A misconfigured FFProbe instance" do
      should "not accept invalid features" do
        assert_raise FFProbe::InvalidArgument do
          FFProbe.new(:read_packets, :invalid_feature)
        end
      end
      context "with a bad executable path" do
        setup do
          @original_executable = FFProbe.executable
          FFProbe.executable = "this file doesn't exist"
        end
        should "raise an exception" do
          assert_raise Errno::ENOENT do
            FFProbe.new.probe(testcase_path("source.ogv"))
          end
        end
        teardown do
          FFProbe.executable = @original_executable
        end
      end
    end
    
    context "A configured FFProbe instance" do
      setup do
        # make sure features are loaded
        @features = FFProbe.implemented_features.dup
        @ffprobe = FFProbe.new(*@features)
      end
      should "retain its configuration" do
        assert @ffprobe.features.length == @features.length
        @features.each {|f| @ffprobe.features.include?(f) }
      end
      should "be :pretty?" do
        assert @ffprobe.pretty?
      end
      context "probing a file" do
        should "return successfully" do
          @ffprobe.probe(testcase_path("source.ogv"))
        end
      end
    end
    
  end
end







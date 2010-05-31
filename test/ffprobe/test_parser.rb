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
                
        should "have two STREAM stanzas" do
          assert_equal 2, @parsed[:STREAM].length
        end
        
        should "have one TAGS stanza" do
          assert_equal 1, @parsed[:TAGS].length
        end
      end
      
    end
    
  end
end







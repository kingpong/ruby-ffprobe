#!/usr/bin/env ruby
$LOAD_PATH.unshift("lib") unless $LOAD_PATH.include?("lib")
require 'rubygems'
require 'ffprobe'

ffprobe = FFProbe.new(:show_format,:show_streams,:units)
result = ffprobe.probe("test/testcases/source.ogv")
result.streams.sort_by(&:index).each_with_index do |s,i|
  puts "Stream #{s.index}: #{s.codec_type}/#{s.codec_name}"
end

puts result.inspect


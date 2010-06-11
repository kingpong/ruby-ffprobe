#
# ffprobe.rb
#
# Copyright (c) 2010 Philip Garrett.
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

require 'ffprobe/entity'
require 'ffprobe/file_info'
require 'ffprobe/frame_info'
require 'ffprobe/packet_info'
require 'ffprobe/parser'
require 'ffprobe/result'
require 'ffprobe/stream_info'
require 'ffprobe/tags_info'

class FFProbe
  
  class << self
    attr_accessor :executable
  end
  self.executable ||= "ffprobe"
  
  class InvalidArgument < StandardError; end
  
  FEATURES = [ :read_packets, :read_frames, :show_files, :show_frames, :show_packets, :show_streams, :show_tags, :pretty ]
  FEATURES.each {|feature| attr_accessor(feature) }
  
  DEFAULT_FEATURES = [:show_streams,:show_tags]
  
  attr_accessor :features
  attr_accessor :success
  alias :success? :success
  
  def features=(desired_features)
    @features = desired_features.each {|feature|
      raise(InvalidArgument, "Unrecognized feature #{feature}") unless FEATURES.include?(feature)
    }
  end
  
  def initialize(*desired_features)
    desired_features = DEFAULT_FEATURES if desired_features.empty?
    self.features = desired_features
  end
  
  def probe(filename)
    params = features.map {|f| "-#{f.to_s}" }
    params << filename
    result = nil
    pipe_command(executable, *params) do |stream|
      result = Result.from_stream(stream)
    end
    result.pretty = self.pretty? if result
    result
  end
  
  def pretty?
    features.include?(:pretty)
  end
  
  private
  
  def executable
    self.class.executable
  end
  
  # Runs a command and yields an IO object opened for reading from the command.
  # Does *NOT* do any shell expansion (that's the point).
  # +args+ should be [program,arg1,...]
  def pipe_command(*args)
    #$stderr.puts args.map {|a| a =~ /\s/ ? "'#{a}'" : a }.join(" ")
    reader, writer = IO.pipe
    if pid = fork
      begin
        writer.close
        yield(reader)
        Process.waitpid
        self.success = $?.success?
      rescue => e
        Process.waitpid(pid,Process::WNOHANG) rescue nil
        self.success = false
        raise(e)
      end
    else
      begin
        reader.close
        $stdin.reopen("/dev/null")
        $stdout.reopen(writer)
        $stderr.reopen(writer)
        exec(*args)
      rescue => e
        # prevent child from jumping out of this scope and continuing main program
        $stderr.puts(e.to_s)
      end 
      exit! # will only reach here if exec() failed
    end 
  end 
  
  
end














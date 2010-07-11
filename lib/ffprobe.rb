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
require 'ffprobe/safe_pipe'
require 'ffprobe/stream_info'
require 'ffprobe/tags_info'

class FFProbe

  
  class InvalidArgument < StandardError; end
  
  class << self
    SUPPORTED_FEATURES = %w(
      unit prefix byte_binary_prefix sexagesimal pretty show_format show_streams
      read_packets read_frames show_files show_frames show_packets show_tags
    )
    
    @@implemented_features = []
    def implemented_features
      executable  # make sure features are loaded
      @@implemented_features
    end
    
    def executable=(path)
      if path != @executable
        @executable = path
        new_features = []
        # parse usage info to determine feature set
        SafePipe.new(@executable,"-h").run do |usage|
          usage.each_line do |line|
            next unless line =~ /^-(\w+)/
            if SUPPORTED_FEATURES.include?($1)
              new_features << $1.to_sym
            end
          end
        end
        @@implemented_features.replace(new_features)
      end
      @executable
    rescue Errno::ENOENT
      @executable = path
    end
    
    def executable
      @executable || (self.executable = default_executable)
    end
    
    def default_executable
      ENV["FFPROBE"] || "ffprobe"
    end
  end
  
  def implemented_features
    self.class.implemented_features
  end
  
  # handle features based on whether the ffprobe executable recognizes them
  def method_missing(sym,*args)
    if implemented_features.include?(sym)
      return instance_variable_get("@#{sym}")
    elsif (str = sym.to_s)[-1] == ?=
      if implemented_features.include?((feat = str[0,str.length-1]).to_sym)
        return instance_variable_set("@#{feat}", args.first)
      end
    end
    super
  end
    
  attr_accessor :features
  def features=(desired_features)
    @features = desired_features.each {|feature|
      raise(InvalidArgument, "Unrecognized feature #{feature}") unless implemented_features.include?(feature)
    }
  end

  attr_accessor :units
  alias :units? :units
  def units=(bool)
    require 'ffprobe/unit' if bool
    @units = bool
  end
  
  def initialize(*desired_features)
    desired_features = [] if desired_features.empty?
    self.features = desired_features.reject {|f| f == :units }
    self.units = desired_features.include?(:units)
  end
  
  def probe(filename)
    params = features.map {|f| "-#{f.to_s}" }
    params << filename
    result = nil
    pipe = SafePipe.new(executable,*params)
    pipe.run do |stream|
      result = Result.from_stream(stream, self.units?)
    end
    result.success = pipe.success?
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
  
end














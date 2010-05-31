
$VERBOSE = false
require 'test/unit'
require 'rubygems'
require 'shoulda'

begin
  here = File.dirname(__FILE__)
  %w(lib bin test).each do |dir|
    path = "#{here}/../#{dir}"
    $LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)
  end
end

require 'ffprobe'

def open_testcase(name)
  here = File.dirname(__FILE__)
  File.open("#{here}/testcases/#{name}.testcase")
end

def should_respond_to(*methods)
  methods.each do |method|
    should "respond to ##{method}" do
      assert_respond_to @instance, method.to_sym
    end
  end
end
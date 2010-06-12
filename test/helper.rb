
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
  File.open(testcase_path("#{name}.testcase"))
end

def testcase_path(name)
  File.join(File.dirname(__FILE__), 'testcases', name)
end

def should_respond_to(instance_var, *methods)
  methods.each do |method|
    should "respond to ##{method}" do
      assert_respond_to instance_variable_get(instance_var), method.to_sym
    end
  end
end

def should_have_numeric_value(instance_var, *keys)
  keys.flatten.each do |key|
    should "have a numeric #{key} in #{instance_var}" do
      assert_match /\d/, instance_variable_get(instance_var)[key.to_sym]
    end
  end
end

def should_have_string_value(instance_var, *keys)
  keys.flatten.each do |key|
    should "have a string #{key} in #{instance_var}" do
      assert_kind_of String, instance_variable_get(instance_var)[key.to_sym]
    end
  end
end
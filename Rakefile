require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rcov/rcovtask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "ruby-ffprobe"
    gemspec.summary = "Ruby wrapper for FFprobe multimedia analyzer"
    gemspec.description = File.read(File.join(File.dirname(__FILE__),"README.rdoc"))
    gemspec.email = "philgarr@gmail.com"
    gemspec.homepage = "http://github.com/kingpong/ruby-ffprobe"
    gemspec.authors = ["Philip Garrett"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

namespace "ffprobe" do
  task "exec" do
    next if ENV["FFPROBE"]
    ENV['PATH'].split(":").each do |dir|
      fqpath = File.join(dir,"ffprobe")
      if File.executable?(fqpath)
        ENV['FFPROBE'] = fqpath
        break
      end
    end
    next if ENV["FFPROBE"]
    raise "Could not find ffprobe in your path. You may set the environment variable FFPROBE to point to your ffprobe executable"
  end
end

task "set_testopts_verbose" do
  ENV["TESTOPTS"] = '-v'
end

Rake::TestTask.new do |t|
   t.libs << "test"
   t.test_files = FileList['test/**/test*.rb']
   t.verbose = true
 end

desc "Run tests with verbosity enabled"
task "vtest" => [:set_testopts_verbose, :test]

namespace "test" do
  desc "Generate ffprobe output test cases"
  task "cases" => ["ffprobe:exec","test/testcases/source.ogv"] do |t|
    require "lib/ffprobe/safe_pipe"
    dest_dir = File.expand_path("test/testcases")
    source = File.expand_path(t.prerequisites.last)
    variations = { "no_args" => [] }
    %w{format streams}.each do |opt|
      variations[opt]             = ["-show_#{opt}"]
      variations["pretty_#{opt}"] = ["-show_#{opt}", "-pretty"]
    end
    variations["format_streams"] = ["-show_format", "-show_streams"]
    variations["pretty_format_streams"] = ["-show_format", "-show_streams", "-pretty"]
    variations.each_pair do |name,args|
      FFProbe::SafePipe.new(ENV["FFPROBE"], *(args + [source])).run do |pipe|
        File.open(File.join(dest_dir,"#{name}.testcase"),"w") do |output|
          output.write pipe.read
        end
      end
    end
  end
  
  desc "Cleanup test output and testcases"
  task "clean" do
    Dir["test/testcases/*.testcase"].each { |file| File.unlink(file) }
  end
end

Rcov::RcovTask.new("coverage") do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/test_*.rb"]
  t.output_dir = "coverage"
  t.verbose = true
  t.rcov_opts << '--exclude /gems/'
end

task "rcov" => "coverage"



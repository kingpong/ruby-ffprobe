require 'rubygems'
require 'rake'
require 'echoe'
require 'test/capture'

project = "ffprobe"
version = "0.0.1"

Echoe.new(project, version) do |p|
  p.description = "Ruby wrapper for ffprobe"
  p.summary = "#{project} #{version}"
  p.url = "http://github.com/kingpong/ffprobe"
  p.author = "Philip Garrett"
  p.email = "philip@pastemagazine.com"
  p.ignore_pattern = ["tmp/*", "script/*", "InstalledFiles"]
  p.development_dependencies = []
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

namespace "test" do
  desc "Generate ffprobe output test cases"
  task "cases" => ["ffprobe:exec","test/testcases/source.ogv"] do |t|
    dest_dir = File.expand_path("test/testcases")
    source = File.expand_path(t.prerequisites.last)
    variations = { "no_args" => [] }
    %w{files frames packets streams tags}.each do |opt|
      variations[opt]             = ["-show_#{opt}"]
      variations["pretty_#{opt}"] = ["-show_#{opt}", "-pretty"]
    end
    variations["files_streams_tags"] = ["-show_files", "-show_streams", "-show_tags"]
    variations["pretty_files_streams_tags"] = ["-show_files", "-show_streams", "-show_tags", "-pretty"]
    variations.each_pair do |name,args|
      IO.capture(ENV["FFPROBE"], args, source, :stderr => true) do |pipe|
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













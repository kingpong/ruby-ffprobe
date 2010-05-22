# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ffprobe}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Philip Garrett"]
  s.date = %q{2010-05-22}
  s.description = %q{Ruby wrapper for ffprobe}
  s.email = %q{philip@pastemagazine.com}
  s.extensions = ["ext/extconf.rb"]
#  s.extra_rdoc_files = ["README.rdoc", "lib/ffprobe.rb"]
#  s.files = ["Manifest", "README.rdoc", "Rakefile", "lib/ffprobe.rb", "ffprobe.gemspec", "test/helper.rb", "test/test_all.rb", "test/test_basics.rb"]
#  s.homepage = %q{http://github.com/kingpong/ffprobe}
#  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "ffprobe", "--main", "README.rdoc"]
#  s.require_paths = ["lib", "ext"]
  s.rubyforge_project = %q{ffprobe}
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{ffprobe 0.0.1}
  s.test_files = ["test/test_all.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "snappy"
  s.version = "0.0.10"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["miyucy"]
  s.date = "2013-12-11"
  s.description = "libsnappy binding for Ruby"
  s.email = ["fistfvck@gmail.com"]
  s.extensions = ["ext/extconf.rb"]
  s.files = ["ext/extconf.rb"]
  s.homepage = "http://github.com/miyucy/snappy"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "libsnappy binding for Ruby"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
  end
end

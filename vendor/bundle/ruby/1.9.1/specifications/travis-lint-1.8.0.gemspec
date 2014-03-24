# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "travis-lint"
  s.version = "1.8.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael S. Klishin", "Travis CI Development Team"]
  s.date = "2014-03-13"
  s.description = "travis-lint is a tool that check your .travis.yml for possible issues, deprecations and so on. Recommended for all travis-ci.org users."
  s.email = ["michaelklishin@me.com", "michael@novemberain.com"]
  s.executables = ["travis-lint"]
  s.files = ["bin/travis-lint"]
  s.homepage = "http://github.com/travis-ci"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Checks your .travis.yml for possible issues, deprecations and so on"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hashr>, ["~> 0.0.22"])
      s.add_runtime_dependency(%q<safe_yaml>, ["~> 0.9.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8"])
    else
      s.add_dependency(%q<hashr>, ["~> 0.0.22"])
      s.add_dependency(%q<safe_yaml>, ["~> 0.9.0"])
      s.add_dependency(%q<rspec>, ["~> 2.8"])
    end
  else
    s.add_dependency(%q<hashr>, ["~> 0.0.22"])
    s.add_dependency(%q<safe_yaml>, ["~> 0.9.0"])
    s.add_dependency(%q<rspec>, ["~> 2.8"])
  end
end

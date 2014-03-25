# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "capistrano-rbenv"
  s.version = "2.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kir Shatrov", "Yamashita Yuu"]
  s.date = "2014-01-09"
  s.description = "rbenv integration for Capistrano"
  s.email = ["shatrov@me.com", "yamashita@geishatokyo.com"]
  s.homepage = "https://github.com/capistrano/rbenv"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "rbenv integration for Capistrano"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capistrano>, ["~> 3.0"])
      s.add_runtime_dependency(%q<sshkit>, ["~> 1.3"])
    else
      s.add_dependency(%q<capistrano>, ["~> 3.0"])
      s.add_dependency(%q<sshkit>, ["~> 1.3"])
    end
  else
    s.add_dependency(%q<capistrano>, ["~> 3.0"])
    s.add_dependency(%q<sshkit>, ["~> 1.3"])
  end
end

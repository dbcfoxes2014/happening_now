# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rails_autolink"
  s.version = "1.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aaron Patterson", "Juanjo Bazan", "Akira Matsuda"]
  s.date = "2013-10-23"
  s.description = "This is an extraction of the `auto_link` method from rails. The `auto_link` method was removed from Rails in version Rails 3.1. This gem is meant to bridge the gap for people migrating."
  s.email = "aaron@tenderlovemaking.com"
  s.homepage = "https://github.com/tenderlove/rails_autolink"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubygems_version = "1.8.23"
  s.summary = "Automatic generation of html links in texts"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["> 3.1"])
    else
      s.add_dependency(%q<rails>, ["> 3.1"])
    end
  else
    s.add_dependency(%q<rails>, ["> 3.1"])
  end
end

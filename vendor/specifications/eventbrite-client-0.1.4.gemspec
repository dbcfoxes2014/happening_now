# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "eventbrite-client"
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Jarvinen"]
  s.date = "2011-08-28"
  s.description = "A tiny EventBrite API client. (http://developer.eventbrite.com)"
  s.email = "ryan.jarvinen@gmail.com"
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.files = ["LICENSE", "README.md"]
  s.homepage = "http://github.com/ryanjarvinen/eventbrite-client.rb"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "A tiny EventBrite API client"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 1.3.0"])
      s.add_runtime_dependency(%q<httparty>, ["~> 0.8.0"])
      s.add_runtime_dependency(%q<tzinfo>, ["~> 0.3.22"])
    else
      s.add_dependency(%q<rspec>, ["~> 1.3.0"])
      s.add_dependency(%q<httparty>, ["~> 0.8.0"])
      s.add_dependency(%q<tzinfo>, ["~> 0.3.22"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 1.3.0"])
    s.add_dependency(%q<httparty>, ["~> 0.8.0"])
    s.add_dependency(%q<tzinfo>, ["~> 0.3.22"])
  end
end

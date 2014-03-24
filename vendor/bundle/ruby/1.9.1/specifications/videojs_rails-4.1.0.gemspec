# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "videojs_rails"
  s.version = "4.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sean Behan"]
  s.date = "2013-08-06"
  s.description = "HTML5 VideoJS plugin"
  s.email = ["bseanvt@gmail.com"]
  s.homepage = ""
  s.require_paths = ["lib"]
  s.rubyforge_project = "videojs_rails"
  s.rubygems_version = "1.8.23"
  s.summary = "VideoJS plugin for Rails 3.1 Asset Pipeline"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

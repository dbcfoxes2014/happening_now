# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rails_serve_static_assets"
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pedro Belo", "Jonathan Dance"]
  s.date = "2013-12-25"
  s.description = "Force Rails to serve static assets"
  s.email = ["pedro@heroku.com", "jd@heroku.com"]
  s.homepage = "https://github.com/heroku/rails_serve_static_assets"
  s.licenses = ["LICENSE"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Sets serve_static_assets to true so Rails will sere your static assets"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

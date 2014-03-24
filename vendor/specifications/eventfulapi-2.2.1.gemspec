# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "eventfulapi"
  s.version = "2.2.1"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = ["Paul Knight, originally with Joe Auricchio"]
  s.autorequire = "eventful/api"
  s.cert_chain = nil
  s.date = "2007-10-01"
  s.email = "pknight@eventful.com"
  s.extra_rdoc_files = ["README"]
  s.files = ["README"]
  s.homepage = "http://api.eventful.com"
  s.rdoc_options = ["-inline-code"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubygems_version = "1.8.23"
  s.summary = "Interface to the Eventful API. http://eventful.com"

  if s.respond_to? :specification_version then
    s.specification_version = 1

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mime-types>, ["> 0.0.0"])
    else
      s.add_dependency(%q<mime-types>, ["> 0.0.0"])
    end
  else
    s.add_dependency(%q<mime-types>, ["> 0.0.0"])
  end
end

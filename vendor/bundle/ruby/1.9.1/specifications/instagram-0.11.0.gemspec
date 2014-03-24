# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "instagram"
  s.version = "0.11.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Shayne Sweeney"]
  s.date = "2014-03-13"
  s.description = "A Ruby wrapper for the Instagram REST and Search APIs"
  s.email = ["shayne@instagr.am"]
  s.homepage = "https://github.com/Instagram/instagram-ruby-gem"
  s.post_install_message = "********************************************************************************\n\n  Follow @instagramapi on Twitter for announcements, updates, and news.\n  https://twitter.com/instagramapi\n\n  Join the mailing list!\n  https://groups.google.com/group/instagram-ruby-gem\n\n********************************************************************************\n"
  s.require_paths = ["lib"]
  s.rubyforge_project = "instagram"
  s.rubygems_version = "1.8.23"
  s.summary = "Ruby wrapper for the Instagram API"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.4"])
      s.add_development_dependency(%q<webmock>, ["~> 1.6"])
      s.add_development_dependency(%q<bluecloth>, ["~> 2.0.11"])
      s.add_runtime_dependency(%q<faraday>, ["< 0.9", ">= 0.7"])
      s.add_runtime_dependency(%q<faraday_middleware>, ["~> 0.8"])
      s.add_runtime_dependency(%q<multi_json>, [">= 1.0.3", "~> 1.0"])
      s.add_runtime_dependency(%q<hashie>, [">= 0.4.0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.4"])
      s.add_dependency(%q<webmock>, ["~> 1.6"])
      s.add_dependency(%q<bluecloth>, ["~> 2.0.11"])
      s.add_dependency(%q<faraday>, ["< 0.9", ">= 0.7"])
      s.add_dependency(%q<faraday_middleware>, ["~> 0.8"])
      s.add_dependency(%q<multi_json>, [">= 1.0.3", "~> 1.0"])
      s.add_dependency(%q<hashie>, [">= 0.4.0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.4"])
    s.add_dependency(%q<webmock>, ["~> 1.6"])
    s.add_dependency(%q<bluecloth>, ["~> 2.0.11"])
    s.add_dependency(%q<faraday>, ["< 0.9", ">= 0.7"])
    s.add_dependency(%q<faraday_middleware>, ["~> 0.8"])
    s.add_dependency(%q<multi_json>, [">= 1.0.3", "~> 1.0"])
    s.add_dependency(%q<hashie>, [">= 0.4.0"])
  end
end

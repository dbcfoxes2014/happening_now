# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "capistrano"
  s.version = "3.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tom Clements", "Lee Hambley"]
  s.date = "2013-11-02"
  s.description = "Capistrano is a utility and framework for executing commands in parallel on multiple remote machines, via SSH."
  s.email = ["seenmyfate@gmail.com", "lee.hambley@gmail.com"]
  s.executables = ["cap", "capify"]
  s.files = ["bin/cap", "bin/capify"]
  s.homepage = "http://capistranorb.com/"
  s.licenses = ["MIT"]
  s.post_install_message = "If you're updating Capistrano from 2.x.x, we recommend you to read the upgrade guide: http://www.capistranorb.com/documentation/upgrading/"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Capistrano - Welcome to easy deployment with Ruby over SSH"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sshkit>, [">= 0.0.23"])
      s.add_runtime_dependency(%q<rake>, [">= 10.0.0"])
      s.add_runtime_dependency(%q<i18n>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<vagrant>, ["~> 1.0.7"])
      s.add_development_dependency(%q<kuroko>, [">= 0"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
    else
      s.add_dependency(%q<sshkit>, [">= 0.0.23"])
      s.add_dependency(%q<rake>, [">= 10.0.0"])
      s.add_dependency(%q<i18n>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<vagrant>, ["~> 1.0.7"])
      s.add_dependency(%q<kuroko>, [">= 0"])
      s.add_dependency(%q<cucumber>, [">= 0"])
    end
  else
    s.add_dependency(%q<sshkit>, [">= 0.0.23"])
    s.add_dependency(%q<rake>, [">= 10.0.0"])
    s.add_dependency(%q<i18n>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<vagrant>, ["~> 1.0.7"])
    s.add_dependency(%q<kuroko>, [">= 0"])
    s.add_dependency(%q<cucumber>, [">= 0"])
  end
end

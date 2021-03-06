# -*- encoding: utf-8 -*-
# stub: geckodriver-helper 0.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "geckodriver-helper".freeze
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Devico Solutions".freeze]
  s.date = "2016-11-10"
  s.description = "Easy installation and use of geckodriver, that provides the HTTP API\ndescribed by the WebDriver protocol to communicate with Gecko browsers, such as Firefox.".freeze
  s.email = ["info@devico.io".freeze]
  s.executables = ["geckodriver".freeze, "geckodriver-update".freeze]
  s.files = ["bin/geckodriver".freeze, "bin/geckodriver-update".freeze]
  s.homepage = "https://github.com/DevicoSolutions/geckodriver-helper".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Easy installation and use of geckodriver.".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_runtime_dependency(%q<archive-zip>.freeze, ["~> 0.7.0"])
    else
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<archive-zip>.freeze, ["~> 0.7.0"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<archive-zip>.freeze, ["~> 0.7.0"])
  end
end

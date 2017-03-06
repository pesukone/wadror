# -*- encoding: utf-8 -*-
# stub: capybara-json 0.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "capybara-json".freeze
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["okitan".freeze, "sonots".freeze]
  s.date = "2015-03-13"
  s.description = "for testing json-api".freeze
  s.email = ["okitakunio@gmail.com".freeze, "sonots@gmail.com".freeze]
  s.homepage = "http://github.com/okitan/capybara-json".freeze
  s.rubyforge_project = "capybara-json".freeze
  s.rubygems_version = "2.6.8".freeze
  s.summary = "for testing json-api".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capybara>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<httpclient>.freeze, ["~> 2.2"])
      s.add_runtime_dependency(%q<multi_json>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.11"])
      s.add_development_dependency(%q<sinatra>.freeze, [">= 0"])
      s.add_development_dependency(%q<thin>.freeze, [">= 0"])
      s.add_development_dependency(%q<yajl-ruby>.freeze, [">= 0"])
      s.add_development_dependency(%q<autowatchr>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry-nav>.freeze, [">= 0"])
      s.add_development_dependency(%q<tapp>.freeze, [">= 0"])
    else
      s.add_dependency(%q<capybara>.freeze, [">= 0"])
      s.add_dependency(%q<httpclient>.freeze, ["~> 2.2"])
      s.add_dependency(%q<multi_json>.freeze, ["~> 1.3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.11"])
      s.add_dependency(%q<sinatra>.freeze, [">= 0"])
      s.add_dependency(%q<thin>.freeze, [">= 0"])
      s.add_dependency(%q<yajl-ruby>.freeze, [">= 0"])
      s.add_dependency(%q<autowatchr>.freeze, [">= 0"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<pry-nav>.freeze, [">= 0"])
      s.add_dependency(%q<tapp>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<capybara>.freeze, [">= 0"])
    s.add_dependency(%q<httpclient>.freeze, ["~> 2.2"])
    s.add_dependency(%q<multi_json>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.11"])
    s.add_dependency(%q<sinatra>.freeze, [">= 0"])
    s.add_dependency(%q<thin>.freeze, [">= 0"])
    s.add_dependency(%q<yajl-ruby>.freeze, [">= 0"])
    s.add_dependency(%q<autowatchr>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<pry-nav>.freeze, [">= 0"])
    s.add_dependency(%q<tapp>.freeze, [">= 0"])
  end
end

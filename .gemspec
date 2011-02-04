# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = "proper"
  s.version     = "0.1.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["James Brennan"]
  s.email       = ["james@carbonfive.com"]
  s.homepage    = "https://github.com/jamesBrennan/proper"
  s.summary     = "A simple CSS compactor"
  s.description = "Proper parses CSS source files and re compiles them so that any given property - value pair appears only once."

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "proper"

  s.add_development_dependency "rspec"
  s.add_development_dependency "mocha"
  s.add_development_dependency "sass", ">= 3.1.0.alpha"

  s.files        = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md ROADMAP.md CHANGELOG.md)
  s.executables  = ['bundle']
  s.require_path = 'lib'
end
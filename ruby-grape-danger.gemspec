# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'ruby-grape-danger/version'

Gem::Specification.new do |s|
  s.name        = 'ruby-grape-danger'
  s.version     = RubyGrapeDanger::VERSION
  s.authors     = ['dblock']
  s.email       = ['dblock@dblock.org']
  s.homepage    = 'https://github.com/ruby-grape/danger'
  s.summary     = 'Danger.systems conventions for ruby-grape projects.'
  s.description = 'Packages a Dangerfile to be used with Danger for projects within the Ruby Grape community.'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_runtime_dependency 'danger', '~> 4.0.1'
  s.add_runtime_dependency 'danger-changelog', '~> 0.2.0'
end

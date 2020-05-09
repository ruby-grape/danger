# frozen_string_literal: true

require 'rubygems'
require 'bundler'

Bundler.setup :default

Bundler::GemHelper.install_tasks

require 'rubocop/rake_task'
RuboCop::RakeTask.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task default: %i[rubocop spec]

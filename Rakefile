require 'rubygems'
require 'bundler/setup'
require 'rspec/core/rake_task'
require 'ci/reporter/rake/rspec'

RSpec::Core::RakeTask.new(:spec => ["ci:setup:rspec"]) do |t|
	  t.pattern = '**/*_spec.rb'
end

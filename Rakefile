#require 'rake/testtask
require 'rspec/core/rake_task'
require 'ci/reporter/rake/rspec'

#RSpec::Core::RakeTask.new(:spec)

RSpec::Core::RakeTask.new(:all => ["ci:setup:rspec"]) do |t|
#	  t.rspec_opts = ["-e TC001"]
	  t.pattern = '**/*_spec.rb'
end

#task :default => :spec

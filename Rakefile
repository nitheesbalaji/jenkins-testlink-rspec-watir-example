require 'rubygems'
require 'bundler/setup'

require 'rspec/core/rake_task'
require 'date'
require 'yaml'
require 'testlink_rspec_utils'
require 'rspec_testlink_formatters'

$config = YAML.load_file('config.yml')

task default: %w[spec]

desc 'Run all specs with doc output'
RSpec::Core::RakeTask.new(:spec) do |t|
	t.rspec_opts = "--format documentation"
	t.pattern = '**/*_spec.rb'
end

namespace :testlink do
	desc 'spec outline from TestLink requirements file'
	task :req2spec,[:requirements_file] do |t, args|

		STDOUT.puts "Enter Project Code e.g.: linge-0666 intranet"
		project = STDIN.gets.strip

		fileout  = $config['application']+project+"_spec.rb"
		fileout =  fileout.gsub(/[^\w\.\-]/,"_")

		convert = TestlinkRspecUtils::Convert.new
		convert.requirements_to_cases($config['application'],project, args[:requirements_file], 'spec/'+fileout)
	end

	desc 'Run all specs with doc output'
	RSpec::Core::RakeTask.new(:cases_import) do |t|
		t.rspec_opts = "--format RspecTestlinkExportCases -r rspec_testlink_formatters --out tc-testlink.xml"
		t.pattern = '**/*_spec.rb'

		print "\nwrote output to tc-testlink.xml\n\n"
	end

	desc 'Run spec(s) with junit output'
	RSpec::Core::RakeTask.new(:spec) do |t|

		d = DateTime.now
		newTarget = d.strftime("%Y%m%dT%H%M%S")
		p newTarget
		p d

		t.rspec_opts = "--format RspecTestlinkJunitformatter -r rspec_testlink_formatters --out spec/reports/SPEC#{newTarget}-out.xml"
		t.pattern = '**/*_spec.rb'
	end
end

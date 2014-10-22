require 'rubygems'
require 'bundler/setup'
require 'rspec/core/rake_task'
require 'ci/reporter/rake/rspec'
require 'date'

RSpec::Core::RakeTask.new(:spec => ["ci:setup:rspec"]) do |t|
	  t.pattern = '**/*_spec.rb'

end

task :move_report do
	system('mv spec/reports/* final_reports/')
	searchPattern = 'SPEC-'
	target = 'SPEC'
	d = DateTime.new()
	newTarget = d.strftime("SPEC%Y%m%dT%H%M")
	Dir.glob("./final_reports/*").sort.each do |entry|
		origin = File.basename(entry)
		if origin.include?(searchPattern)
			newEntry = origin.gsub(target, newTarget)
			File.rename( 'final_reports/'+origin,  'final_reports/'+newEntry )
			puts "Rename from " + origin + " to " + newEntry
		end
	end
end


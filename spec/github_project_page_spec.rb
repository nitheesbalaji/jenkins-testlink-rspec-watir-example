require 'rspec'
require 'watir'
require 'rbconfig'
require 'yaml'

@os ||= (
	host_os = RbConfig::CONFIG['host_os']
	case host_os
	when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
		:windows
	when /darwin|mac os/
		:macosx
	when /linux/
		require 'headless'
		$headless = Headless.new
		$headless.start
	when /solaris|bsd/
		:unix
	else
		raise Error::WebDriverError, "unknown os: #{host_os.inspect}"
	end
)

if browsertype = ENV["browser"]
	case browsertype
	when /ie/
		$browser = Watir::Browser.new
	when /safari/
		require "watir-webdriver"  # For web automation.
		$browser = Watir::Browser.new
	when /firefox/

		require "watir-webdriver"  # For web automation.
		$browser = Watir::Browser.new

	when /chrome/
		require "watir-webdriver"  # For web automation.
		$browser = Watir::Browser.new :chrome

	else
		raise Error::WebDriverError, "unknown browser: #{browsertype.inspect}"
	end
else
	$browser = Watir::Browser.new
end

RSpec.configure do |config|
	
	config.after(:suite) { 

		$browser.close unless $browser.nil? 
		$headless.destroy unless $headless.nil?
	}

	config.before(:each) {
		@browser = $browser
	}
	config.fail_fast = true
end

$baseurl = 'http://mipmip.github.io/jenkins-testlink-rspec-watir-example'
$waitfortext = 'xxx'

describe "00001-LINGE-github-project-page" do
	context "opening frontpage" do

		it "should not show 404 text TC001" do
			@browser.goto($baseurl)  
			#wait_until_loaded $waitfortext
			expect(@browser.text).not_to include('404')
		end

		it "should show a text TC002" do
			#@browser.goto($baseurl)  
			expect(@browser.text).to include('Jenkins-testlink-rspec-watir-example')
		end

	end
end

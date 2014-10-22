# jenkins-testlink-rspec-watir-example

This is example demonstrates to use of Jenkins together with TestLink in order to organize rspec tests with watir. In our example we will test http://mipmip.github.io/jenkins-testlink-rspec-watir-example using rspec and watir

## Requirements

*	Basic knowledge about TestLink and Jenkins. There are a lot of HowTo's out there. This one concentrates on glewing together Jenkins TestLink RSpec and Watir in particular.
*	A working TestLink Environment, I used version 1.9.8 (1.9.4 is not working for sure)
* 	A working Jenkins Environment, I used version 1.581
* 	Jenkins: Git Plugin (quite standard)
* 	Jenkins: TestLink Plugin, I used version (3.10)
*	A working ruby and bundler stack on your machine
*	A working ruby and bundler stack on your Jenkins host that will execute the job (could be a slave of course)

Because a specific TestLink version is not always correctly working with a specific TestLink Plugin version I listed my used versions.

## Step by step tutorial

### Try the examples on your own machine

1.	clone the repo

	```
	git clone https://github.com/mipmip/jenkins-testlink-rspec-watir-example.git
	```

1.	install all gems (it's configures to install them inside the repo directory)

	```
	bundle install
	```

1.	run all tests on your machine

	```
	rake spec
	```

1.	run one test on your machine (mimic jenkins)

	```
	rake spec  SPEC_OPTS="-e TC0001"
	```

### Prepare TestLink

If you have not done so open your My Settings page inside and TestLink and Generate an API key. You will need this key in the Jenkins TestLink Plugin configuration.

![image](http://picdrop.t3lab.com/FopDQdCljn.png)

### Main Configuration of the Jenkins TestLink plugin

If you have installed the TestLink Plugin Jenkins and restarted your Jenkins Service you will have a TestLink section in the System Configuration: (Manage Jenkins->Configure System)

Use the Api Key form Testlink. Make sure the URL is correct. You can just open it in your browser. TestLink should complain about only accepting POST's

![image](http://picdrop.t3lab.com/PgYpGLmCYU.png)


### Prepare TestLink for this example 

1.	Enable all API and XMLRPC variables in config.inc.php
1.	Inside TestLink create a test project called: ```jenkins-testlink-rspec-watir-example```

	![image](http://picdrop.t3lab.com/FA4Kv6o2ra.png)

1.	Create a Custom Field named and labeled: ```RSPEC CASE ID``` and assign it to the project.
1.	Create a new test suite. Call it what want
1.  Create a test inside the suite and name it ```TC0001``` and add exact string to the ```jenkins-testlink-rspec-watir-example-web-page should not show 404 text (TC0001)```
1. 	Repeat this for ```TC0002``` with ```jenkins-testlink-rspec-watir-example-web-page should show a text (TC0002)```
1.	Create a new test plan named: ```jenkins-test-plan```
1.	Assign both tests to this test plan. For now you're finished with TestLink.

### Create a job in Jenkins that will trigger TestLink

1.	Create a new Freestyle project named: jenkins-testlink-rspec-watir-example
1.	Enter the github repo link in the Source Code Management section

	![image](http://picdrop.t3lab.com/5kX5SGZVLB.png)

1. 	Add build step ```execute shell``` and enter ```bundle install```

![image](http://picdrop.t3lab.com/4uXMVWnSzP.png)

1. 	Add build step ```Invoke TestLink``` and fill in the TestLink Configuration. You should choose your existing TestLink Version which you configured in System Configuration. Enter ```jenkins-testlink-rspec-watir-example``` in Test Project Name, ```jenkins-test-plan``` in Test Plan Name, ```jenkins-examples-$BUILD_NUMBER``` and ```RSPEC CASE ID``` in Custom Fields.

	![image](http://picdrop.t3lab.com/8qjpZVV4JV.png)

1.	In the Iterative Test Build Steps section add action ```Execute Shell`` and enter the command ```rake spec SPEC_OPTS="-e $TESTLINK_TESTCASE_NAME"```

	![image](http://picdrop.t3lab.com/WGu35Z5fWn.png)

1.	In the Result Seeking Strategy section add ```JUnit Case Name``` with ```spec/reports/*.xml``` as include pattern and ```RSPEC CASE ID``` as Custom Key Field.

	![image](http://picdrop.t3lab.com/bk2cR9kUMQ.png)

1.	Finally save this job

### Run the Jenkins Job

The last step in this tutorial is to see if the everything is glewed correctly.

1. 	Build the example Jenkins job and open the console of this job. It should look like this:




## FAQ

### which names should I use for the RSPEC CASE ID?

After you have run the spec's with ```rake all``` you should have a JUnit report. Here inside are the exact names you should use for the ```RSPEC CASE ID```-field in TestLink

try to run ```grep "testcase name" -r spec | cut -d '"' -f 2``` from the root of the repository. It will list you the exact names. 
	
	➜  jenkins-testlink-rspec-watir-example git:(master) ✗ grep "testcase name" -r spec | cut -d '"' -f 2
	jenkins-testlink-rspec-watir-example-web-page should not show 404 text (TC0001)
	jenkins-testlink-rspec-watir-example-web-page should show a text (TC0002)



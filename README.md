# ruby_selenium
ruby_selenium
This is selenium framework written in ruby, that utilizes selenium-webdriver and rspec.

Some features of the framework include parallel test execution for faster results, continous integration/continous delivery integration, tagging for targeting specific chunks of test code to be executed, integration with selenium grid/saucelabs, allure reports integration, browserscreen shots on failure, and test retries on failure.

Tests in this repo are written against expedia.com

Tests are written using the page object model for increased resiliency and optimal maintainability.

To run tests:

install ruby

install bundler: gem install bundler

install packages: bundle install

run tests: rake local:chrome


Basic implementation details:

Tests are run using grunt task runner

Basepage:  Selenium actions are stored in base page. (makes writing tests more efficient and easier to maintain) 

Page objects:  Describes the actions avaiable on a wep page (another layer of abstraction that makes writing tests more 
efficient and easier to maintain)

Tests:  Where test cases are defined, and assertions are made

Config:  Test configuration options are stored here.  

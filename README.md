# ruby_selenium
ruby_selenium
This  selenium framework is written in ruby and utilizes selenium-webdriver and rspec.

Some features of the framework include parallel test execution(faster results), continous integration/continous delivery integration(xunit reports), tagging(targets specific chunks of test code to be executed), integration with selenium grid/saucelabs, allure reports integration(beutiful and insightful reporting), browserscreen shots on failure, flexible test execution, and test retries on failure.

Tests in this repo are written against expedia.com

**Basic implementation details:**
- Tests are run using rake task runner
- Basepage:  Selenium actions are stored in base page. (a layer of abstraction, makes writing tests efficient and maintainable) 
- Page objects:  Describes actions avaiable on a wep page (another layer of abstraction, helps with efficency and maintainability)
- Tests:  Where test cases are written, and assertions are made
- Config:  Test configuration options are stored here.  

**To run tests:**
- install ruby
- install bundler: gem install bundler
- install packages: bundle install
- run tests: rake local:chrome


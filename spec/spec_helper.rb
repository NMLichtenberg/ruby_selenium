require 'rspec'
require 'parallel_tests'
require 'rspec/retry'
require 'allure-rspec'
require "selenium-webdriver"


if ENV['production'] == 'on'
  RSpec.configure do |c|
    c.include AllureRSpec::Adaptor
  end

  AllureRSpec.configure do |c|
    c.output_dir = "allure"
    c.clean_dir = true
  end
end

ParallelTests.first_process? ? FileUtils.rm_rf(AllureRSpec::Config.output_dir) : sleep(1)

RSpec.configure do |config|
  config.verbose_retry = true # show retry status in spec process
  config.default_retry_count = ENV['CC_RETRIES'].to_i
  config.default_sleep_interval = 2

  config.before do
    case ENV['CC_HOST']
    when 'saucelabs'
      caps = Selenium::WebDriver::Remote::Capabilities.send ENV['CC_BROWSER']
      caps.version  = ENV['CC_BROWSER_VERSION']
      caps.platform = ENV['CC_OPERATING_SYSTEM']
      caps[:name]   = RSpec.current_example.metadata[:full_description]

      @driver = Selenium::WebDriver.for(
        :remote,
        url: 'example.com',
        desired_capabilities: caps
      )


    when 'grid'
      caps = Selenium::WebDriver::Remote::Capabilities.send ENV['CC_BROWSER']
      @driver = Selenium::WebDriver.for(
        :remote,
        url: "http://#{ENV['CC_GRID_URL']}#{ENV['CC_GRID_PORT']}/wd/hub",
        desired_capabilities: caps
      )

    else
      case ENV['BROWSER']
      when 'firefox'
        Selenium::WebDriver::Firefox.driver_path = File.join(Dir.pwd, get_geckodriver_path)
        profile = Selenium::WebDriver::Firefox::Profile.new
        profile['browser.helperApps.neverAsk.saveToDisk'] = 'image/png, text/csv'
        @driver = Selenium::WebDriver.for :firefox, profile: profile
      when 'chrome'
        Selenium::WebDriver::Chrome.driver_path = File.join(Dir.pwd, get_chromedriver_path)
        @driver = Selenium::WebDriver.for :chrome
      end
    end
  end

  config.after do
    unless RSpec.current_example.exception.nil?
      @driver.save_screenshot(File.join(Dir.pwd, "tmp/#{Time.now}.png"))
    end

    @driver.quit
  end
end

def get_chromedriver_path
  path_part = ''
  if (Dir.pwd).include?('api')
  end
  case get_os
  when :windows
    return path_part + 'chromedriver.exe'
  when :macosx
    return path_part + 'vendor/chromedriver'
  when :linux
    return path_part + 'linuxchromedriver'
  else
    return path_part + 'chromedriver'
  end
end

def get_geckodriver_path
  path_part = ''
  if (Dir.pwd).include?('api')
    path_part = '../'
  end
  case get_os
  when :windows
    return path_part + 'geckodriver.exe'
  when :macosx
    return path_part + 'vendor/geckodriver'
  when :linux
    return path_part + 'linuxgeckodriver'
  else
    return path_part + 'geckodriver'
  end
end

def get_os
  host_os = RbConfig::CONFIG['host_os']
  case host_os
  when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
    :windows
  when /darwin.{1,}|mac os/
    :macosx
  when /linux|linux-gnu/
    :linux
  when /solaris|bsd/
    :unix
  else
    raise Error::WebDriverError, "Unknown os: #{host_os.inspect}"
  end
end

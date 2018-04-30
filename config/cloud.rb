# provides additional configuration for SauceLabs environements, use this file
# to override base settings if needed

require_relative 'base'

ENV['HOST']                 ||= 'saucelabs'
ENV['OPERATING_SYSTEM']     ||= 'Windows 10'
ENV['BROWSER']              ||= 'chrome'
ENV['BROWSER_VERSION']      ||= 'latest'
ENV['CCA_SAUCE_USERNAME']   ||= 'username'
ENV['CCA_SAUCE_ACCESS_KEY'] ||= 'key'

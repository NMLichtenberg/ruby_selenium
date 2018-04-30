# it is assumed the project is relying on common test frameworks located in
# tests folder, with project residing in this hierarchy, if not remove relative
# reference to these files
require_relative '../spec/spec_helper'

# default test browser and environment
ENV['BROWSER']  ||= 'chrome'
ENV['ENV']      ||= 'production'
ENV['RETRIES']  ||='1'

# configure varous environments here
case ENV['ENV']
when 'develop'
  ENV['BASE_URL'] ||= 'URL_GOES_HERE' #TODO: replace with URL
when 'production'
  ENV['BASE_URL'] ||= 'https://www.expedia.com/' #TODO: replace with URL
else
  puts 'unknown environment expected'
end

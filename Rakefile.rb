def launch_in_parallel(config_file)
  system("parallel_rspec #{'-n ' + ENV['processes'] if ENV['processes']} --test-options '-r ./#{config_file} --order random #{'--tag ' + ENV['tag'] if ENV['tag']}' spec")
end

namespace :reports do
  desc 'Generate and open a report'
  task :generate do
    system "allure generate allure"
    system "allure report open"
  end
end

namespace :tags do
  desc 'List tags sorted A-Z'
  task :alpha do
    ENV['TAG_SORT_ORDER'] = 'alphabetical'
    system "ruby tag_lister.rb"
  end

  desc 'List tags sorted by usage'
  task :usage do
    system "ruby tag_lister.rb"
  end
end

namespace :local do
  system "rm -rf tmp/*"
  desc 'Run tests in Firefox'
  task :firefox do
    ENV['BROWSER'] = 'firefox'
    launch_in_parallel 'config/local.rb'
  end

  desc 'Run tests in Chrome'
  task :chrome do
    ENV['BROWSER'] = 'chrome'
    launch_in_parallel 'config/local.rb'
  end
end

namespace :cloud do
  desc "Run tests in IE"
  task :ie, :os, :version do |t, args|
    ENV['BROWSER']          = 'internet_explorer'
    ENV['OPERATING_SYSTEM'] = args[:os]
    ENV['BROWSER_VERSION']  = args[:version]
    launch_in_parallel 'config/cloud.rb'
  end

  desc "Run tests in Firefox"
  task :firefox, :os, :version do |t, args|
    ENV['BROWSER']          = 'firefox'
    ENV['OPERATING_SYSTEM'] = args[:os]
    ENV['BROWSER_VERSION']  = args[:version]
    launch_in_parallel 'config/cloud.rb'
  end

  desc "Run tests in Chrome"
  task :chrome, :os, :version do |t, args|
    ENV['BROWSER']          = 'chrome'
    ENV['OPERATING_SYSTEM'] = args[:os]
    ENV['BROWSER_VERSION']  = args[:version]
    launch_in_parallel('config/cloud.rb')
  end
end

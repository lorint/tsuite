require "tsuite/version"
require "rails/railties"

module Tsuite
  # Your code goes here...
	class InstallTask < Rails::Railtie
	  rake_tasks do
	  	load 'tasks/install.rake'
	  	# puts File.join(File.dirname(__FILE__),'tasks/*.rake').inspect
	   #  Dir[File.join(File.dirname(__FILE__),'tasks/*.rake')].each { |f|
	   #  	puts "Task #{f}"
	   #   load f }
	  end
	end
end

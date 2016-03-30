module Tsuite
	class InstallTask
    include Rake::DSL if defined? Rake::DSL
    def install_tasks
			namespace :tsuite do
			  desc 'Set up rspec and cucumber environments'
			  task :install do
			    sh "rails g rspec:install"
			    sh "rails g cucumber:install"
			  end
			end
    end
	end
end

Tsuite::InstallTask.new.install_tasks
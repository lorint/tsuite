namespace :tsuite do
  desc 'Set up rspec and cucumber environments'
  task :install do
    sh "rails g rspec:install"
    sh "rails g cucumber:install"
  end
end

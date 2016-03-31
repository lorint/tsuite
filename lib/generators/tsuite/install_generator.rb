require 'rails/generators'
module Tsuite
  class InstallGenerator < Rails::Generators::Base
    desc "Add the rspec \"spec\" and cucumber \"features\" folders"

    def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'templates')
    end

    # Can add command line options defined like Thor:
#    class_option :extra, :desc => "Add extra stuff", :type => :boolean, :default => false
    # Reference these options later with options[:my_opt]

    generate "rspec:install"
    generate "cucumber:install"
  end
end

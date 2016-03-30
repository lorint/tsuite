# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tsuite/version'

Gem::Specification.new do |spec|
  spec.name          = "tsuite"
  spec.version       = Tsuite::VERSION
  spec.authors       = ["Lorin Thwaits"]
  spec.email         = ["lorint@gmail.com"]

  spec.summary       = %q{7 Rails testing gems conveniently rolled into one}
  spec.description   = %q{Just run rake tsuite:install and go!}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.add_dependency "rspec-rails"
  spec.add_dependency "cucumber-rails"
  spec.add_dependency "database_cleaner"
  spec.add_dependency "simplecov" #, {require: false}
  spec.add_dependency "launchy"
  spec.add_dependency "rack_session_access"
  spec.add_dependency "poltergeist"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.post_install_message = "Your test suite is installed, and now you can run \"rake tsuite:install\"."
end


# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'morse_nameable/version'

Gem::Specification.new do |spec|
  spec.name          = "morse_nameable"
  spec.version       = MorseNameable::VERSION
  spec.authors       = ["Terry S","Fred McGroarty"]
  spec.email         = ["itsterry@gmail.com", 'freddymcgroarty@gmail.com']

  if spec.respond_to?(:metadata)
    #spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = %q{Module to allow easy name functions in ActiveRecord models}
  spec.homepage      = "https://github.com/morsedigital/morse_nameable"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "morse_fields_validator","~>1.0"

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "coveralls", "~> 0.8"
  spec.add_development_dependency "guard-rspec", "~> 4.5"
  spec.add_development_dependency "rb-fsevent", "~> 0.9"
  spec.add_development_dependency "shoulda-matchers", "~> 2.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
end

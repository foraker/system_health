# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'system_health/version'

Gem::Specification.new do |spec|
  spec.name          = "system_health"
  spec.version       = SystemHealth::VERSION
  spec.authors       = ["Stirling Olson"]
  spec.email         = ["seo@foraker.com"]
  spec.summary       = %q{System health monitor for Rails apps}
  spec.description   = %q{System health monitor for Rails applications}
  spec.homepage      = "https://github.com/foraker/system_health"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", '>= 4.0.0'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end

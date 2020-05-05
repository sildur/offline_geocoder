# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'offline_geocoder/version'

Gem::Specification.new do |spec|
  spec.name          = "offline_geocoder"
  spec.version       = OfflineGeocoder::VERSION
  spec.authors       = ["Roberto Romero"]
  spec.email         = ["roberto.offline_geocoder@nirae.at"]

  spec.summary       = %q{Offline reverse geocoder}
  spec.description   = %q{Offline reverse geocoder. Uses GeoNames database}
  spec.homepage      = "https://github.com/inaka/offline_geocoder"
  spec.license       = "Apache-2.0"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_runtime_dependency "geokdtree", "~> 0.2"
end

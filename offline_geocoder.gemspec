# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'offline_geocoder/version'

Gem::Specification.new do |spec|
  spec.name          = 'offline_geocoder'
  spec.version       = OfflineGeocoder::VERSION
  spec.authors       = ['Roberto Romero']
  spec.date          = Time.now.utc.strftime('%Y-%m-%d')
  spec.email         = ['roberto.offline_geocoder@nirae.at']

  spec.summary       = 'Offline reverse geocoder'
  spec.description   = 'Offline reverse geocoder. Uses GeoNames database'
  spec.homepage      = 'https://github.com/sildur/offline_geocoder'
  spec.license       = 'Apache-2.0'

  spec.files         =
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec/|\.+)}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = ['>= 2.0', '< 3.1']
  spec.metadata = {
    'bug_tracker_uri' => 'https://github.com/sildur/offline_geocoder/issues',
    'homepage_uri' => 'https://github.com/sildur/offline_geocoder',
    'source_code_uri' => 'https://github.com/sildur/offline_geocoder'
  }
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_runtime_dependency 'geokdtree', '~> 0.2'
end

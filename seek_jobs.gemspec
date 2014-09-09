lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'seek_jobs/version'

Gem::Specification.new do |spec|
  spec.name          = 'seek_jobs'
  spec.version       = SeekJobs::VERSION
  spec.authors       = ['NetEngine']
  spec.email         = ['team+seekjobs+gem@netengine.com.au']
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = 'http://github.com/net-engine/seek_jobs'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split('\x0')
  # spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end

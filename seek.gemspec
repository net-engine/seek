lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'seek/version'

Gem::Specification.new do |spec|
  spec.name          = 'seek'
  spec.version       = Seek::VERSION
  spec.authors       = ['NetEngine']
  spec.email         = ['team+seek+gem@netengine.com.au']
  spec.summary       = %q{Integration with Seek (http://seek.com.au)}
  spec.description   = %q{Integration with Seek (http://seek.com.au)}
  spec.homepage      = 'http://github.com/net-engine/seek'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.1.0'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake',    '~> 10.0'

  spec.add_dependency 'httpclient', '~> 2.4'
  spec.add_dependency 'nokogiri'
  spec.add_dependency 'savon', '~> 2.6'
end

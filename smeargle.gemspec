# -*- encoding: utf-8 -*-
require File.expand_path('../lib/smeargle/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David Ratajczak"]
  gem.email         = ["david@mockra.com"]
  gem.description   = %q{Smeargle is a tool for collecting a set of images from a url.}
  gem.summary       = %q{The smeargle library is designed to return an object with 
                         various methods to help you traverse the collection of images 
                         returned by a url.}
  gem.homepage      = "http://mockra.com"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "smeargle"
  gem.require_paths = ["lib"]
  gem.version       = Smeargle::VERSION

  gem.license = 'MIT'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'fakeweb'
  gem.add_dependency 'nokogiri'
  gem.add_dependency 'rmagick'
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wayward/version'

Gem::Specification.new do |spec|
  spec.name          = "wayward"
  spec.version       = Wayward::VERSION
  spec.authors       = ["Christian Mortaro"]
  spec.email         = ["christian.mortaro@gmail.com"]
  spec.summary       = %q{Ruby wrapper for www.wayward.com.br api}
  spec.description   = %q{Meta objects that work with the wayward api following the ruby way}
  spec.homepage      = "https://github.com/waywardcombr/wayward-rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end

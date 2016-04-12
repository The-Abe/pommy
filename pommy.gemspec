# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pommy/version'

Gem::Specification.new do |spec|
  spec.name          = "pommy"
  spec.version       = Pommy::VERSION
  spec.authors       = ["The-Abe"]
  spec.email         = ["abevanderwielen@gmail.com"]

  spec.summary       = %q{A very very basic pomodoro timer.}
  spec.homepage      = "http://github.com/the-abe/pommy"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["pommy"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
end

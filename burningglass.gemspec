# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'burning_glass/version'

Gem::Specification.new do |spec|
  spec.name          = "burningglass"
  spec.version       = BurningGlass::VERSION
  spec.authors       = ["Alejandro Vazquez"]
  spec.email         = ["avazquez@pairin.com"]
  spec.summary       = "Gem for accessing Burning Glass API"
  spec.homepage      = "https://github.com/Pairin/burningglass-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- spec/*`.split("\n")
  spec.require_paths = ["lib"]

  spec.add_dependency "addressable", "~> 2.2.0"
  spec.add_dependency "plural"

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
end

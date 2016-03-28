# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'applyrics/info'

Gem::Specification.new do |s|
  s.name          = 'applyrics'
  s.version       = Applyrics::VERSION
  s.date          = '2016-03-28'
  s.summary       = Applyrics::DESCRIPTION
  s.description   = Applyrics::DESCRIPTION
  s.authors       = ["Frederik Wallner"]
  s.email         = 'frederik.wallner@gmail.com'
  s.files         = Dir["lib/**/*"] + %w(bin/gym README.md LICENSE)
  s.executables   = ["applyrics"]
  s.homepage      = 'https://applyrics.io'
  s.license       = 'MIT'

  s.add_dependency 'commander', '~> 4.4'
  s.add_dependency 'colored', '~> 1.2'
end

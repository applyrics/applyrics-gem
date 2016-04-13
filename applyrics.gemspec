# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'applyrics/info'

Gem::Specification.new do |s|
  s.name          = 'applyrics'
  s.version       = Applyrics::VERSION
  s.summary       = Applyrics::DESCRIPTION
  s.description   = Applyrics::DESCRIPTION
  s.authors       = ["Frederik Wallner"]
  s.email         = 'frederik.wallner@gmail.com'
  s.files         = Dir["lib/**/*"] + %w(bin/applyrics README.md LICENSE)
  s.executables   = ["applyrics"]
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.homepage      = 'https://github.com/applyrics/applyrics-gem'
  s.license       = 'MIT'
  s.metadata      = { "issue_tracker" => "https://github.com/applyrics/applyrics-gem/issues" }
  s.required_ruby_version = '>= 1.9'

  s.post_install_message = "Thank you for using applyrics! Please keep in mind that this software is in early development, things might break."

  s.add_dependency 'commander', '~> 4.4'
  s.add_dependency 'colored', '~> 1.2'
  s.add_dependency 'i18n_data', '~> 0.7.0'
  s.add_dependency 'multi_json', '~> 1.11', '>= 1.11.2'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'rubocop'
end

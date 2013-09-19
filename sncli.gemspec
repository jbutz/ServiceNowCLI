# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
#require 'speeddev/version'

Gem::Specification.new do |spec|
  spec.name          = "sncli"
  spec.version       = "0.0.0"
  spec.authors       = ["Jason Butz"]
  spec.description   = %q{Download business rules and other scripts from ServiceNow}
  spec.summary       = %q{Download script from ServiceNow}
  spec.homepage      = ""
  spec.license       = ""

  spec.files         = `git ls-files`.split($/)
  spec.executables   = ["sncli"] #spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency("nori")
  spec.add_dependency("nokogiri")
  spec.add_dependency("thor")
  spec.add_dependency("highline")

  spec.add_development_dependency("bundler")


end
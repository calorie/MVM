# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mvm/version'

Gem::Specification.new do |spec|
  spec.name          = "mvm"
  spec.version       = MVM::VERSION
  spec.authors       = ["Yuki Konta"]
  spec.email         = ["starfruits0112@gmail.com"]
  spec.description   = %q{MPICH Version Manager}
  spec.summary       = %q{MPICH Version Manager}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  
  spec.add_runtime_dependency "commander"
  spec.add_runtime_dependency "nokogiri"
end

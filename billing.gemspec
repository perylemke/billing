# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'billing/version'

Gem::Specification.new do |spec|
  spec.name          = "billing_pery"
  spec.version       = Billing::VERSION
  spec.authors       = ["Pery Lemke"]
  spec.email         = ["pery.lemke@gmail.com"]

  spec.summary       = "A gem to calculate call minutes."
  spec.homepage      = "https://github.com/perylemke/billing"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = "billing"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

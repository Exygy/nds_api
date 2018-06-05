
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nds_api/version"

Gem::Specification.new do |spec|
  spec.name          = "nds_api"
  spec.version       = NdsApi::VERSION
  spec.authors       = ["Pierre Hunault"]
  spec.email         = ["pierre@exygy.com"]

  spec.summary       = %q{NDS API is a Rubygem for easy interface with the NDS API. https://developer.uatup.naccrraware.net/}
  spec.description   = %q{NDS API is a Rubygem for easy interface with the NDS API. NDS is the National Data System for Child Care. NDS is a variety of applications and services that facilitate the work of Child Care R&Rs. This Ruby code is an interface to the new NDS API. This code is built and maintained by Exygy, in San Francisco. NDS is built by Child Care Aware of America. For any questions about using this code, please contact hello@exygy.com. For more information about NDS please see https://usa.childcareaware.org/members-providers/data-services/}
  spec.homepage      = "http://exygy.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 12.0"
end

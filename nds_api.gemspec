
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nds_api/version"

Gem::Specification.new do |spec|
  spec.name          = "nds_api"
  spec.version       = NdsApi::VERSION
  spec.authors       = ["Pierre Hunault"]
  spec.email         = ["pierre@exygy.com"]

  spec.summary       = %q{Connect to NDS API and retrieve records.}
  spec.description   = %q{Connect to NDS API and retrieve records.}
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

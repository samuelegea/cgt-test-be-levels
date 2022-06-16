lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "cgtrader_levels/version"

Gem::Specification.new do |spec|
  spec.name          = "cgtrader_levels"
  spec.version       = CgtraderLevels::VERSION
  spec.authors       = ["Samuel Egea"]
  spec.email         = ["samuel.buranelo@gmail.com"]
  spec.summary       = "An interesting technical test"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord"
  spec.add_dependency "sqlite3"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "sqlite3"
end

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gcore_api_rb/version"

Gem::Specification.new do |spec|
  spec.name          = "gcore_api_rb"
  spec.version       = GcoreApiRb::VERSION
  spec.authors       = ["novikov.vasiliy"]
  spec.email         = ["novikov.vasiliy.d@gmail.com"]

  spec.summary       = 'Wrapper around G-Core cdn REST API'
  spec.description   = 'Wrapper around G-Core cdn REST API'
  spec.homepage      = 'https://github.com/Lianowar/gcore_api_rb'
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = 'https://github.com/Lianowar/gcore_api_rb'
  spec.metadata["changelog_uri"] = 'https://github.com/Lianowar/gcore_api_rb'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "activesupport", "~> 5.0"
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "typhoeus", "~> 1.3"
end

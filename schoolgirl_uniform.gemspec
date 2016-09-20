# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'schoolgirl_uniform/version'

Gem::Specification.new do |spec|
  spec.name          = "schoolgirl_uniform"
  spec.version       = SchoolgirlUniform::VERSION
  spec.authors       = ["Yaro"]
  spec.email         = ["osyaroslav@gmail.com"]

  spec.summary       = %q{Write a short summary, because Rubygems requires one.}
  spec.description   = %q{Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/vergilet/schoolgirl_uniform"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "http://mygemserver.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'activemodel', '~> 5.0'

  spec.add_dependency "bundler", '~> 1.13'
  spec.add_dependency "rake", '~> 11.2'
  spec.add_dependency "rspec", '~> 3.5'
  spec.add_dependency "virtus", '~> 1.0'
end

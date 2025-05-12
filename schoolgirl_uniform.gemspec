# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'schoolgirl_uniform/version'

Gem::Specification.new do |spec|
  spec.name          = "schoolgirl_uniform"
  spec.version       = SchoolgirlUniform::VERSION
  spec.authors       = ["YaroslavO"]
  spec.email         = ["osyaroslav@gmail.com"]

  spec.summary       = %q{Multistep form for Rails apps.}
  spec.description   = %q{Multistep form concept for Rails projects.
                          Allows to create complex forms for a few models simultaneously.
                          Supports selectable per step validations without data persistence into db.}
  spec.homepage      = "https://github.com/vergilet/schoolgirl_uniform"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    # spec.metadata["source_code_uri"] = "Put your gem's public repo URL here."
    # spec.metadata["changelog_uri"] = "Put your gem's CHANGELOG.md URL here."
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'activemodel'

  spec.add_dependency "bundler", '~> 2.0'
  spec.add_dependency "rake", '~> 13.0'
  spec.add_dependency "rspec", '~> 3.5'
end

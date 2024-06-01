# frozen_string_literal: true

$:.push File.expand_path('lib', __dir__)
require 'solidus_related_products/version'

Gem::Specification.new do |s|
  s.name = 'solidus_related_products'
  s.version = SolidusRelatedProducts::VERSION
  s.summary = 'Allows multiple types of relationships between products to be defined'
  s.description = s.summary
  s.license = 'BSD-3-Clause'

  s.authors = ['Brian Quinn', 'Jonathan Tapia']
  s.email = 'brian@railsdog.com'
  s.homepage = 'https://github.com/jtapia/solidus_related_products'

  s.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.test_files = Dir['spec/**/*']
  s.bindir = 'exe'
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  if s.respond_to?(:metadata)
    s.metadata['homepage_uri'] = s.homepage if s.homepage
    s.metadata['source_code_uri'] = 'https://github.com/solidusio-contrib/solidus_prototypes'
  end

  s.required_ruby_version = ['>= 3.0', '< 4']

  s.add_dependency 'solidus_backend', ['>= 3.2.0', '< 5']
  s.add_dependency 'solidus_core', ['>= 3.2.0', '< 5']
  s.add_dependency 'solidus_support', '~> 0.5'
  s.add_dependency 'deface', '~> 1.0'

  s.add_development_dependency 'solidus_dev_support'
  s.add_development_dependency 'rails-controller-testing'
  s.add_development_dependency 'rspec-activemodel-mocks'
  s.add_development_dependency 'shoulda-matchers'
end

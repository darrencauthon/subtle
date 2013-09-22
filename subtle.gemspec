# -*- encoding: utf-8 -*-
require File.expand_path('../lib/subtle/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Darren Cauthon"]
  gem.email         = ["darren@cauthon.com"]
  gem.description   = %q{A few small updates to make even more concise Ruby.}
  gem.summary       = %q{A few small updates to make even more concise Ruby.}
  gem.homepage      = "http://www.github.com/darrencauthon/subtle"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "subtle"
  gem.require_paths = ["lib"]
  gem.version       = Subtle::VERSION

  # specify any dependencies here; for example:
  gem.add_runtime_dependency 'blankslate'
  gem.add_development_dependency 'mocha'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'coveralls'
  gem.add_development_dependency 'minitest'
end

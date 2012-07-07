# -*- encoding: utf-8 -*-
require File.expand_path('../lib/smoke_monster/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Darren Cauthon"]
  gem.email         = ["darren@cauthon.com"]
  gem.description   = %q{Unexplained, dark magic.}
  gem.summary       = %q{Unexplained, dark magic.}
  gem.homepage      = "http://www.github.com/darrencauthon/smoke_monster"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "smoke_monster"
  gem.require_paths = ["lib"]
  gem.version       = SmokeMonster::VERSION

  # specify any dependencies here; for example:
  gem.add_runtime_dependency 'blankslate'
  gem.add_development_dependency 'mocha'
end

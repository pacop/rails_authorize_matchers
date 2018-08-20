Gem::Specification.new do |s|
  s.name        = 'rails_authorize_matchers'
  s.version     = '0.1.0'
  s.summary     = 'RSpec matchers for RailsAuthorize policies'
  s.description = 'A set of RSpec matchers for testing RailsAuthorize authorisation policies'
  s.authors     = ['F. Padillo']
  s.email       = 'fpadilloruz@gmail.com'
  s.files       = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  s.homepage    = 'http://github.com/pacop/rails_authorize_matchers'
  s.license     = 'MIT'

  s.add_dependency 'rspec-rails', '>= 3.0.0'
  s.add_development_dependency 'rails_authorize', '~> 1.1', '>= 1.1.0'
end

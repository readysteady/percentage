Gem::Specification.new do |s|
  s.name = 'percentage'
  s.version = '1.0.1'
  s.license = 'LGPL-3.0'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Tim Craft']
  s.email = ['mail@timcraft.com']
  s.homepage = 'http://github.com/timcraft/percentage'
  s.description = 'A little library for working with percentages'
  s.summary = 'See description'
  s.files = Dir.glob('{lib,spec}/**/*') + %w(LICENSE.txt README.md Rakefile.rb percentage.gemspec)
  s.required_ruby_version = '>= 1.9.3'
  s.add_development_dependency('rake', '~> 10')
  s.add_development_dependency('minitest', '~> 5')
  s.require_path = 'lib'
end

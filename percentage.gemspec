Gem::Specification.new do |s|
  s.name = 'percentage'
  s.version = '1.2.0'
  s.license = 'LGPL-3.0'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Tim Craft']
  s.email = ['mail@timcraft.com']
  s.homepage = 'https://github.com/timcraft/percentage'
  s.description = 'A little library for working with percentages'
  s.summary = 'See description'
  s.files = Dir.glob('{lib,spec}/**/*') + %w(LICENSE.txt README.md Rakefile.rb percentage.gemspec)
  s.required_ruby_version = '>= 1.9.3'
  s.require_path = 'lib'
end

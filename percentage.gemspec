Gem::Specification.new do |s|
  s.name = 'percentage'
  s.version = '1.0.0'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Tim Craft']
  s.email = ['mail@timcraft.com']
  s.homepage = 'http://github.com/timcraft/percentage'
  s.description = 'A little library for working with percentages'
  s.summary = 'See description'
  s.files = Dir.glob('{lib,spec}/**/*') + %w(README.md Rakefile.rb percentage.gemspec)
  s.require_path = 'lib'
end

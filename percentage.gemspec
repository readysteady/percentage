Gem::Specification.new do |s|
  s.name = 'percentage'
  s.version = '2.3.0'
  s.license = 'LGPL-3.0'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Tim Craft']
  s.email = ['email@timcraft.com']
  s.homepage = 'https://github.com/readysteady/percentage'
  s.description = 'Ruby gem for working with percentages'
  s.summary = 'See description'
  s.files = Dir.glob('lib/**/*.rb') + %w[CHANGES.md LICENSE.txt README.md percentage.gemspec]
  s.required_ruby_version = '>= 2.5.0'
  s.require_path = 'lib'
  s.metadata = {
    'homepage' => 'https://github.com/readysteady/percentage',
    'source_code_uri' => 'https://github.com/readysteady/percentage',
    'bug_tracker_uri' => 'https://github.com/readysteady/percentage/issues',
    'changelog_uri' => 'https://github.com/readysteady/percentage/blob/main/CHANGES.md'
  }
  s.add_dependency 'bigdecimal', '~> 3'
end

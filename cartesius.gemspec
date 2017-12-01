Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.4.0'
  s.name = 'cartesius'
  s.version = '1.0.0'
  s.summary = 'The cartesian coordinate system.'
  s.description = 'The cartesian plan and its elements.'
  s.author = 'Mauro Quaglia'
  s.email = 'mauroquaglia@libero.it'
  s.files = [
      'lib/cartesius/point.rb',
      'lib/cartesius/line.rb',
      'lib/cartesius/segment.rb',
      'lib/cartesius/circumference.rb',
      'lib/cartesius/parabola.rb',
      'lib/cartesius/ellipse.rb',
      'lib/cartesius/hyperbola.rb'
  ]
  s.homepage = 'https://github.com/MauroQuaglia/cartesius'
  s.license = 'MIT'
end

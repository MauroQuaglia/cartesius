Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = 'cartesius'
  s.version = '1.1.2'
  s.summary = 'The cartesian coordinate system.'
  s.description = 'The cartesian plan and its elements.'
  s.author = 'Mauro Quaglia'
  s.email = 'mauroquaglia@libero.it'
  s.files = [
      'lib/cartesius/angle.rb',
      'lib/cartesius/circumference.rb',
      'lib/cartesius/cramer.rb',
      'lib/cartesius/determinator.rb',
      'lib/cartesius/ellipse.rb',
      'lib/cartesius/hyperbola.rb',
      'lib/cartesius/line.rb',
      'lib/cartesius/neighbourhoods.rb',
      'lib/cartesius/numerificator.rb',
      'lib/cartesius/parabola.rb',
      'lib/cartesius/point.rb',
      'lib/cartesius/segment.rb',
      'lib/cartesius/tolerance.rb',
      'lib/cartesius/triangle.rb',
      'lib/cartesius/validator.rb'
  ]
  s.homepage = 'https://github.com/MauroQuaglia/cartesius'
  s.license = 'MIT'
end

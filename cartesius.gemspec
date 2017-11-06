Gem::Specification.new do |s|
  s.name = 'cartesius'
  s.version = '0.0.1'
  s.summary = 'The cartesian coordinate system.'
  s.description = 'The cartesian plan and its elements.'
  s.author = 'Mauro Quaglia'
  s.email = 'mauroquaglia@libero.it'
  s.files = Dir['/lib/cartesius/models/parabola.rb']
  s.homepage = 'https://github.com/MauroQuaglia/cartesius'
  s.license = 'MIT'
end

# eliminare cartella coverage
# eliminare cartella idea
#gemspec cartesius
# lasciare sotto lib cartesius solo i file che mi interessano e spostare modules e support sotto altro ma non lib
# nel gemspec specificare.files

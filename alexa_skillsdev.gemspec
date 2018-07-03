Gem::Specification.new do |s|
  s.name = 'alexa_skillsdev'
  s.version = '0.2.1'
  s.summary = 'Provides convenient access to the Alexa Skills API methods.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/alexa_skillsdev.rb']
  s.signing_key = '../privatekeys/alexa_skillsdev.pem'
  s.add_runtime_dependency('rest-client', '~> 2.0', '>=2.0.2')
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/alexa_skillsdev'
end

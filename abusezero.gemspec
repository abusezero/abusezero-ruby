Gem::Specification.new do |s|
  s.name = 'abusezero'
  s.version = '0.1.0'
  s.summary = 'The official AbuseZero Ruby SDK: abuse prevention API for SaaS.'
  s.authors = ['AbuseZero']
  s.homepage = 'https://abusezero.com'
  s.license = 'Nonstandard'
  s.metadata = {
    'homepage_uri' => 'https://abusezero.com',
    'documentation_uri' => 'https://docs.abusezero.com/docs/tools/ruby-sdk',
    'source_code_uri' => 'https://github.com/abusezero/abusezero-ruby',
    'rubygems_mfa_required' => 'true'
  }
  s.required_ruby_version = '>= 3.3'
  s.files = Dir['lib/**/*.rb', 'lib/**/*.json', 'sig/**/*.rbs', 'README.md', 'API.md', 'LICENSE', 'THIRD-PARTY-NOTICES', 'examples/*']
  s.require_paths = ['lib']
  s.add_dependency 'base64', '>= 0.2', '< 1'
end

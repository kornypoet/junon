# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'junon/version'

Gem::Specification.new do |gem|
  gem.name          = 'junon'
  gem.version       = Junon::VERSION
  gem.authors       = ['Travis Dempsey']
  gem.email         = ['travis@infochimps.com']
  gem.licenses      = ['Apache 2.0']
  gem.homepage      = 'https://github.com/infochimps-labs/junon.git'
  gem.summary       = 'A Ruby client library for RunDeck'
  gem.description   = <<-DESC.gsub(/^ {4}/, '').strip
    Named after the airbase city in Final Fantasy VII, Junon.
  DESC

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(/^bin/){ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(/^spec/)
  gem.require_paths = ['lib']

  gem.add_dependency('faraday',            '~> 0.8')
  gem.add_dependency('faraday_middleware', '~> 0.9')
  gem.add_dependency('gorillib',           '~> 0.5')
  gem.add_dependency('multi_xml',          '~> 0.5')

  gem.add_development_dependency('bundler', '~> 1.3')
end

# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'kenui/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'kenui'
  s.version     = Kenui::VERSION
  s.authors     = 'Kill Bill core team'
  s.email       = 'killbilling-users@googlegroups.com'
  s.homepage    = 'http://www.killbill.io'
  s.summary     = 'Kill Bill Email Notification UI mountable engine'
  s.description = 'Rails UI plugin for the Email notification plugin.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'sass-rails', '~> 6.0.0'
  s.add_dependency 'rails', '~> 5.2.8.1'
  s.add_dependency 'js-routes', '~> 2.2.4'
  s.add_dependency 'jquery-rails', '~> 4.3'
  s.add_dependency 'jquery-datatables-rails', '~> 3.4.0'
  # See https://github.com/seyhunak/twitter-bootstrap-rails/issues/897
  s.add_dependency 'money-rails', '~> 1.15.0'
  s.add_dependency 'font-awesome-rails', '~> 4.7.0.8'
  s.add_dependency 'killbill-client', '~> 3.3.1'
  s.add_dependency 'bootstrap', '~> 5.2.2'
  s.add_dependency 'bootstrap-sass', '~> 3.4.1'

  s.add_development_dependency 'gem-release'
  s.add_development_dependency 'json'
  s.add_development_dependency 'listen'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rubocop', '~> 0.88.0' if RUBY_VERSION >= '2.4'
  s.add_development_dependency 'simplecov'
end

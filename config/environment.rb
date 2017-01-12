ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

if File.exists?(ENV['BUNDLE_GEMFILE'])
  require 'bundler/setup'
end

#requirin'
require 'rubygems'
require 'uri'

require 'pathname'
require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require 'sinatra/reloader' if development?

require 'erb'

#Pathname helper constants

APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

configure do
  set :root, APP_ROOT.to_path

  enable :sessions
  set :session_secret, ENV['SESSION_SECRET'] || 'this is a secret shhhhhhh'

  set :views, File.join(Sinatra::Application.root, "app", "views")
  # set :public_folder
end

# Set up controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each {|file| require file}
Dir[APP_ROOT.join('app','helpers','*.rb')].each {|file| require file}

require APP_ROOT.join('config', 'database')

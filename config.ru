#The config file uses the environment and sets itself as the base for the web app
require ::File.expand_path('..config/environment', __FILE__)

set :app_file, __FILE__

run Sinatra::Application
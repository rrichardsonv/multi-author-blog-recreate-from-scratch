#Prints the server logs to the console via STDOUT
if Sinatra::Application.development?
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

#Auto load all files in app/models to avoid inheritance issues

Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
  filename = File.basename(model_file).gsub('.rb', '')
  autoload ActiveSupport::Inflector.camelize(filename), model_file
end

#For avoiding web app auto db_name setting conflict

db = URI.parse(ENV['DATABASE_URL'] || "postgres://localhost/#{APP_NAME}_#{Sinatra::Application.environment}")

DB_NAME = db.path[1..-1]

#Sinatra::Application.environment is set to the value of ENV['RACK_ENV'] if it's set. Otherwise it defaults to the :development environment

ActiveRecord::Base.establish_connection(
  :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host => db.host,
  :port => db.port,
  :username => db.user,
  :password => db.password,
  :database => DB_NAME,
  :encoding => 'utf8'
  )

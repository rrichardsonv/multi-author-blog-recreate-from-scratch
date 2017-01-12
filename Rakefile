require 'rake'

require ::File.expand_path('../config/environment', __FILE__ )

require 'active_support'
require 'active_support/core_ext'

namespace :generate do
  # desc "¿Porque no los dos?"
  # task :yolo => [:silly, :md(ENV['NAME']), :mg("create_"+ENV['NAME']+"s")]

  desc "silly print"
  task :silly do
    print "          ヽ(⌐■_■)ﾉ\n🌊🌊🌊🌊🌊🌊🌊🌊🌊🌊[__YOLO__]🌊🌊🌊🌊🌊🌊🌊🌊🌊🌊\n"
  end


  desc "Throw together a model, drop it into apps/model"
  task :md do
    unless ENV.has_key?('NAME') || ENV['NAME'][0] == 's'
      raise "Must explicit name model, e.g., rake generate:md NAME='user' < notice the singular tense"
    end


    model_name     = ENV['NAME'].camelize
    model_filename = ENV['NAME'].underscore + '.rb'
    model_path     = APP_ROOT.join('app', 'models', model_filename)

    if File.exist?(model_path)
      raise "ERROR: done fucked up and made the same model twice"
    end

    puts "Creating #{model_name} model in #{model_path}"
    File.open(model_path, 'w+') do |file|
      file.write(<<-EOF.strip_heredoc)
        class #{model_name} < ActiveRecord::Base
          #has_many
          #belongs_to

          #validates

        end
      EOF
    end
  end

  desc "Timestamp dat migrate file and stick it in the folder"
  task :mg do
    unless ENV.has_key?('NAME')
      raise "Must explicit name migration, e.g., rake generate:mg NAME='here_right_here"
    end

    table_shorthand = String.new
    if 0 == (ENV['NAME'] =~ /create/)
      table_shorthand = <<-EOF.strip_heredoc
      create_table :#{ENV['NAME'].split('_')[1]} do |t|


        t.timestamps
      end
      EOF

    end




    mig_name     = ENV['NAME'].camelize
    mig_filename = "%s_%s.rb" % [Time.now.strftime('%Y%m%d%H%M%S'),ENV['NAME'].underscore]
    mig_path     = APP_ROOT.join('db', 'migrate', mig_filename)



    if File.exist?(model_path)
      raise "ERROR: done fucked up and made the same migration twice"
    end

    puts "Creating migration in #{mig_path}"
    File.open(mig_path, 'w+') do |file|
      file.write(<<-EOF.strip_heredoc)
        class #{name} < ActiveRecord::Migration
          def change
            #{table_shorthand}

          end

      EOF
    end
  end
#END OF GENERATE NAMESPACE
end

namespace :db do
  desc "Why would I use anything else?!"
  task :yolo => [:silly,:drop, :create, :migrate, :seed]

  desc "Everyone's favorite catch all"
  task :reset => [:drop, :create, :migrate]

  desc "silly print"
  task :silly do
    print "\n\n          ヽ(⌐■_■)ﾉ\n🌊🌊🌊🌊🌊🌊🌊🌊🌊🌊[__YOLO__]🌊🌊🌊🌊🌊🌊🌊🌊🌊🌊\n"
  end

  desc "Creating the databases at #{DB_NAME}"
  task :create do
    puts "Creating development and test databases if they don't exist..."
    system("createdb #{APP_NAME}_development && createdb #{APP_NAME}_test")
  end

  desc "So many me@me.coms..... best just drop it "
  task :drop do
    puts "Dropping development and test databases..."
    `dropdb #{APP_NAME}_development && dropdb #{APP_NAME}_test`
  end

  desc "Stuff all those migration into the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
  task :migrate do
    ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
    ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
    ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do
      ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
    end
  end

  desc "Rollback your migration (optional STEP=<number here> to step back multiple times)"
  task :rollback do
    step = (ENV['STEP'] || 1).to_i
    ActiveRecord::Migrator.rollback('db/migrate', steps)
    Rake::Task['db:version'].invoke if Rake::Task['db:version']
  end

  desc "Fill that database with random stuff from db/seeds.rb!"
  task :seed do
    require APP_ROOT.join('db', 'seeds.rb')
  end

  desc "Returns this current schema version number"
  task :version do
    puts "Current version: #{ActiveRecord::Migrator.current_version}"
  end
end

desc 'Start IRB with application environment loaded'
task "console" do
  exec "irb -r./config/environment"
end


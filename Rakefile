require_relative 'config/environment.rb'
require 'sinatra/activerecord/rake'
require_relative 'db/seeds.rb'

namespace :db do

  desc "Migrate the db"
  task :migrate do
      connection_details = YAML::load(File.open('config/database.yml'))
      ActiveRecord::Base.establish_connection(connection_details)
      ActiveRecord::Migration.migrate("db/migrate/")
    end

desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end


end

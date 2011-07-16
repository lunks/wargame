APP_SERVER = "pedro.nascimento.co.uk"
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
require "bundler/capistrano"

set :application, "wargame"
set :user, "unicorn"
set :branch, "master"
set :scm, :git

server APP_SERVER, :web, :app, :db, :primary => true
set(:shared_database_path) {"#{shared_path}/databases"}

set :rvm_ruby_string, 'ree@wargame'
set :deploy_to, "/var/www/#{application}"
set :repository,  "git://github.com/lunks/wargame.git"
set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "/tmp/wargame.pid"
namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do 
    run "RAILS_ENV=production rvm #{rvm_ruby_string} && cd #{current_path} && bundle exec unicorn -c #{unicorn_config} -E production -D"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do 
    run "kill `cat #{unicorn_pid}`"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "kill -s QUIT `cat #{unicorn_pid}`"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "kill -s USR2 `cat #{unicorn_pid}`"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
end
namespace :sqlite3 do
  desc "Generate a database configuration file"
  task :build_configuration, :roles => [:db, :app] do
    db_options = {
      "adapter"  => "sqlite3",
      "database" => "#{shared_database_path}/production.sqlite3"
    }
    config_options = {"production" => db_options}.to_yaml
    put config_options, "#{current_path}/config/database.yml"
  end

  desc "Make a shared database folder"
  task :make_shared_folder, :roles => :db do
    run "mkdir -p #{shared_database_path}"
  end
end
after "deploy:setup", "sqlite3:make_shared_folder"
after "deploy:setup", "sqlite3:build_configuration"

before "deploy:migrate", "sqlite3:build_configuration"
after "deploy:finalize_update", "sqlite3:build_configuration"


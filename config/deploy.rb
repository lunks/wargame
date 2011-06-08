APP_SERVER = "pedro.nascimento.co.uk"
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
require "bundler/capistrano"

set :application, "wargame"
set :user, "unicorn"
set :branch, "master"
set :scm, :git

server APP_SERVER, :web, :app, :db, :primary => true

set :rvm_ruby_string, 'ree@wargame'
set :deploy_to, "/var/www/#{application}"
set :repository,  "git://github.com/lunks/wargame.git"
set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "/tmp/wargame.pid"
namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do 
    run "RAILS_ENV=production rvm #{rvm_ruby_string} && cd #{current_path} && rm lib/tasks/ci.rake && rake db:migrate && bundle exec unicorn -c #{unicorn_config} -E production -D"
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
    reload
  end
end
namespace :delete_stuff do
  task :cirake do
    run "rm lib/tasks/ci.rake"
  end
end

before "deploy:migrations", "delete_stuff:cirake"

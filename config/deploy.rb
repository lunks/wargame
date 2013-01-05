APP_SERVER = "ec2-177-71-153-44.sa-east-1.compute.amazonaws.com"
require "bundler/capistrano"

ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "morali.pem")]

default_environment['PATH'] = "/opt/bitnami/memcached/bin:/opt/bitnami/perl/bin:/opt/bitnami/git/bin:/opt/bitnami/nginx/sbin:/opt/bitnami/sphinx/bin:/opt/bitnami/sqlite/bin:/opt/bitnami/php/bin:/opt/bitnami/mysql/bin:/opt/bitnami/apache2/bin:/opt/bitnami/subversion/bin:/opt/bitnami/ruby/bin:/opt/bitnami/common/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"
set :application, "wargame"
set :user, "bitnami"
set :branch, "master"
set :scm, :git
set :use_sudo, false


server APP_SERVER, :web, :app, :db, :primary => true

set :deploy_to, "/home/#{user}/apps/#{application}"
set :repository,  "git://github.com/lunks/wargame.git"
namespace :deploy do
  task :restart do
    run "cd #{current_path} && touch tmp/restart.txt"
  end
end

require "rvm/capistrano"
require "bundler/capistrano"
require 'capistrano/ext/multistage'
set :rvm_type, :system
set :application, "MindWavesServer"
set :repository,  "git@github.com:azimpradhan/MindWavesServer.git"
set :scm_passphrase, ""
set :scm, :git
set :use_sudo, false
# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :user, "deploy"

#role :web, "azimpradhan.com"                          # Your HTTP server, Apache/etc
#role :app, "azimpradhan.com"                          # This may be the same as your `Web` server
#role :db,  "azimpradhan.com", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

#set :deploy_to, "/var/www/sites/azimpradhan.com/"
set :stages, ["staging", "production"]
set :default_stage, "production"
after "deploy", "deploy:migrate"
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

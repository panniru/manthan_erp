# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'school_erp'
set :scm, :git
set :repo_url, 'git@github.com:sri-sankl/manthan_erp.git'
set :user, "deployer"
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :deploy_via, :remote_cache
set :branch, 'master'

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.1.2'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value
set :use_sudo, true
set :ssh_options, { :forward_agent => true }

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
 set :keep_releases, 5

namespace :deploy do

  #after :restart, :clear_cache do
    #Zon roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    #end
  #end

  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command do
      on roles(:app) do
        puts "#{fetch(:application)}"
        execute "/etc/init.d/unicorn #{command}" #_#{fetch(:application)
      end
    end
  end

  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:web) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  before "deploy", "deploy:check_revision"

end

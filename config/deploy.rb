# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, "myblog"
set :repo_url, "git@github.com:hpp19941122/myblog.git"

# Default branch is :master
set :branch, 'master'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/myblog"

# Default value for :linked_files is []
#append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
#append :linked_dirs, "bin", "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/images", "public/uploads"

# Default value for keep_releases is 5
set :keep_releases, 5
set :pty, true

set :use_sudo, false
set :deploy_via, :remote_cache
set :stages, %w(integration production)

set :puma_threds,  [4, 16]
set :puma_workers, 0
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub), port: 22 }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord


namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :confirm do
    on roles(:app) do
      puts "This stage is '#{fetch(:stage)}'. Deploying branch is '#{fetch(:branch)}'."
      puts 'Are you sure? [y/n]'
      ask :answer, 'n'
      if fetch(:answer) != 'y'
        puts 'deploy stopped'
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting,     :confirm
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
end
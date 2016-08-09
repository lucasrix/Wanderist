# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'maplify-api'
set :repo_url, 'git@github.com:sparrow/wanderist-api.git'
set :branch, 'fix-password'
set :deploy_user, 'deployer'

set :default_env, { rvm_bin_path: '~/.rvm/bin' }

set :deploy_to, "/home/#{fetch(:deploy_user)}/www/#{fetch(:application)}"
set :pty, true
set :linked_files, %w(config/database.yml config/application.yml config/keys/pushcert_production.pem)
set :linked_dirs, %w(tmp/pids tmp/sockets log)

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [4, 12]
set :puma_workers, 2
set :puma_init_active_record, true
set :puma_preload_app, true

namespace :deploy do
  desc 'upload config files'
  task :upload_config do
    on roles(:all) do
      execute "mkdir -p #{deploy_to}/shared/config"
      upload!('config/database.yml', "#{deploy_to}/shared/config/database.yml")
      upload!('config/application.yml', "#{deploy_to}/shared/config/application.yml")
    end
  end

  desc 'upload apn keys'
  task :upload_apn_keys do
    on roles(:all) do
      execute "mkdir -p #{deploy_to}/shared/config/keys"
      upload!('config/keys/pushcert_development.pem', "#{deploy_to}/shared/config/keys/pushcert_development.pem")
      upload!('config/keys/pushcert_production.pem', "#{deploy_to}/shared/config/keys/pushcert_production.pem")
    end
  end

  desc 'upload nginx ssl keys'
  task :upload_ssl_keys do
    on roles(:all) do
      tmp_dir = "#{deploy_to}/tmp/ssl"
      nginx_dir = '/etc/nginx/ssl/api.maplifyapp.com'

      execute "mkdir -p #{tmp_dir}"
      sudo "mkdir -p #{nginx_dir}"

      upload!('config/keys/ssl-bundle.crt', "#{tmp_dir}/ssl-bundle.crt")
      upload!('config/keys/api-maplifyapp-private.key', "#{tmp_dir}/api-maplifyapp-private.key")
      upload!('config/keys/dhparam.pem', "#{tmp_dir}/dhparam.pem")

      sudo "mv #{tmp_dir}/ssl-bundle.crt #{nginx_dir}/ssl-bundle.crt"
      sudo "mv #{tmp_dir}/api-maplifyapp-private.key #{nginx_dir}/api-maplifyapp-private.key"
      sudo "mv #{tmp_dir}/dhparam.pem #{nginx_dir}/dhparam.pem"

      execute "rm -r #{tmp_dir}"
    end
  end

  desc 'Install gem for backups'
  task :backup do
    on roles(:all) do
      execute "/bin/bash -lc 'gem install backup:4.2.2 --no-ri --no-rdoc'"
    end
  end

  before :starting, 'deploy:upload_config'
  before :starting, 'deploy:upload_apn_keys'
  before :starting, 'deploy:upload_ssl_keys'
  after  :finished, 'deploy:backup'
end

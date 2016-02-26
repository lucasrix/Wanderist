# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server 'example.com', user: 'deploy', roles: %w{app db web}, my_property: :my_value
# server 'example.com', user: 'deploy', roles: %w{app web}, other_property: :other_value
# server 'db.example.com', user: 'deploy', roles: %w{db}
# server '10.10.10.175', user: 'deployer', roles: %w{}


# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any  hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }


require "ostruct"

role :app, %w{deployer@10.10.10.175}
role :web, %w{deployer@10.10.10.175}
role :db,  %w{deployer@10.10.10.175}

set :branch, 'apipie'

server '10.10.10.175', user: 'deployer', roles: %w{web app}

set :deploy_to, '/home/deployer/sites/wanderist'
set :rvm_ruby_version, 'ruby-2.3.0@deployer --create'
set :rails_env, "staging"

def template(from, to, as_root = false)
  on roles(:all) do
    variables = OpenStruct.new(server_ip: host.hostname)
    template_path = File.expand_path("../recipes/templates/#{from}", __FILE__)
    template = ERB.new(File.new(template_path).read).result(variables.instance_eval { binding })
    upload! StringIO.new(template), to

    execute :sudo, :chmod, "655 #{to}"
    execute :sudo, :chown, "root:root #{to}" if as_root == true
  end
end

namespace :maintance do

  desc "Turn maintance mode on"
  task :start do
    on roles(:app) do
      execute "touch #{fetch(:deploy_to)}/shared/public/system/maintance.txt"
    end
  end

  desc "Turn maintance mode off"
  task :stop do
    on roles(:app) do
      execute "rm #{fetch(:deploy_to)}/shared/public/system/maintance.txt"
    end
  end

end

namespace :deploy do

  desc 'Setup staging'
  task :setup do
    on roles(:all) do
      # invoke 'setup:faye'
      # invoke 'setup:ssl'
      invoke 'setup:config'
      invoke 'setup:backup'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 10 do
      # invoke 'rvm1:hook'
      if test("[ -f #{deploy_to}/current/tmp/pids/puma.pid ]")
        within "#{fetch(:deploy_to)}/current/" do
          execute :bundle, :exec, :"pumactl -F config/puma.rb stop"
          execute :bundle, :exec, :"puma -C config/puma.rb -e staging"
        end
      else
        within "#{fetch(:deploy_to)}/current/" do
          execute :bundle, :exec, :"puma -C config/puma.rb -e staging"
        end
      end
    end
  end

  after :publishing, :restart
end

namespace :setup do

  # desc 'Setup Faye config files'
  #
  # task :faye do
  #   on roles(:all) do
  #     execute "mkdir -p #{deploy_to}/shared/config/"
  #     execute "mkdir -p #{deploy_to}/shared/config/faye"
  #     template "staging/faye/faye_config.erb", "#{deploy_to}/shared/config/faye/faye.ru"
  #     template "staging/faye/thin_config.erb", "#{deploy_to}/shared/config/faye/thin.yml"
  #   end
  # end

  # desc 'Setup ssl certificates'
  #
  # task :ssl do
  #   on roles(:all) do
  #     execute "sudo mkdir -p /etc/nginx/ssl/pindify_com/"
  #     upload!("config/ssl-bundle.chained.crt", "#{deploy_to}/shared/tmp/ssl-bundle.chained.crt")
  #     upload!("config/pindify-ssl-private.key", "#{deploy_to}/shared/tmp/pindify-ssl-private.key")
  #     upload!("config/dhparam.pem", "#{deploy_to}/shared/tmp/dhparam.pem")
  #     execute :sudo, "mv #{deploy_to}/shared/tmp/ssl-bundle.chained.crt /etc/nginx/ssl/pindify_com/ssl-bundle.chained.crt"
  #     execute :sudo, "mv #{deploy_to}/shared/tmp/pindify-ssl-private.key /etc/nginx/ssl/pindify_com/pindify-ssl-private.key"
  #     execute :sudo, "mv #{deploy_to}/shared/tmp/dhparam.pem /etc/nginx/ssl/pindify_com/dhparam.pem"
  #   end
  # end

  desc 'Setup application config files'

  task :config do
    on roles(:all) do
      upload!("config/sidekiq.staging.yml", "#{deploy_to}/shared/config/sidekiq.yml")
      upload!("config/database.staging.yml", "#{deploy_to}/shared/config/database.yml")
      upload!("config/application.staging.yml", "#{deploy_to}/shared/config/application.yml")
      upload!("config/newrelic.yml", "#{deploy_to}/shared/config/newrelic.yml")
    end
  end

  desc 'Install gem for backups'

  task :backup do
    on roles(:app) do
      execute "/bin/bash -lc 'gem install backup:4.1.1 --no-ri --no-rdoc'"
    end
  end

end



namespace :sidekiq do

  desc "Start sidekiq"
  task :start do
    on roles(:app), in: :sequence, wait: 12 do
      # invoke 'rvm1:hook'
      unless test("[ -f #{deploy_to}/current/tmp/pids/sidekiq.pid ]")
        within "#{fetch(:deploy_to)}/current/" do
          execute "sudo monit start sidekiq"
        end
      end
    end
  end

  desc "Stop sidekiq"
  task :stop do
    on roles(:app), in: :sequence, wait: 12 do
      # invoke 'rvm1:hook'
      if test("[ -f #{deploy_to}/current/tmp/pids/sidekiq.pid ]")
        within "#{fetch(:deploy_to)}/current/" do
          execute "sudo monit stop sidekiq"
        end
      end
    end
  end

  before :deploy, "sidekiq:stop"
  after :deploy, "sidekiq:start"

  before :deploy, "maintance:start"
  after :deploy, "maintance:stop"
end

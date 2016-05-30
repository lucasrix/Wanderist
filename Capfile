require 'capistrano/setup'
require 'capistrano/deploy'

require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/puma'
require 'capistrano/delayed_job'
require 'whenever/capistrano'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

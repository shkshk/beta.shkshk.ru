load "deploy" if respond_to?(:namespace)

set :application, "shkshk.ru"
set :deploy_to, "/home/vast/shkshk.ru"
set :deploy_via, :copy
set :repository, "build"
set :scm, :none
set :copy_compression, :gzip
set :use_sudo, false
set :normalize_asset_timestamps, false
set :domain, "shkshk.ru"
set :user, "vast"
set :keep_releases, 3

role :web, "shkshk.ru:22123"

before "deploy:update_code" do
  run_locally "rm -rf build/*"
  run_locally "./node_modules/.bin/gulp build"
end

after "deploy:restart", "deploy:cleanup"

# prettify output
logger.level = Capistrano::Logger::IMPORTANT
STDOUT.sync

before "deploy:update"              do print "\e[36m-->\e[0m Building the site............"; end
after  "deploy:update"              do puts  "[\e[32m✓\e[0m]";                              end

before "deploy:restart"             do print "\e[37m-->\e[0m Finishing deploy............."; end
after  "deploy:restart"             do puts  "[\e[32m✓\e[0m]";                              end

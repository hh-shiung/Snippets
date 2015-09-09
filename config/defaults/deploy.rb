require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)

set :domain, ''       # remote server domain
set :deploy_to, ''    # where to store th files
set :repository, ''   # which repository to link to
set :branch, ''       # which branch to reference from
set :term_mode, nil
set :rails_env, 'production'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'config/secrets.yml', 'log']

# Optional settings:
   set :user, ''        # Username in the server to SSH to.
   set :port, ''        # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  invoke :'rbenv:load'
end

task :ping do
  queue %[ls]
end

task :update do
  queue "cd #{deploy_to}/current"
  queue "bundle install"
end

#mina update_ruby v=2.1.5
task :update_ruby do
  queue "rbenv local #{v}"
  queue "gem install bundle"
end

task :minatest do
  puts "hello world"
end

# this part is not tested
# task :provision do
#   queue %[sudo apt-get update && sudo apt-get upgrade]
#   queue %[sudo apt-get install postgresql libpq-dev imagemagick nodejs redis-server git]
#   queue %[\curl -sSL https://get.rvm.io | bash -s stable --ruby]
#   queue %[source ~/.rvm/scripts/rvm]
#   queue %[rvm install 1.9.3-p547]
#   queue %[gem install rails]
# end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]

  # export a new secret for secrets.yml
  queue "cd #{deploy_to}/current"
  queue %[echo "export SECRET_KEY_BASE="`bundle exec rake secret` >> ~/.bashrc]
  queue %[echo "export SECRET_TOKEN="`bundle exec rake secret` >> ~/.bashrc]
end

task :bundle_update do
  queue "cd #{deploy_to}/current"
  queue "bundle install --no-deployment"
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    # queue "git clone"
    invoke :'git:clone'
    # queue "bundle install"
    invoke :'bundle:install'
    invoke :'rails:db_create'
    invoke :'rails:db_migrate'
    invoke :'seed'
    invoke :'rails:assets_precompile'
    invoke :'deploy:link_shared_paths'

    to :launch do
      queue "touch #{deploy_to}/tmp/restart.txt"
    end
  end
end

desc "Seed data to the database"
task :seed => :environment do
    queue "cd #{deploy_to}/#{current_path}/"
    queue "bundle exec rake db:seed RAILS_ENV=#{rails_env}"
    queue  %[echo "-----> Rake Seeding Completed."]
end

# assumes redis, sidekiq and rails not running
# task :start => :environment do
#   # queue %[touch redis-daemonize && echo 'daemonize yes' >> redis-daemonize && redis-server redis-daemonize]
#   queue %[cd #{deploy_to}/current]
#   # queue %[bundle exec sidekiq -d -l log/sidekiq.log]
#   queue %[rails s -e production -d]
# end

task :first => :environment do
  queue %[cd #{deploy_to}/current]
  queue %[bundle exec rails server -b 0.0.0.0 -e production --pid #{deploy_to}/tmp/server.pid -d] #--pid  #{deploy_to}/tmp/server.pid
end

# task :start => :environment do
#   queue %[cd #{deploy_to}/current]
#   # queue %[rails server puma -d -b 0.0.0.0 -e production --pid #{deploy_to}/tmp/server.pid]
#   queue %[bundle exec puma -t 8:48 -b tcp://0.0.0.0:3000 -e production -d] #--pid  #{deploy_to}/tmp/server.pid
# end

# restarts rails server, redis, and sidekiq
task :restart => :environment do
  # queue %[kill -s SIGUSR2 `cat #{deploy_to}/tmp/server.pid`]
  queue %[kill -9 $(cat #{deploy_to}/tmp/server.pid)]
  queue %[cd #{deploy_to}/current]
  # queue %[rails server puma -d -b 0.0.0.0 -e production --pid #{deploy_to}/tmp/server.pid]
  queue %[bundle exec rails server -b 0.0.0.0 -e production --pid #{deploy_to}/tmp/server.pid -d] #--pid  #{deploy_to}/tmp/server.pid
  # can restart sidekiq
  # how to restart redis without losing data?
end

# restarts rails server, redis, and sidekiq
# task :restart => :environment do
#   #stop rails
#   puts "- stop existing rails" if queue "kill -9 $(cat #{deploy_to}/tmp/server.pid)"
#   #start rails
#   puts "- change directory" if queue "cd #{deploy_to}/current"
#   puts "- start new rails" if queue "rails s -e production --pid #{deploy_to}/tmp/server.pid -d"
# end

task :logs do
  queue 'tail -f /var/log/nginx/error.log'
end

# task :kill_that do
#   queue "kill -9 $(cat #{deploy_to}/tmp/server.pid)"
# end

# task :console do
#   queue "cd #{deploy_to}/current"
#   queue "rails console"
# end

#mina kill pid=10353
task :kill do
  queue "kill -9 #{ENV['pid']}"
end

task :reboot do
  queue "sudo reboot"
end

task :l do
  # queue 'tail -f /var/log/nginx/error.log'
  queue "tail -f #{deploy_to}/shared/log/production.log"
  # queue "cat #{deploy_to}/shared/log/production.log"
end

task :whenever do
  queue "cd #{deploy_to}/current"
  queue "bundle exec whenever"
end

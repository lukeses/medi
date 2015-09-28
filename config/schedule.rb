# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']

set :environment, 'development'

# set :job_template, "bash -l -c 'rvm 2.2.2'"

every 1.minute do
  rake 'visits:delete_unconfirmed_visits', :output => 'log/visit_destroy.log'
end
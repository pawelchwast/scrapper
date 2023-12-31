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

# fix crontabs
# https://gist.github.com/cre-o/4535005

every '* 8 * * *' do
  rake "scrapper:deleted_domains"
end

every 1.day, at: ['10:00 am'] do
  rake "scrapper:phrases_lookup"
end

every 1.day, at: ['12:00 am'] do
  rake "scrapper:ping"
end



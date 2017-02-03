Rake::Task['db:reset'].clear
namespace :db do
  desc 'Delete data and re-create, loads the seeds'
  task reset: ['db:drop', 'db:setup']
end

desc "boot the app in production (on port 4000)"
task :boot do
  system('rails s -e production -p 4000')
end
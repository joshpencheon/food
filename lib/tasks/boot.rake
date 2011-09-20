desc "boot the app in production"
task :boot do
  system('rails s -e production')
end
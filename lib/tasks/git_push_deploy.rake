namespace :deploy do
  desc "Push to githut"
  task :push do
    sh "git push origin"
  end

  desc "Cap deploy"
  task :cap => :push do
    sh "cap production deploy"
  end
end

desc "git push origin and cap production deploy"
task :deploy => ["deploy:cap"]

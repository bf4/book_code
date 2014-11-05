#START:rake_pre_7
["test:units", "test:functionals", "recent"].each do |name|
  Rake::Task.lookup(name).prerequisites.clear
end
#END:rake_pre_7
#START:rake_post_7
["test:units", "test:functionals", "recent"].each do |name|
  Rake::Task[name].prerequisites.clear 
end
#END:rake_post_7
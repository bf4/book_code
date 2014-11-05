desc 'Build the application into a .jar file'
task :jar => ['Pitcher.class', 'Catcher.class', 'Manifest'] do
  sh 'jar -cfm baseball.jar Manifest Pitcher.class Catcher.class'
end

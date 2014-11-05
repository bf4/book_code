# The tasks in this file aren't used in the project;
# they're just an example of an alternative.

rule '.class' => '.java' do |t|
  sh "javac #{t.source}"
end

file 'Manifest' do
  File.open 'Manifest', 'w' do |f|
    f.puts 'Main-Class: Catcher'
  end
end

# START:namespace
jar = namespace :jar do
  # tasks for .class and Manifest go here

  desc 'Compile the Java code'
  task :compile => ['Pitcher.class', 'Catcher.class']

  desc 'Create a .jar file from the compiled code'
  task :create => [:compile, 'Manifest'] do
    sh 'jar -cfm baseball.jar Manifest Pitcher.class Catcher.class'
  end
end

javadoc = namespace :doc do
  directory 'doc'

  desc 'Build the documentation'
  task :create => 'doc' do
    sh 'javadoc -d doc *.java'
  end
end

task :default => [jar[:create], javadoc[:create]]
# END:namespace

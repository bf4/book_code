# The tasks in this file aren't used in the project;
# they're just an example of an alternative.

# START:pitcher
file 'Pitcher.class' => 'Pitcher.java' do
  sh 'javac Pitcher.java'
end
# END:pitcher

# START:catcher
file 'Catcher.class' => 'Catcher.java' do
  sh 'javac Catcher.java'
end
# END:catcher

directory 'doc'

desc 'Build the documentation'
task :javadoc => 'doc' do
  # START:javadoc
  sh 'javadoc -d doc *.java'
  # END:javadoc
end

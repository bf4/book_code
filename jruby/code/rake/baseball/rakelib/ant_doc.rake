namespace :ant do
  task :javadoc do
    ant.javadoc :sourcefiles => FileList["*.java"], :destdir => "doc"
  end
end

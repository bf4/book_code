namespace :ant do
  task :jar => :compile do
    ant.jar :basedir => ".", :destfile => "baseball.jar", :includes => "*.class" do
      manifest do
        attribute :name => "Main-Class", :value => "Catcher"
      end
    end
  end
end

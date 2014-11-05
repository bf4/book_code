#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
set :staging_db_pw, Proc.new {
  sync = STDOUT.sync
  begin
    echo false
    STDOUT.sync = true
    print "Enter DB password for staging server: " 
    gets.chomp
  ensure
    STDOUT.sync = sync
    echo true
    puts
  end
}

desc "After-deploy hook that puts the appropriate database password in database.yml"
task :after_deploy, :roles => :db do
  # The "render" method does an erb pass on the file, so it should contain
  # <%= staging_db_pw %> at the appropriate spots in database.example.  
  # You might also set other aspects of the database connection in deploy.rb 
  # (based on deploy environment, for example) and substitue them as well.
  database_yml = render "config/database.example", :staging_db_pw => staging_db_pw
  put(database_yml,
      "#{release_path}/config/database.yml",
      :mode => 0444)
end

# This is the definition of the 'echo' method, lifted from switchtower/cli.rb
# I've asked Jamis to make this method (or a higher-level interface to do what the
# proc above does) public in a future version of SwitchTower; he may have already
# done that.
begin
  if !defined?(USE_TERMIOS) || USE_TERMIOS
    require 'termios'
  else
    raise LoadError
  end

  # Enable or disable stdin echoing to the terminal.
  def echo(enable)
    term = Termios::getattr(STDIN)

    if enable
      term.c_lflag |= (Termios::ECHO | Termios::ICANON)
    else
      term.c_lflag &= ~Termios::ECHO
    end

    Termios::setattr(STDIN, Termios::TCSANOW, term)
  end
rescue LoadError
  def echo(enable)
  end
end

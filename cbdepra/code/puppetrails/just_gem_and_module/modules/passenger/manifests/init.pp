class passenger {
  exec {
    "/usr/local/bin/gem install passenger -v=3.0.11":
      user    => root,
      group   => root,
      alias   => "install_passenger",
      before  => Exec["passenger_apache_module"],
      unless  => "ls /usr/local/lib/ruby/gems/1.9.1/gems/passenger-3.0.11/"
  }
  exec {
    "/usr/local/bin/passenger-install-apache2-module --auto":
      user    => root,
      group   => root,
      path    => "/bin:/usr/bin:/usr/local/apache2/bin/",
      alias   => "passenger_apache_module",
      unless  => "ls /usr/local/lib/ruby/gems/1.9.1/gems/\
passenger-3.0.11/ext/apache2/mod_passenger.so"
  }
}


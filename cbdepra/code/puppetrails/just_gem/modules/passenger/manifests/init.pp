class passenger {
  exec {
    "/usr/local/bin/gem install passenger -v=3.0.11":
      user    => root,
      group   => root,
      alias   => "install_passenger",
      require => Package["apache2"],
      unless  => "ls /usr/local/lib/ruby/gems/1.9.1/gems/passenger-3.0.11/"
  }
}

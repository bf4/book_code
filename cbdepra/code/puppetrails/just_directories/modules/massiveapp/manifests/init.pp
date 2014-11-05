class massiveapp {
  file {
    ["/var/massiveapp/", 
     "/var/massiveapp/shared/", 
     "/var/massiveapp/shared/config/"]:
      ensure => directory,
      owner  => vagrant,
      group  => vagrant,
      mode   => 775
  }
}


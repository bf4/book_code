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
  file {
    "/var/massiveapp/shared/config/database.yml":
      ensure  => present,
      owner   => vagrant,
      group   => vagrant,
      mode    => 600,
      source  => "puppet:///modules/massiveapp/database.yml"
  }
}


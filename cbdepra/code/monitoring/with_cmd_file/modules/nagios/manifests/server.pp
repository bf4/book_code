class nagios::server {
  package {
    "nagios3":
      ensure => present
  }
  service {
    "nagios3":
      ensure      => running,
      hasrestart  => true,
      enable      => true,
      hasstatus   => true,
      restart     => "/etc/init.d/nagios3 reload",
      require     => Package["nagios3"]
  }
  file {
    "/etc/nagios3/apache2.conf":
      source  => "puppet:///modules/nagios/apache2.conf",
      owner   => root,
      group   => root,
      mode    => 644,
      notify  => Service["apache2"]; 
    "/etc/nagios3/htpasswd.users":
      source  => "puppet:///modules/nagios/htpasswd.users",
      owner   => www-data,
      group   => nagios,
      mode    => 640,
      require => [Package["apache2"],Package["nagios3"]];
   "/etc/nagios3/nagios.cfg":
      source  => "puppet:///modules/nagios/nagios.cfg",
      owner   => nagios,
      group   => nagios,
      mode    => 644,
      require => [Package["apache2"],Package["nagios3"]],
      notify  => [Service["apache2"],Service["nagios3"]];
    "/var/lib/nagios3/rw":
      ensure  => directory,
      owner   => nagios,
      group   => www-data,
      mode    => 710,
      require => Package["nagios3"];
  }  
  user {
    "www-data":
      groups  => "nagios",
      notify  => Package["apache2"],
      require => Package["nagios3"],
  }
}


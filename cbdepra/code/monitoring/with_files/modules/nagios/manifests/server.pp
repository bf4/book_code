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
  }
}


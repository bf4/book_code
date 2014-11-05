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
}


class apache2 {  
# other resources
  file {
    "/etc/apache2/apache2.conf":
      mode    => "0644",
      owner   => "root",
      group   => "root",
      source  => "puppet:///modules/apache/apache2.conf",
      notify  => Service["apache2"],
      require => Package["apache2"];
    "/etc/logrotate.d/apache2":
      ensure  => absent;
  }
# other resources
}


class apache2 {
  package {
    "apache2":
       ensure => present
  }
  service {
    "apache2":
      ensure => true,
      enable => true
  }
  file {
    "/etc/apache2/apache2.conf":
      source => "puppet:///modules/apache2/apache2.conf",
      mode   => 644,
      owner  => root,
      group  => root
  }
}

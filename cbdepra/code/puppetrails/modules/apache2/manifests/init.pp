class apache2 { 
  package {
    "apache2":
      ensure => present
  }

  service {
    "apache2":
      ensure => true,
      enable => true,
  }

# START:massiveappvhost
  file {
    "/etc/apache2/apache2.conf":
      owner  => root,
      group  => root,
      mode   => 644,
      source => "puppet:///modules/apache2/apache2.conf";
    "/etc/apache2/sites-enabled/massiveapp.conf":
      source  => "puppet:///modules/apache2/massiveapp.conf",
      owner   => root,
      group   => root,
      notify  => Service["apache2"],
      require => Package["apache2"];
  }
# END:massiveappvhost
}

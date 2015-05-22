class apache2{
  package {
    "apache2": 
    ensure => present,
    before => File["/etc/apache2/apache2.conf"]
  }

  service {
    "apache2":
      ensure => true,
      enable => true,
      subscribe => File["/etc/apache2/apache2.conf"]
  }

  file {
    "/etc/apache2/apache2.conf":
      source => "puppet:///modules/apache2/apache2.conf",
      owner => root,
      group => root,
      require => Package["apache2"]
  }

  file {
    "/etc/apache2/sites-available/webdev.conf":
      source => "puppet:///modules/apache2/webdev.conf",
      owner => root,
      group => root,
      notify => Exec["a2ensite webdev"],
      require => Package["apache2"]
  }

  file {
    "/etc/ssl/private/awesomeco.key":
      source => "puppet:///modules/apache2/awesomeco.key",
      owner => root,
      group => root,
      notify => File["/etc/ssl/certs/awesomeco.crt"],
      require => Package["apache2"]
  }

  file {
    "/etc/ssl/certs/awesomeco.crt":
      source => "puppet:///modules/apache2/awesomeco.crt",
      owner => root,
      group => root,
      notify => File["/etc/apache2/sites-available/webdevssl.conf"],
      require => File["/etc/ssl/private/awesomeco.key"] 
  }

  file {
    "/etc/apache2/sites-available/webdevssl.conf":
      source => "puppet:///modules/apache2/webdevssl.conf",
      owner => root,
      group => root,
      notify => Exec["a2enmod ssl"],
      require => File["/etc/ssl/certs/awesomeco.crt"],
  }

  exec { 'a2ensite webdev':
    command => 'a2ensite webdev',
    require => File["/etc/apache2/sites-available/webdev.conf"],
    notify => Service["apache2"]
  }

  exec { 'a2enmod ssl':
    command => 'a2enmod ssl',
    require => File["/etc/apache2/sites-available/webdevssl.conf"],
    notify => Exec["a2ensite webdev"],
  }

  exec { 'a2ensite webdevssl':
    command => 'a2ensite webdev',
    require => File["/etc/apache2/sites-available/webdevssl.conf"],
    notify => Service["apache2"]
  }


  file { '/etc/apache2/sites-enabled/000-default.conf': 
    ensure => absent, 
    require => Package["apache2"],
    notify => Service["apache2"]
  } 

  exec {'site-permission':
    command => 'sudo chmod -R 775 /var/www/site'
  }

}

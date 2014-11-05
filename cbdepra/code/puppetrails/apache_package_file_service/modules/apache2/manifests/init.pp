class apache2 {
#START:package
  package {
    "apache2":
      ensure => present,
      before => File["/etc/apache2/apache2.conf"]
  }
#END:package

  file {
    "/etc/apache2/apache2.conf":
      owner   => root,
      group   => root,
      mode    => 644,
      source  => "puppet:///modules/apache2/apache2.conf"
  }

#START:service
 service {
    "apache2":
      ensure    => true,
      enable    => true,
      subscribe => File["/etc/apache2/apache2.conf"]
  }
#END:service
}

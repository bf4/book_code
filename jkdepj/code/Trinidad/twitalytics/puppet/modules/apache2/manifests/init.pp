class apache2 {
  package { "apache2":
    ensure => present,
  }

  # START:service_apache2
  service { "apache2":
    ensure => running,
    require => [Package["apache2"], File["/etc/apache2/mods-enabled/proxy.conf"]]
  }
  # END:service_apache2

  # START:a2enmod_proxy_ajp
  exec { "a2enmod proxy_ajp" :
    command => "a2enmod proxy_ajp",
    path => $path,
    require => Package["apache2"],
    unless => "apache2ctl -M | grep proxy_ajp"
  }
  # END:a2enmod_proxy_ajp

  # START:define_apache_httpd_conf
  define apache2::httpd_conf($hostname="localhost", $port="8099") {
    file { $name :
      content => template("apache2/httpd.conf.erb")
    }
  }
  # END:define_apache_httpd_conf

  # START:apache_httpd_conf
  apache2::httpd_conf { "/etc/apache2/httpd.conf":
    require => Exec["a2enmod proxy_ajp"]
  }
  # END:apache_httpd_conf

  # START:apache_proxy_conf
  file { "/etc/apache2/mods-enabled/proxy.conf":
    content => template("apache2/proxy.conf.erb"),
    require => File["/etc/apache2/httpd.conf"]
  }
  # END:apache_proxy_conf
}
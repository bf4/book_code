class tomcat6 {
  package { "tomcat6" :
    ensure => present
  }

  service { "tomcat6" :
    ensure => running,
    require => Package["tomcat6"]
  }
}
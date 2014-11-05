class nagios::server {
  package {
    "nagios3":
      ensure => present
  }
}

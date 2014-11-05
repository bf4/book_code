class nagios::client {
  package {
    ["nagios-nrpe-server","nagios-plugins"]:
      ensure => present
  }
}

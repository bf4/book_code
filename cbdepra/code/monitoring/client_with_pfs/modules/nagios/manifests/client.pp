class nagios::client {
  package {
    ["nagios-nrpe-server","nagios-plugins"]:
      ensure => present
  }
  file {
    "/etc/nagios/nrpe.cfg":
      owner   => root,
      group   => root,
      mode    => 644,
      source  => "puppet:///modules/nagios/nrpe.cfg"
  }
  service {
    "nagios-nrpe-server":
      ensure    => true,
      enable    => true,
      subscribe => File["/etc/nagios/nrpe.cfg"]
  }
}

class nagios::client {
  package {
    ["nagios-nrpe-server","nagios-plugins"]:
      ensure => present,
      before => [File["/etc/nagios/nrpe.cfg"],\
      File["/usr/lib/nagios/plugins/check_passenger"]]
  }
  file {
    "/etc/nagios/nrpe.cfg":
      owner   => root,
      group   => root,
      mode    => 644,
      source  => "puppet:///modules/nagios/nrpe.cfg";
   "/usr/lib/nagios/plugins/check_passenger":
      source  => "puppet:///modules/nagios/plugins/check_passenger",
      owner   => nagios,
      group   => nagios,
      mode    => 755;
  }
  service {
    "nagios-nrpe-server":
      ensure    => true,
      enable    => true,
      subscribe => File["/etc/nagios/nrpe.cfg"]
  }
}

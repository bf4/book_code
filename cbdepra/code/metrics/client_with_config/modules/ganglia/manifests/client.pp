class ganglia::client {
  package {
    "ganglia-monitor":
      ensure  => installed
  }
  service {
    "ganglia-monitor":
      hasrestart => true
  }
  file {
    "/etc/ganglia/gmond.conf":
      source  => "puppet:///modules/ganglia/gmond_client.conf",
      owner   => root,
      group   => root,
      mode    => 644,
      notify  => Service["ganglia-monitor"],
      require => Package["ganglia-monitor"];
  }
}


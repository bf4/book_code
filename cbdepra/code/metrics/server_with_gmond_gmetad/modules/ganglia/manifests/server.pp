class ganglia::server {
  package {
    ["ganglia-monitor", "ganglia-webfrontend","gmetad"]:
      ensure  => installed
  }
  file {
    "/etc/ganglia-webfrontend/apache.conf":
      source  => "puppet:///modules/ganglia/apache.conf",
      owner   => root,
      group   => root,
      mode    => 644,
      notify  => Service["apache2"];
    "/etc/apache2/conf.d/ganglia.conf":
      ensure  => link,
      target  => "/etc/ganglia-webfrontend/apache.conf",
      require => File["/etc/ganglia-webfrontend/apache.conf"],
      notify  => Service["apache2"];
    "/etc/ganglia/gmond.conf":
      source  => "puppet:///modules/ganglia/gmond_server.conf",      
      owner   => root,
      group   => root,
      mode    => 644,
      notify  => Service["ganglia-monitor"],
      require => Package["ganglia-monitor"];
    "/etc/ganglia/gmetad.conf":
      source  => "puppet:///modules/ganglia/gmetad.conf",
      owner   => root,
      group   => root,       
      mode    => 644,
      notify  => Service["gmetad"],
      require => Package["gmetad"];
  }
}

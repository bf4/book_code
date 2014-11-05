class ganglia::server {
  package {
    ["ganglia-monitor", "ganglia-webfrontend","gmetad"]:
      ensure  => installed
  }
  file {
    "/etc/apache2/conf.d/ganglia.conf":
      ensure  => link,
      target  => "/etc/ganglia-webfrontend/apache.conf",
      notify  => Service["apache2"];
  }
}


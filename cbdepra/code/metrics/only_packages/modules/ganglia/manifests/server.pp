class ganglia::server {
  package {
    ["ganglia-monitor", "ganglia-webfrontend","gmetad"]:
      ensure  => installed
  }
}


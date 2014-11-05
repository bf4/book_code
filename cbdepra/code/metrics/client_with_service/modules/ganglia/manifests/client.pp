class ganglia::client {
  package {
    "ganglia-monitor":
      ensure  => installed
  }
  service {
    "ganglia-monitor":
      hasrestart => true
  }
}

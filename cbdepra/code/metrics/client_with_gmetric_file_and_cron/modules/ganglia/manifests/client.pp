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
    "/etc/ganglia/gmetric":
      ensure  => directory,
      owner   => root,
      group   => root;
    "/etc/ganglia/gmetric/ganglia_mysql_stats.pl":
      source  => "puppet:///modules/ganglia/gmetric/ganglia_mysql_stats.pl",
      owner   => root,
      group   => root,
      mode    => 755,  
      require => File["/etc/ganglia/gmetric"];
    "/etc/ganglia/gmetric/gmetric_accounts.rb":    
      source  => "puppet:///modules/ganglia/gmetric/gmetric_accounts.rb",    
      owner   => root, 
      group   => root,
      mode    => 755,     
      require => File["/etc/ganglia/gmetric"]
  }
  cron {
    "ganglia_mysql_stats":
      user    => vagrant,
      minute  => "*",
      command => "/etc/ganglia/gmetric/ganglia_mysql_stats.pl",
      require => File["/etc/ganglia/gmetric/ganglia_mysql_stats.pl"];
    "gmetric_accounts":
      user    => vagrant,
      minute  => "*",
      command => "/etc/ganglia/gmetric/gmetric_accounts.rb",
      require => File["/etc/ganglia/gmetric/gmetric_accounts.rb"]
  }
}

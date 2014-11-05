    "/etc/nagios3/conf.d":
      source  => "puppet:///modules/nagios/conf.d/",
      ensure  => directory,
      owner   => nagios,
      group   => nagios,
      mode    => 0644,
      recurse => true,
      notify  => Service["nagios3"],
      require => Package["nagios3"];
    "/etc/nagios3/conf.d/localhost_nagios2.cfg":
      ensure  => absent;

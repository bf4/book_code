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

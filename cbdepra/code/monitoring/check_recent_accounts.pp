   "/usr/lib/nagios/plugins/check_recent_accounts":
      source  => "puppet:///modules/nagios/plugins/check_recent_accounts",
      owner   => nagios,
      group   => nagios,
      mode    => 755;


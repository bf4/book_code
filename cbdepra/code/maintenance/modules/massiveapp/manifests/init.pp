class massiveapp {
  
  $current_path = "/var/massiveapp/current"

  file {
    "/etc/logrotate.d/massiveapp.conf":
      owner   => root,
      group   => root,
      mode    => 755,
      content => template("massiveapp/massiveapp.logrotate.conf.erb")
  }

  cron {
    "massiveapp_logrotate":
      command => "/usr/bin/logrotate -f /etc/logrotate.d/massiveapp.conf",
      user    => "vagrant",
      hour    => [0,12],
      minute  => "0"
  }

}


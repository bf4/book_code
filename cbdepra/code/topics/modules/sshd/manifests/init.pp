class ssh {
  package {
    "ssh":
      ensure => present,
      before => File["/etc/ssh/sshd_config"]
  }
  file {
    "/etc/ssh/sshd_config":
      owner   => root,
      group   => root,
      mode    => 644,
      source  => "puppet:///modules/ssh/sshd_config"
  }
  service {
    "ssh":
      ensure    => true,
      enable    => true,
      subscribe => File["/etc/ssh/sshd_config"]
  }
}


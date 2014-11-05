node "basenode" {
  package {
    ["lsof"]:
      ensure => installed
  }
  include ssh
}

node "app" inherits basenode {
  include apache2
  include massiveapp
  include memcached
  include mysql
  include passenger
  include nagios::client
}

node "nagios" inherits basenode {
  include apache2
  include nagios::server
}

node "ganglia" {
  include ganglia::server
} 


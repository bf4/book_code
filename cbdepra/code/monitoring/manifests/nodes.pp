node "app" inherits basenode {
  include apache2
  include massiveapp
  include memcached
  include mysql
  include nagios::client
  include passenger
}
node "nagios" {
  include apache2
  include nagios::server
}


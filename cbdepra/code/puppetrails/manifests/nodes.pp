node "app" {
  include apache2
  include mysql
  include massiveapp
  include passenger
}


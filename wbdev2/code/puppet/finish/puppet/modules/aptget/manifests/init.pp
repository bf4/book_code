class aptget {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update --fix-missing',
    timeout => 0
    }
  Exec["apt-get update"] -> Package <| |>
}

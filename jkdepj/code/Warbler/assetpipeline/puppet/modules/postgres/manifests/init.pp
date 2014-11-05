# START:class_postgres
class postgres {
  package { 'postgresql':
    ensure => present,
  }

  user { 'postgres':
    ensure => 'present',
    require => Package['postgresql']
  }

  group { 'postgres':
    ensure => 'present',
    require => User['postgres']
  }
  # END:class_postgres

  # START:createuser
  exec { "createuser" :
    command => "createuser -U postgres -SdRw vagrant",
    user   => 'postgres',
    path   => $path,
    unless => "psql -c \
      \"select * from pg_user where usename='vagrant'\" | grep -c vagrant",
    require => Group['postgres']
  }

  exec { "psql -c \"ALTER USER vagrant WITH PASSWORD 'Passw0rd'\"":
    user   => 'postgres',
    path   => $path,
    require => Exec["createuser"]
  }
  # END:createuser
# START:class_postgres
}
# END:class_postgres

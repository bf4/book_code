# START:group_puppet
group { "puppet":
    ensure => "present",
}
# END:group_puppet

# START:apt_update
exec { "apt-update" :
  command => "/usr/bin/apt-get update",
  require => Group[puppet]
}
Exec["apt-update"] -> Package <| |>
# END:apt_update

# START:package_jdk
package { "openjdk-6-jdk" :
  ensure => present
}
# END:package_jdk

# START:include_apache
include apache2
# END:include_apache
# START:include_postgres
include postgres
# END:include_postgres
# START:include_torquebox
include torquebox
# END:include_torquebox


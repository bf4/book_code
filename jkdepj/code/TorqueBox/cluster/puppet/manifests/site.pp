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

include torquebox

# START:master_node
node "master" {
  include apache2
  include postgres
}
# END:master_node

# START:slave_node
node "slave" {

}
# END:slave_node
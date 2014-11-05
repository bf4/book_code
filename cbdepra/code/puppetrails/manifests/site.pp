Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
}

# START:apacheinclude
include apache2
# END:apacheinclude

#START:apachepackage
  package {
    "apache2":
      ensure => present
  }
#END:apachepackage
#START:apacheservice
  service {
    "apache2":
      ensure => true,
      enable => true
  }
#END:apacheservice
#START:apachefile
  file {
    "/etc/apache2/apache2.conf":
      source => "puppet:///modules/apache2/apache2.conf",
      mode   => 644,
      owner  => root,
      group  => root
  }
#END:apachefile

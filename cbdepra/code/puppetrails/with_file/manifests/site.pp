Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
}
package {
  "apache2":
     ensure => present
}
service {
  "apache2":
    ensure => true,
    enable => true
}
file {
  "/etc/apache2/apache2.conf":
    source => "puppet:///modules/apache2/apache2.conf",
    mode   => 644,
    owner  => root,
    group  => root
}

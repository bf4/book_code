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

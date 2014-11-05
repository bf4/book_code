class apache2 {
  package { "apache2":
    ensure => present,
  }

  service { "apache2":
    ensure => running,
    require => Package["apache2"],
  }

  #exec { "download_mod_cluster":
  #  command => "wget -O /tmp/mod_cluster.tar.gz http://downloads.jboss.org/mod_cluster//1.1.3.Final/mod_cluster-1.1.3.Final-linux2-x86-ssl.tar.gz",
  #  path => $path,
  #  creates => "/tmp/mod_cluster.tar.gz",
  #  require => Package["openjdk-6-jdk"]
  #}

  #exec { "unpack_mod_cluster" :
  #  command => "tar -zxf /tmp/mod_cluster.tar.gz -C /tmp/mod_cluster",
  #  path => $path,
  #  creates => "/tmp/mod_cluster",
  #  require => Exec["download_mod_cluster"]
  #}

  # cp .so /usr/lib/apache2/modules/
  #exec { "cp_mod_cluster_libs" :
  #  command => "cp ./mod_advertise.so  ./mod_manager.so  ./mod_proxy_cluster.so  ./mod_slotmem.so  /usr/lib/apache2/modules/",
  #  cwd => "/tmp/mod_cluster/opt/jboss/https/libs/https/modules",
  #  path => $path,
  #  creates => "/usr/lib/apache2/modules/mod_proxy_cluster.so",
  #  require => Exec["unpack_mod_cluster"]
  #}

  # create files in /etc/apache2/mods-available
  #  mod_cluster.load
  #  mod_cluster.conf
}
# START:class_jruby
class jruby {
  $jruby_home = "/opt/jruby"
  # END:class_jruby

  # START:download_jruby
  exec { "download_jruby":
    command => "wget -O /tmp/jruby.tar.gz http://bit.ly/jruby-167",
    path => $path,
    unless => "ls /opt | grep jruby-1.6.7",
    require => Package["openjdk-6-jdk"]
  }
  # END:download_jruby

  # START:unpack_jruby
  exec { "unpack_jruby" :
    command => "tar -zxf /tmp/jruby.tar.gz -C /opt",
    path => $path,
    creates => "${jruby_home}-1.6.7",
    require => Exec["download_jruby"]
  }
  # END:unpack_jruby

  # START:file_jruby_home
  file { $jruby_home :
      ensure => link,
      target => "${jruby_home}-1.6.7",
      require => Exec["unpack_jruby"]
  }
  # END:file_jruby_home
  # START:class_jruby
}
# END:class_jruby

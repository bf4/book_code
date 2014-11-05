# START:base
class torquebox {

# END:base
  # START:tb_home
  $tb_home = "/opt/torquebox"
  $tb_version = "2.0.2"
  # END:tb_home

  # START:unzip
  package { unzip:
    ensure => present
  }
  # END:unzip

  # START:download_tb
  exec { "download_tb":
    command => "wget -O /tmp/torquebox.zip http://bit.ly/torquebox-2_0_2",
    path => $path,
    unless => "ls /opt | grep torquebox-${tb_version}",
    require => Package["openjdk-6-jdk"]
  }
  # END:download_tb

  # START:unpack_tb
  exec { "unpack_tb" :
    command => "unzip /home/vagrant/shared/torquebox-dist-bin.zip -d /opt",
    path => $path,
    creates => "${tb_home}-${tb_version}",
    require => Package[unzip] #[Exec["download_tb"], Package[unzip]]
  }
  # END:unpack_tb

  # START:symlink_tb
  file { $tb_home:
      ensure => link,
      target => "${tb_home}-${tb_version}",
      require => Exec["unpack_tb"]
  }
  # END:symlink_tb

  # START:tb_user
  user { "torquebox":
    ensure => present,
    managehome => true,
    system => true
  }
  # END:tb_user

  # START:copy_ssh_key
  exec { copy_ssh_key :
    command => "cp -R /home/vagrant/.ssh /home/torquebox/.ssh",
    path => $path,
    creates => "/home/torquebox/.ssh",
    require => User[torquebox]
  }

  file { "/home/torquebox/.ssh":
    ensure => directory,
    owner => torquebox,
    group => torquebox,
    recurse => true,
    require => Exec[copy_ssh_key]
  }
  # END:copy_ssh_key

  # START:chown_tb_home
  exec { "chown_tb_home":
      command => "chown -RH torquebox:torquebox ${tb_home}",
      path => $path,
      require => [File[$tb_home], User[torquebox]]
  }
  # END:chown_tb_home

  # START:upstart_install
  exec { "upstart_install":
      cwd => $tb_home,
      command => "${tb_home}/jruby/bin/jruby -S rake torquebox:upstart:install",
      environment => ["JBOSS_HOME=${tb_home}/jboss", "TORQUEBOX_HOME=${tb_home}",
                      'SERVER_OPTS="-b=0.0.0.0 --server-config=standalone-ha.xml"'],
      creates => "/etc/init/torquebox.conf",
      require => [File[$tb_home], User["torquebox"]]
  }
  # END:upstart_install

  # START:upstart_start
  exec { "upstart_start":
      cwd => $tb_home,
      command => "${tb_home}/jruby/bin/jruby -S rake torquebox:upstart:start",
      environment => ["JBOSS_HOME=${tb_home}/jboss", "TORQUEBOX_HOME=${tb_home}"],
      require => Exec["upstart_install"]
  }
  # END:upstart_start

  exec { install_backstage_gem:
    command => "${tb_home}/jruby/bin/jruby -S gem install torquebox-backstage --pre",
    user => torquebox,
    creates => "${tb_home}/jruby/bin/backstage",
    require => Exec[upstart_start]
  }

  exec { deploy_backstage:
    command => "${tb_home}/jruby/bin/jruby -S backstage deploy",
    user => torquebox,
    environment => "TORQUEBOX_HOME=${tb_home}",
    require => Exec[install_backstage_gem]
  }

  # START:base
}
# END:base

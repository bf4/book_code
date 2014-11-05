# START:trinidad_class
class trinidad {
  $jruby_home = "/opt/jruby"
  $trinidad_home = "/opt/trinidad"
  # END:trinidad_class

  # START:install_jsvc
  package { jsvc :
    ensure => present
  }
  # END:install_jsvc

  # START:install_trinidad_gem
  exec {  install_trinidad :
    command => "jruby -S gem install trinidad -v 1.3.4",
    path    => "${jruby_home}/bin:${path}",
    creates => "${jruby_home}/bin/trinidad",
    require => File[$jruby_home]
  }
  # END:install_trinidad_gem

  # START:install_trinidad_init_services_gem
  exec {  install_trinidad_init_services :
    command => "jruby -S gem install trinidad_init_services -v 1.1.3",
    path    => "${jruby_home}/bin:${path}",
    creates => "${jruby_home}/bin/trinidad_init_service",
    require => [Package[jsvc], Exec[install_trinidad], File[$jruby_home]]
  }
  # END:install_trinidad_init_services_gem

  # START:create_trinidad_home
  file { $trinidad_home :
    owner => vagrant,
    ensure => directory
  }
  # END:create_trinidad_home

  # START:template_trinidad_config
  file { "${trinidad_home}/trinidad_config.yml":
    content => template("trinidad/trinidad_config.yml.erb"),
    require => Exec[install_trinidad_init_services]
  }
  # END:template_trinidad_config

  # START:trinidad_init_service
  exec { trinidad_init_service :
    command => "jruby -S trinidad_init_service ${trinidad_home}/trinidad_config.yml",
    path    => "${jruby_home}/bin:${path}",
    creates => "/etc/init.d/trinidad",
    require => File["${trinidad_home}/trinidad_config.yml", $jruby_home]
  }
  # END:trinidad_init_service

  # START:chown
  file { "${trinidad_home}/shared" :
    owner => vagrant,
    ensure => directory,
    recurse => true,
    require => Exec[trinidad_init_service]
  }

  file { "/etc/init.d/trinidad" :
    owner => "vagrant",
    require => Exec[trinidad_init_service]
  }
  # END:chown

# START:trinidad_class
}
# END:trinidad_class
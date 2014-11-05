class git {
  package { "git-core":
    ensure => "present"
  }
}

define git::clone( $path, $source ){
  exec { "git_clone_${name}":
    command => "git clone ${source} ${path}",
    creates => "${path}/.git",
    user => $username,
    require => Package[git-core],
    timeout => 600
  }
}

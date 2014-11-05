class rvm {
  exec { 'install_rvm':
    command  => "${as_vagrant} 'curl -L https://get.rvm.io | bash -s stable'",
    creates  => "${home}/.rvm"
  }
}

define rvm::install_ruby(
  $version='1.9.3'
) {
  exec { 'install_ruby':
    command => "${as_vagrant} '${home}/.rvm/bin/rvm reinstall ${version} \
      --latest-binary && rvm --fuzzy alias create default ${version}'",
    creates => "${home}/.rvm/bin/ruby",
    require => Exec['install_rvm']
  }
}

define rvm::install_bundler() {
  exec { "${as_vagrant} 'gem install bundler --no-rdoc --no-ri'":
    creates => "${home}/.rvm/bin/bundle",
    require => Exec['install_ruby']
  }
}

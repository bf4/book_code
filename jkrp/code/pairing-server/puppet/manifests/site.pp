case $::virtual {
  'virtualbox' : {
    $username = "vagrant"
  }
  default : {
    $username = "ubuntu"
  }
}

if (!$username) {
$username     = "vagrant"
}
$home         = "/home/${username}"
$app_name     = "fulcrum"
$app_dir      = "${home}/${app_name}"

Exec {
  path => ['/usr/sbin', '/usr/bin', '/usr/local/bin', '/sbin', '/bin']
}

stage { 'preinstall':
  before => Stage['main']
}

class prepare {
  exec { 'apt-get -y update':
    unless => "test -e ${app_dir}"
  }

  package { ['build-essential', 'curl', 'autoconf', 'libgdbm-dev', 
  'automake', 'libtool', 'bison', 'pkg-config', 'libffi-dev', 
  'libyaml-dev', 'libncurses5-dev', 'libxml2', 'libxml2-dev', 
  'libxslt1-dev', 'libqt4-dev', 'postgresql-server-dev-9.1', 
  'nodejs', 'libreadline6-dev', 'libssl-dev', 'zlib1g-dev']:
    ensure  => installed,
    require => Exec['apt-get -y update']
  }
}
class { 'prepare':
  stage => preinstall
}

package { ["ruby1.9.1", "ruby1.9.1-dev", "rubygems1.9.1", "irb1.9.1", 
  "libopenssl-ruby1.9.1", "sqlite3", "libsqlite3-dev", "tmux", "xvfb", 
  "firefox"]:
    ensure => installed
}

include git
git::clone { $app_name :
  path   => $app_dir,
  source => "git://github.com/malclocke/fulcrum.git"
}

exec {"install_bundler":
  command => "gem install bundler",
  require => Package['ruby1.9.1', 'rubygems1.9.1']
}

exec { "bundle" :
  command => "su ${username} -c 'bundle install'",
  cwd      => $app_dir,
  require  => [Git::Clone[$app_name], Exec['install_bundler']]
}

define fulcrum::setup() {
 exec { "fulcrum-setup-${name}":
    command     => "bundle exec rake fulcrum:setup db:setup", 
    cwd         => $app_dir,
    environment => "RAILS_ENV=${name}",
    require     => Exec["bundle"],
    user        => $username
  }
}

fulcrum::setup{"development": ;}
fulcrum::setup{"test": ;}

Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}
# install php stack
class dev_box {
  exec { 'apt_update':
    command => 'apt-get -y update',
    unless  => "test -e ${::home}/.rvm"
  }

  Package {
    ensure => 'installed'
  }

  $enhancements = ['language-pack-da', 'php5', 'nodejs', 'mc', 'git']

  package { 'enhancements':
    name => $enhancements
  }

  file { 'var_www':
    ensure  => 'link',
    path    => '/var/www',
    target  => '/vagrant',
    force   => true,
  }
  Exec['apt_update'] -> Package['enhancements'] -> File['var_www']
}
# add config php
define phpconf ( $content, $filename = $title) {
  file { $filename:
    ensure  => present,
    path    => "/etc/php5/mods-available/${filename}",
    owner   => root,
    group   => root,
    mode    => '0444',
    content => $content,
  }

  file { 'etc_php5_cli':
    ensure  => 'link',
    path    => "/etc/php5/cli/conf.d/30-${filename}",
    target  => "/etc/php5/mods-available/${filename}",
    force   => true,
  }

  file { 'etc_php5_apache2':
    ensure  => 'link',
    path    => "/etc/php5/apache2/conf.d/30-${filename}",
    target  => "/etc/php5/mods-available/${filename}",
    force   => true,
  }
  File[$filename] -> File['etc_php5_cli'] -> File['etc_php5_apache2']
}

class {'dev_box':
  stage => 'main'
} ->
phpconf { 'phar.ini':
  content   => "phar.readonly = off \n"
}

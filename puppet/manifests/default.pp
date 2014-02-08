Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

# --- Preinstall Stage ---------------------------------------------------------


class dev_box {

  exec { 'apt_update':
    command => 'apt-get -y update',
    unless => "test -e ${home}/.rvm"
  }

  package { 'language-pack-da':
    ensure => installed
  }

  file { 'var_www':
    path =>'/var/www',
    ensure => 'link',
    target => '/vagrant',
    force => true,
  }
 
  file {'/etc/php5/conf.d/mods-unavalable':
 	 ensure => present,
  	 owner => root, group => root, mode => 444,
  	content => "phar.readonly = off \n",
}
  
  package { 'php5':
    ensure => installed
  }

  package { 'nodejs':
    ensure => installed
  }
  
  Exec['apt_update']->File['var_www']->Package['language-pack-da']->Package['php5']->Package['nodejs']
}

class { 'dev_box' :
  stage => 'main',
}



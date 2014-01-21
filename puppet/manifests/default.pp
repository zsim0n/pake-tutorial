Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

# --- Preinstall Stage ---------------------------------------------------------

stage { 'pre': before => Stage['main'] }

class run_pre {

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
  
  package { 'php5':
    ensure => installed
  }

  package { 'nodejs':
    ensure => installed
  }
  
  Exec['apt_update']->File['var_www']->Package['language-pack-da']->Package['php5']->Package['nodejs']
}

class { 'run_pre' :
  stage => 'pre',
}



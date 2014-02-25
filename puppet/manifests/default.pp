Exec {
    path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

class dev_box {

    exec {
        'apt_update': command => 'apt-get -y update',
        unless => "test -e ${home}/.rvm"
    }

    Package {
        ensure => "installed"
    }

    $enhancements = ["language-pack-da", "php5", "nodejs", "mc", "git"]

    package {
        'enhancements': name => $enhancements
    }

    file {
        'var_www': path => '/var/www',
        ensure => 'link',
        target => '/vagrant',
        force => true,
    }
    Exec['apt_update'] -> Package['enhancements'] -> File['var_www']
}

class add_php_ini($filename, $content) {
    file {
        'ini_file': path => "/etc/php5/mods-available/${filename}",
        ensure => present,
        owner => root,
        group => root,
        mode => 444,
        content => $content,
    }

    define phpsymlink {
        file {
            $etc_path: path => "${etc_path}/conf.d/30-${filename}",
            target => '/etc/php5/mods-available/${filename}',
            ensure => 'link',
            force => true,
        }

        File['ini_file'] -> Phpsymlink{['/etc/php5/cli', '/etc/php5/apache2']}
    }
}


class {'dev_box': stage => 'main'} ->
class {'add_php_ini': 
            filename => 'phar.ini',
            content => "phar.readonly = off \n"
}
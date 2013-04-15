class patience::nginx {

  package { "nginx": 
    ensure => present 
  }

  service { "nginx": 
    ensure => running 
  }

  file {"logfile":
    path    => "/var/log/nginx/patience.access.log",
    ensure  => present,
    mode    => 0644,
  }

  file {"unwanted-default":
    path    => "/etc/nginx/sites-enabled/default",
    ensure  => absent,
  }

  file {"patience-avaliable":
    path    => "/etc/nginx/sites-available/patience",
    ensure  => present,
    mode    => 0644,
    source  => "puppet:///modules/patience/static/patience",
    require => File["logfile", "unwanted-default"],
    notify  => Service["nginx"],
  }

  file {"patience-enabled":
    path    => "/etc/nginx/sites-enabled/patience",
    ensure  => link,
    mode    => 0644,
    target  => "/etc/nginx/sites-available/patience",
    require => File["patience-avaliable"],
  }


}
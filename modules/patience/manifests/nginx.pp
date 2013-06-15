class patience::nginx {

  package { "nginx": 
    ensure => present 
  }

  service { "nginx": 
    ensure => running 
  }

  file { "logfile1":
    path    => "/var/log/nginx/patience.access.log",
    ensure  => present,
    mode    => 0644,
  }

  file { "logfile2":
    path    => "/var/log/nginx/js-ncr.access.log",
    ensure  => present,
    mode    => 0644,
  }

  file { "unwanted-default":
    path    => "/etc/nginx/sites-enabled/default",
    ensure  => absent,
  }

  file { "patience-avaliable":
    path    => "/etc/nginx/sites-available/patience",
    ensure  => present,
    mode    => 0644,
    source  => "puppet:///modules/patience/static/patience",
    require => File["logfile1", "unwanted-default"],
    notify  => Service["nginx"],
  }

  file { "patience-enabled":
    path    => "/etc/nginx/sites-enabled/patience",
    ensure  => link,
    mode    => 0644,
    target  => "/etc/nginx/sites-available/patience",
    require => File["patience-avaliable"],
  }

  file { "ncrjs-avaliable":
    path    => "/etc/nginx/sites-available/ncr-js",
    ensure  => present,
    mode    => 0644,
    source  => "puppet:///modules/patience/static/ncr-js",
    require => File["logfile2", "patience-enabled"],
    notify  => Service["nginx"],
  }

  file { "ncrjs-enabled":
    path    => "/etc/nginx/sites-enabled/ncr-js",
    ensure  => link,
    mode    => 0644,
    target  => "/etc/nginx/sites-available/ncr-js",
    require => File["ncrjs-avaliable"],
  }


}
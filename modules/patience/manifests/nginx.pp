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

  file { "jsncr-avaliable":
    path    => "/etc/nginx/sites-available/js-ncr",
    ensure  => present,
    mode    => 0644,
    source  => "puppet:///modules/patience/static/js-ncr",
    require => File["logfile2", "patience-enabled"],
    notify  => Service["nginx"],
  }

  file { "jsncr-enabled":
    path    => "/etc/nginx/sites-enabled/js-ncr",
    ensure  => link,
    mode    => 0644,
    target  => "/etc/nginx/sites-available/js-ncr",
    require => File["js-ncr-avaliable"],
  }


}
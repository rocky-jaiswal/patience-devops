class patience::nginx {
  
  include stdlib
  include apt

  apt::ppa { "ppa:nginx/stable": 
    before  => Package["nginx"],
  }

  package { "python-software-properties": 
    ensure => latest 
  }

  package { "nginx": 
    ensure => latest,
    require => Package["python-software-properties"],
    before => File["logfile1", "logfile2"]
  }

  service { "nginx": 
    ensure => running,
    require => Package["nginx"]
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

  file { "logfile3":
    path    => "/var/log/nginx/crm-ng.access.log",
    ensure  => present,
    mode    => 0644,
  }

  file { "logfile4":
    path    => "/var/log/nginx/graceeducomp.access.log",
    ensure  => present,
    mode    => 0644,
  }

  file { "unwanted-default":
    path    => "/etc/nginx/sites-enabled/default",
    ensure  => absent,
    before => File["patience-avaliable"]
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

  file { "js-ncr-avaliable":
    path    => "/etc/nginx/sites-available/js-ncr",
    ensure  => present,
    mode    => 0644,
    source  => "puppet:///modules/patience/static/js-ncr",
    require => File["logfile2", "unwanted-default"],
    notify  => Service["nginx"],
  }

  file { "js-ncr-enabled":
    path    => "/etc/nginx/sites-enabled/js-ncr",
    ensure  => link,
    mode    => 0644,
    target  => "/etc/nginx/sites-available/js-ncr",
    require => File["js-ncr-avaliable"],
  }

  file { "crm-ng-avaliable":
    path    => "/etc/nginx/sites-available/crm-ng",
    ensure  => present,
    mode    => 0644,
    source  => "puppet:///modules/patience/static/crm-ng",
    require => File["logfile3", "unwanted-default"],
    notify  => Service["nginx"],
  }

  file { "crm-ng-enabled":
    path    => "/etc/nginx/sites-enabled/crm-ng",
    ensure  => link,
    mode    => 0644,
    target  => "/etc/nginx/sites-available/crm-ng",
    require => File["crm-ng-avaliable"],
  }

  file { "graceeducomp-avaliable":
    path    => "/etc/nginx/sites-available/graceeducomp",
    ensure  => present,
    mode    => 0644,
    source  => "puppet:///modules/patience/static/graceeducomp",
    require => File["logfile4", "unwanted-default"],
    notify  => Service["nginx"],
  }

  file { "graceeducomp-enabled":
    path    => "/etc/nginx/sites-enabled/graceeducomp",
    ensure  => link,
    mode    => 0644,
    target  => "/etc/nginx/sites-available/graceeducomp",
    require => File["graceeducomp-avaliable"],
  }

}
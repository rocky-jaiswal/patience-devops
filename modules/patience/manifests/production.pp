class patience::production {

  include patience::nginx

  Exec {
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
  }

  user { "deploy":
    comment => "Dashboad User",
    home    => "/home/deploy",
    ensure  => present,
    gid     => "www-data",
    shell   => "/bin/bash",
    managehome   => true,
  }

  file { "home":
    path    => "/home/deploy",
    ensure  =>  directory,
    owner   => "deploy",
    group   => "www-data",
    require => User["deploy"],
  }

  file { "app":
    path    => "/home/deploy/patience",
    ensure  =>  directory,
    owner   => "deploy",
    group   => "www-data",
    recurse => true,
    require => File["home"],
  }

}

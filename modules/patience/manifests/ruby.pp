class rockyj::ruby {
  
  include stdlib
  include apt

  apt::ppa { "ppa:brightbox/ruby-ng": 
    before  => Package["ruby1.9.3"],
  }

  package { "libxml2-dev":
    ensure => latest,
    before  => Package["ruby1.9.3"],
  }

  package { "libxslt-dev":
    ensure => latest,
    before  => Package["ruby1.9.3"],
  }

  package { "build-essential":
    ensure => latest,
    before  => Package["ruby1.9.3"],
  }

  package { "ruby1.9.3": 
    ensure => latest,
    require => Package["python-software-properties"]
  }

}
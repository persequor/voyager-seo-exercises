class packages {
  Package { ensure => 'installed' }

  package { 'vim': }
  package { 'curl': }
  package { 'git':   }

}
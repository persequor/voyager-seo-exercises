class exercise {
	Package { ensure => 'installed' }
	package { 'vim': }
	package { 'curl': }
	package { 'git':   }
 
	user { 'monitor':
		ensure => 'present',
		home    => '/home/monitor',
		shell   => '/bin/bash',
	}

}
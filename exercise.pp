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
	file { '/home/monitor/scripts':
		ensure => 'directory',
	}
	exec{'retrieve_leiningen':
		command => "/usr/bin/wget -q https://rawgit.com/persequor/voyager-seo-exercises/master/memory_check.sh -O /home/monitor/scripts/memory_check",
		creates => "/home/monitor/scripts/memory_check",
	}

}
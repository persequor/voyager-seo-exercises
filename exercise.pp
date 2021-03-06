class exercise {
	Package { ensure => 'installed' }
	package { 'vim': }
	package { 'curl': }
	package { 'git':   }
 
	user { 'monitor':
		ensure => 'present',
		home   => '/home/monitor',
		shell  => '/bin/bash',
	}
	file { '/home/monitor/scripts':
		ensure => 'directory',
	}
	exec {'retrieve_memcheck':
		command => "/usr/bin/wget -q https://rawgit.com/persequor/voyager-seo-exercises/master/memory_check.sh -O /home/monitor/scripts/memory_check",
		creates => "/home/monitor/scripts/memory_check",
	}
	
	file { '/home/monitor/src':
		ensure => 'directory',
	}
	file { '/home/monitor/src/my_memory_check':
		ensure => 'link',
		target => 'home/monitor/scripts/memory_check',
	}
	cron { 'check':
		command => '/home/monitor/src/my_memory_check',
		minute	=> '*/10'
	}
}
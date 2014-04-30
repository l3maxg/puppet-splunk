$splunk_ver = '6.0.3-204106-linux-2.6-amd64'

package { 'splunk':
  source   => "/vagrant/files/splunk-${splunk_ver}.deb",
  provider => dpkg,
  notify => Service['splunk'],
} ->

file { '/etc/init/splunk.conf':
  source => "/vagrant/files/splunk.init",
  owner => root,
  group => root,
  mode  => 0600,
} ->

service { 'splunk':
  ensure  => running
}

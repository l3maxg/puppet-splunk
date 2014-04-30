$splunk_ver = '6.0.3-204106-linux-2.6-amd64'
$bin_path = '/opt/splunkforwarder/bin'

package { 'splunk':
  source   => "/vagrant/sw/splunkforwarder-${splunk_ver}.deb",
  provider => dpkg,
  notify => Service['splunk'],
} ->

file { '/etc/init/splunk.conf':
  content => template("/vagrant/templates/splunk.init"),
  owner => root,
  group => root,
  mode  => 0600,
} ->

service { 'splunk':
  ensure  => running
}

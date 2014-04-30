$splunk_ver = '6.0.3-204106-linux-2.6-amd64'
$splunk_root = '/opt/splunkforwarder'

package { 'splunk':
  source   => "/vagrant/sw/splunkforwarder-${splunk_ver}.deb",
  provider => dpkg,
  notify => Service['splunk'],
} ->

file { "${splunk_root}/etc/system/local/inputs.conf":
  source => "/vagrant/files/client/inputs.conf",
  owner => root,
  group => root,
  mode  => 0600,
} ->

file { "${splunk_root}/etc/system/local/outputs.conf":
  source => "/vagrant/files/client/outputs.conf",
  owner => root,
  group => root,
  mode  => 0600,
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

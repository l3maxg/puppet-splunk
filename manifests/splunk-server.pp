$splunk_ver = '6.0.3-204106-linux-2.6-amd64'
$splunk_root = '/opt/splunk'

package { 'splunk':
  source => "/vagrant/sw/splunk-${splunk_ver}.deb",
  provider => dpkg,
  notify => Service['splunk'],
} ->

file { "${splunk_root}/etc/system/local/inputs.conf":
  source => "/vagrant/files/server/inputs.conf",
  owner => root,
  group => root,
  mode  => 0600,
} ->

file { "${splunk_root}/etc/system/local/props.conf":
  source => "/vagrant/files/server/props.conf",
  owner => root,
  group => root,
  mode  => 0600,
} ->

file { "${splunk_root}/etc/system/local/transforms.conf":
  source => "/vagrant/files/server/transforms.conf",
  owner => root,
  group => root,
  mode  => 0600,
} ->

file { '/etc/init/splunk.conf':
  content => template('/vagrant/templates/splunk.init'),
  owner => root,
  group => root,
  mode  => 0600,
} ->

service { 'splunk':
  ensure  => running
}

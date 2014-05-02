$splunk_ver = '6.0.3-204106-linux-2.6-amd64'
$splunk_root = '/opt/splunkforwarder'

exec { 'download splunk client':
  command => "/usr/bin/wget -O /vagrant/sw/splunkforwarder-${splunk_ver}.deb \'http://www.splunk.com/page/download_track?file=6.0.3/universalforwarder/linux/splunkforwarder-6.0.3-204106-linux-2.6-amd64.deb&ac=&wget=true&name=wget&platform=Linux&architecture=x86_64&version=6.0.3&product=splunk&typed=release\'",
  creates => "/vagrant/sw/splunkforwarder-${splunk_ver}.deb"
} ->
package { 'splunkforwarder':
  source   => "/vagrant/sw/splunkforwarder-${splunk_ver}.deb",
  provider => dpkg,
  notify => Service['splunk'],
} ->

file { "${splunk_root}/etc/system/local/inputs.conf":
  source => "/vagrant/files/client/inputs.conf",
  owner  => root,
  group  => root,
  mode   => 0600,
  notify => Service['splunk'],
} ->

file { "${splunk_root}/etc/system/local/outputs.conf":
  source => "/vagrant/files/client/outputs.conf",
  owner => root,
  group => root,
  mode  => 0600,
  notify => Service['splunk'],
} ->

exec { 'create splunk init.d':
  command => "${splunk_root}/bin/splunk enable boot-start --accept-license",
  creates => '/etc/init.d/splunk',
} ->

service { 'splunk':
  ensure   => running,
  provider => init,
}

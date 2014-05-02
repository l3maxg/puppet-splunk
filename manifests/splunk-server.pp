$splunk_ver = '6.0.3-204106-linux-2.6-amd64'
$splunk_root = '/opt/splunk'

exec { 'download splunk server':
  command => "/usr/bin/sudo /usr/bin/wget -O /vagrant/sw/splunk-${splunk_ver}.deb \'http://www.splunk.com/page/download_track?file=6.0.3/splunk/linux/splunk-${splunk_ver}.deb&ac=&wget=true&name=wget&platform=Linux&architecture=x86_64&version=6.0.3&product=splunkd&typed=release\'",
  creates => "/vagrant/sw/splunk-${splunk_ver}.deb",
} ->
package { 'splunk':
  source => "/vagrant/sw/splunk-${splunk_ver}.deb",
  provider => dpkg,
  notify => Service['splunk'],
} ->

file { "${splunk_root}/etc/system/local/inputs.conf":
  source => "/vagrant/files/server/inputs.conf",
  owner  => root,
  group  => root,
  mode   => 0600,
  notify => Service['splunk'],
} ->

file { "${splunk_root}/etc/system/local/props.conf":
  source => "/vagrant/files/server/props.conf",
  owner => root,
  group => root,
  mode  => 0600,
  notify => Service['splunk'],
} ->

file { "${splunk_root}/etc/system/local/transforms.conf":
  source => "/vagrant/files/server/transforms.conf",
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

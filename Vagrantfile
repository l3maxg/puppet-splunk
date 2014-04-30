# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

INTERNAL_IPS = {
  :server => '192.168.99.101',
  :client => '192.168.99.102',
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", 1024]
  end

  machines = {
    'splunk-server' => '192.168.99.2',
    'splunk-client' => '192.168.99.3',
  }

  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.auto_detect = true
  end

  machines.each do |role, ip|
    config.vm.define role do |machine|
      machine.vm.hostname = "#{role}.vagrant"
      machine.vm.network :private_network, :ip => ip
      if Vagrant.has_plugin?('vagrant-hosts')
        machine.vm.provision :hosts do |provisioner|
          machines.each do |key, value|
            names = ["#{key}.vagrant", key]
            provisioner.add_host value, names
          end
          provisioner.add_host '::1', ['ip6-localhost', 'ip6-loopback', 'localhost']
          provisioner.add_host 'fe00::0', ['ip6-localnet']
          provisioner.add_host 'ff00::0', ['ip6-mcastprefix']
          provisioner.add_host 'ff02::1', ['ip6-allnodes']
          provisioner.add_host 'ff02::2', ['ip6-allrouters']
          provisioner.add_host 'ff02::3', ['ip6-allhosts']
        end
      end
      config.vm.provision "puppet" do |puppet|
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "#{role}.pp"
      end
    end
  end


end

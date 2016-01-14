# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "bento/centos-7.1"

  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = "./cookbooks/symfony/Berksfile"
  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "symfony"
  end
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.network "private_network", ip: "192.168.50.4"
end

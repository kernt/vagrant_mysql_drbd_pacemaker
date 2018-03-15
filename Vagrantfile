# -*- mode: ruby -*-
# vi: set ft=ruby :

# Copyright 2013 Zürcher Hochschule für Angewandte Wissenschaften
# All Rights Reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See thek
#    License for the specific language governing permissions and limitations
#    under the License.
#  Costumised by Tobias Kern <tkern@oshsl.de>
#############################################################################

#if Gem::Version.new(Vagrant::VERSION) < Gem::Version.new('1.5.0')
#  Vagrant.require_plugin 'vagrant-librarian-puppet' if defined? VagrantPlugins::AWS
#end

required_plugins = %w( vagrant-librarian-puppet )
required_plugins.each do |plugin|
  system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

Vagrant.require_version '>= 1.8.1'

# https://www.vagrantup.com/docs/provisioning/puppet_apply.html
Vagrant.configure("2") do |config|

 config.vm.define "grizzly1" do |grizzly1_config|

    grizzly1_config.vm.box = "hashicorp/precise64"
    grizzly1_config.vm.box_url = "http://files.vagrantup.com/precise64.box"

    grizzly1_config.vm.network :private_network, ip:  "10.1.2.44" 
    grizzly1_config.vm.network :private_network, ip: "192.168.22.11"
    grizzly1_config.vm.hostname = "grizzly1"
    grizzly1_config.vm.graceful_halt_timeout = "500"
    grizzly1_config.vm.network "forwarded_port", guest: 80, host: 8088
    grizzly1_config.vm.network "forwarded_port", guest: 22, host: 2223
    grizzly1_config.vm.provision :shell, :path => "prep.sh"

     grizzly1_config.vm.provision "puppet" do |grizzly1_puppet|
    	  grizzly1_puppet.temp_dir = "/tmp/vagrant-puppet"
    	  grizzly1_puppet.module_path = "modules"
    	  grizzly1_puppet.manifests_path = "manifests"
        grizzly1_puppet.manifest_file = "site1.pp"
        grizzly1_puppet.hiera_config_path = 'hiera.yaml'
        grizzly1_puppet.facter = { "fqdn" => "grizzly1" }
        #grizzly1_puppet.options = '--verbose --modulepath /vagrant/modules' 
    	 end

    #grizzly1_config.vm.provision :shell, :path => "script.sh"
    grizzly1_config.vm.provision :shell, :path => "lvm-setup.sh"
    grizzly1_config.vm.provision :shell, :path => "sshtunnel.sh"
    end

  config.vm.define "grizzly2" do |grizzly2_config|

    grizzly2_config.vm.box = "precise64_with_services"
    grizzly2_config.vm.box_url = "http://files.vagrantup.com/precise64.box"

    grizzly2_config.vm.network :private_network, ip:  "10.1.2.45"
    grizzly2_config.vm.network :private_network, ip: "192.168.22.12"
    grizzly2_config.vm.hostname = "grizzly2"
    grizzly2_config.vm.graceful_halt_timeout = "500"
    grizzly2_config.vm.post_up_message = "Now you can access the OpenStack-Dashboard with your web browser by tiping the URL http://192.168.22.11/horizon.
Login with user name admin and password admin_pass"
    grizzly2_config.vm.network "forwarded_port", guest: 80, host: 8089
    grizzly2_config.vm.network "forwarded_port", guest: 22, host: 2224

    grizzly2_config.vm.provision :shell, :path => "prep.sh"
    grizzly2_config.vm.provision "puppet" do |grizzly2_puppet|
      grizzly2_puppet.temp_dir = "/tmp/vagrant-puppet"
      grizzly2_puppet.module_path = "modules"
      grizzly2_puppet.manifests_path = "manifests"
      grizzly2_puppet.manifest_file = "site2.pp"
      grizzly2_puppet.hiera_config_path = 'hiera.yaml'
      grizzly2_puppet.facter = { "fqdn" => "grizzly2" }
    end

    grizzly2_config.vm.provision :shell, :path => "lvm-setup.sh"
    grizzly2_config.vm.provision :shell, :path => "sshtunnel.sh"
    grizzly2_config.vm.provision :shell, :path => "corosync-setup.sh"
    grizzly2_config.vm.provision :shell, :path => "drbd-setup.sh"
    grizzly2_config.vm.provision :shell, :path => "mysql_prep.sh"
    grizzly2_config.vm.provision :shell, :path => "pacemaker-prepare.sh"
  end
end
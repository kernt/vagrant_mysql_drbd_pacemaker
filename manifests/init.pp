node default {
  # Setup pre and post run stages
  # Typically these are only needed in special cases but are good to have
  stage { ['pre', 'post']: }
  Stage['pre'] -> Stage['main'] -> Stage['post']

  # Install text editors
  package { 'vim-enhanced': ensure => installed }
  package { 'emacs':        ensure => installed }
  	#ensure virtualbox-guest-dkms is installed
	package { 'virtualbox-guest-dkms':
		ensure 		=> 'present',
	}

  # Declare the Harvard class for a Harvard look and feel
  class { 'harvard': }

  # Install and run Apache with its default configuration
  class { 'apache':
    default_vhost => true,
    keepalive     => true,
  }
}

node /^grizzly1/ {

exec { "apt-update":
    command => "/usr/bin/apt-get update"
}

exec { "apt-upgrade":
	command => "/usr/bin/apt-get upgrade"
}



Exec["apt-update"] -> Package <| |>

	#ensure git is installed
	package { 'git':
		ensure 		=> 'present',
	}

	#ensure nano is installed
	package { 'nano':
		ensure 		=> 'present',
	}

	#ensure vim is installed
	package { 'vim':
		ensure 		=> 'present',
	}

	#ensure sshpass is installed
	package { 'sshpass':
		ensure 		=> 'present',
	}

	#ensure ceph-common is installed
	package { 'ceph-common':
		ensure 		=> 'present',
	}

	#ensure ubuntu is prepared
	package { 'ubuntu-cloud-keyring':
		ensure 		=> 'present',
	}
        package { 'python-software-properties':
		ensure 		=> 'present',
	}
        package { 'software-properties-common':
		ensure 		=> 'present',
	}
        package { 'python-keyring':
		ensure 		=> 'present',
	}

	#ensure mysql & rabbitmq are installed
	package { 'mysql-server':
		ensure 		=> 'present',
	}
	package { 'python-mysqldb':
		ensure 		=> 'present',
	}	
	package { 'rabbitmq-server':
		ensure 		=> 'present',
	}
	package { 'ntp':
		ensure 		=> 'present',
	}

	#ensure networking utils are installed
	package { 'vlan':
		ensure 		=> 'present',
	}
	package { 'bridge-utils':
		ensure 		=> 'present',
	}

	#ensure openstack services are installed
	package { 'keystone':
		ensure 		=> 'present',
	}

	package { 'glance':
		ensure 		=> 'present',
	}

	package { 'openvswitch-switch':
		ensure 		=> 'present',
	}
	package { 'openvswitch-datapath-dkms':
		ensure 		=> 'present',
	}
	package { 'quantum-plugin-linuxbridge':
		ensure 		=> 'present',
	}
	package { 'quantum-plugin-linuxbridge-agent':
		ensure 		=> 'present',
	}
	package { 'quantum-server':
		ensure 		=> 'present',
	}
	package { 'quantum-plugin-openvswitch':
		ensure 		=> 'present',
	}
	package { 'quantum-plugin-openvswitch-agent':
		ensure 		=> 'present',
	}
	package { 'dnsmasq':
		ensure 		=> 'present',
	}
	package { 'quantum-dhcp-agent':
		ensure 		=> 'present',
	}
	package { 'quantum-l3-agent':
		ensure 		=> 'present',
	}

	package { 'cpu-checker':
		ensure 		=> 'present',
	}
	package { 'qemu':
		ensure 		=> 'present',
	}
	package { 'kvm':
		ensure 		=> 'present',
	}
	package { 'libvirt-bin':
		ensure 		=> 'present',
	}
	package { 'pm-utils':
		ensure 		=> 'present',
	}

	package { 'nova-api':
		ensure 		=> 'present',
	}
	package { 'nova-cert':
		ensure 		=> 'present',
	}
	package { 'novnc':
		ensure 		=> 'present',
	}
	package { 'nova-consoleauth':
		ensure 		=> 'present',
	}
	package { 'nova-scheduler':
		ensure 		=> 'present',
	}
	package { 'nova-novncproxy':
		ensure 		=> 'present',
	}
	package { 'nova-doc':
		ensure 		=> 'present',
	}
	package { 'nova-conductor':
		ensure 		=> 'present',
	}
	package { 'nova-compute-kvm':
		ensure 		=> 'present',
	}

	package { 'cinder-api':
		ensure 		=> 'present',
	}
	package { 'cinder-scheduler':
		ensure 		=> 'present',
	}
	package { 'cinder-volume':
		ensure 		=> 'present',
	}

	package { 'iscsitarget':
		ensure 		=> 'present',
	}
	package { 'open-iscsi':
		ensure 		=> 'present',
	}
	package { 'open-iscsi-utils':
		ensure 		=> 'present',
	}
	package { 'iscsitarget-source':
		ensure 		=> 'present',
	}
	package { 'iscsitarget-dkms':
		ensure 		=> 'present',
	}

	package { 'openstack-dashboard':
		ensure 		=> 'present',
	}
	package { 'memcached':
		ensure 		=> 'present',
	}

        package { 'pacemaker':
		ensure 		=> 'present',
	}
        package { 'corosync':
		ensure 		=> 'present',
	}
        package { 'cluster-glue':
		ensure 		=> 'present',
	}
        package { 'fence-agents':
		ensure 		=> 'present',
	}
        package { 'resource-agents':
		ensure 		=> 'present',
	}

        package { 'python-keystone':
		ensure 		=> 'present',
	}
        package { 'python-keystoneclient':
		ensure 		=> 'present',
	}

	#ensure drbd8-utils is installed
	package { 'drbd8-utils':
		ensure 		=> 'present',
	}

	#ensure xfsprogs is installed
	package { 'xfsprogs':
		ensure 		=> 'present',
	}

#sudo apt-get install pacemaker corosync cluster-glue fence-agents resource-agents
	
#python-keystone python-keystoneclient
#sudo apt-get install glance glance-api glance-client glance-common glance-registry python-glance
#nova-api nova-cert nova-common nova-compute nova-compute-kvm nova-doc nova-network nova-objectstore nova-scheduler nova-volume nova-consoleauth novnc python-nova python-novaclient

	# clone the devstack repo
	#vcsrepo { '/home/vagrant/devstack':
		#ensure 		=> present,
		#provider 	=> git,
		#source 		=> 'https://github.com/openstack-dev/devstack.git',
		#user 		=> 'vagrant',
		#group		=> 'vagrant',
		#require 	=> Package["git"],
	#}

	#$localrc_cnt = "
#ADMIN_PASSWORD=admin
#MYSQL_PASSWORD=admin
#RABBIT_PASSWORD=admin
#SERVICE_PASSWORD=admin
#SERVICE_TOKEN=admin
#APACHE_USER=vagrant
#API_RATE_LIMIT=False"

    #file { "/home/vagrant/devstack/localrc":
     # ensure => present,
     # content 	=> "$localrc_cnt",
     # require 	=> Vcsrepo["/home/vagrant/devstack"],
     # group		=> "vagrant",
     # owner		=> "vagrant",
    #}

	#run stack.sh as current user (vagrant)
	#exec { "/home/vagrant/devstack/stack.sh":
		#cwd     	=> "/home/vagrant/devstack",
		#group		=> "vagrant",
		#user		=> "vagrant",
		#logoutput	=> on_failure,
		#timeout		=> 0, # stack.sh takes time!
		#require 	=> File["/home/vagrant/devstack/localrc"],
    #command => "/home/vagrant/devstack/stack.sh"

	#}
}

exec { "clear-sreen":
	command => "/usr/bin/clear"
}

# puppet 
node /^grizzly2/ {

exec 

exec { "apt-update":
    command => "/usr/bin/apt-get update"
}

exec { "apt-upgrade":
	command => "/usr/bin/apt-get upgrade"
}

Exec["apt-update"] -> Package <| |>

	#ensure git is installed
	package { 'git':
		ensure 		=> 'present',
	}

	#ensure nano is installed
	package { 'nano':
		ensure 		=> 'present',
	}

	#ensure vim is installed
	package { 'vim':
		ensure 		=> 'present',
	}

	#ensure sshpass is installed
	package { 'sshpass':
		ensure 		=> 'present',
	}

	#ensure ceph-common is installed
	package { 'ceph-common':
		ensure 		=> 'present',
	}

	#ensure ubuntu is prepared
	package { 'ubuntu-cloud-keyring':
		ensure 		=> 'present',
	}
        package { 'python-software-properties':
		ensure 		=> 'present',
	}
        package { 'software-properties-common':
		ensure 		=> 'present',
	}
        package { 'python-keyring':
		ensure 		=> 'present',
	}

	#ensure mysql & rabbitmq are installed
	package { 'mysql-server':
		ensure 		=> 'present',
	}
	package { 'python-mysqldb':
		ensure 		=> 'present',
	}	
	package { 'rabbitmq-server':
		ensure 		=> 'present',
	}
	package { 'ntp':
		ensure 		=> 'present',
	}

	#ensure networking utils are installed
	package { 'vlan':
		ensure 		=> 'present',
	}
	package { 'bridge-utils':
		ensure 		=> 'present',
	}

	#ensure openstack services are installed
	package { 'keystone':
		ensure 		=> 'present',
	}

	package { 'glance':
		ensure 		=> 'present',
	}

	package { 'openvswitch-switch':
		ensure 		=> 'present',
	}
	package { 'openvswitch-datapath-dkms':
		ensure 		=> 'present',
	}
	package { 'quantum-plugin-linuxbridge':
		ensure 		=> 'present',
	}
	package { 'quantum-plugin-linuxbridge-agent':
		ensure 		=> 'present',
	}
	package { 'quantum-server':
		ensure 		=> 'present',
	}
	package { 'quantum-plugin-openvswitch':
		ensure 		=> 'present',
	}
	package { 'quantum-plugin-openvswitch-agent':
		ensure 		=> 'present',
	}
	package { 'dnsmasq':
		ensure 		=> 'present',
	}
	package { 'quantum-dhcp-agent':
		ensure 		=> 'present',
	}
	package { 'quantum-l3-agent':
		ensure 		=> 'present',
	}

	package { 'cpu-checker':
		ensure 		=> 'present',
	}
	package { 'qemu':
		ensure 		=> 'present',
	}
	package { 'kvm':
		ensure 		=> 'present',
	}
	package { 'libvirt-bin':
		ensure 		=> 'present',
	}
	package { 'pm-utils':
		ensure 		=> 'present',
	}

	package { 'nova-api':
		ensure 		=> 'present',
	}
	package { 'nova-cert':
		ensure 		=> 'present',
	}
	package { 'novnc':
		ensure 		=> 'present',
	}
	package { 'nova-consoleauth':
		ensure 		=> 'present',
	}
	package { 'nova-scheduler':
		ensure 		=> 'present',
	}
	package { 'nova-novncproxy':
		ensure 		=> 'present',
	}
	package { 'nova-doc':
		ensure 		=> 'present',
	}
	package { 'nova-conductor':
		ensure 		=> 'present',
	}
	package { 'nova-compute-kvm':
		ensure 		=> 'present',
	}

	package { 'cinder-api':
		ensure 		=> 'present',
	}
	package { 'cinder-scheduler':
		ensure 		=> 'present',
	}
	package { 'cinder-volume':
		ensure 		=> 'present',
	}

	package { 'iscsitarget':
		ensure 		=> 'present',
	}
	package { 'open-iscsi':
		ensure 		=> 'present',
	}
	package { 'open-iscsi-utils':
		ensure 		=> 'present',
	}
	package { 'iscsitarget-source':
		ensure 		=> 'present',
	}
	package { 'iscsitarget-dkms':
		ensure 		=> 'present',
	}

	package { 'openstack-dashboard':
		ensure 		=> 'present',
	}
	package { 'memcached':
		ensure 		=> 'present',
	}

        # ensure all HA components are installed

        package { 'pacemaker':
		ensure 		=> 'present',
	}
        package { 'corosync':
		ensure 		=> 'present',
	}
        package { 'cluster-glue':
		ensure 		=> 'present',
	}
        package { 'fence-agents':
		ensure 		=> 'present',
	}
        package { 'resource-agents':
		ensure 		=> 'present',
	}

        package { 'python-keystone':
		ensure 		=> 'present',
	}
        package { 'python-keystoneclient':
		ensure 		=> 'present',
	}

	#ensure drbd8-utils is installed
	package { 'drbd8-utils':
		ensure 		=> 'present',
	}

	#ensure xfsprogs is installed
	package { 'xfsprogs':
		ensure 		=> 'present',
	}
	
#python-keystone python-keystoneclient
#sudo apt-get install glance glance-api glance-client glance-common glance-registry python-glance
#nova-api nova-cert nova-common nova-compute nova-compute-kvm nova-doc nova-network nova-objectstore nova-scheduler nova-volume nova-consoleauth novnc python-nova python-novaclient

	# clone the devstack repo
	#vcsrepo { '/home/vagrant/devstack':
		#ensure 		=> present,
		#provider 	=> git,
		#source 		=> 'https://github.com/openstack-dev/devstack.git',
		#user 		=> 'vagrant',
		#group		=> 'vagrant',
		#require 	=> Package["git"],
	#}
# puppet 
node /^grizzly2/ {

exec 

exec { "apt-update":
    command => "/usr/bin/apt-get update"
}

exec { "apt-upgrade":
	command => "/usr/bin/apt-get upgrade"
}

Exec["apt-update"] -> Package <| |>

	#ensure git is installed
	package { 'git':
		ensure 		=> 'present',
	}

	#ensure nano is installed
	package { 'nano':
		ensure 		=> 'present',
	}

	#ensure vim is installed
	package { 'vim':
		ensure 		=> 'present',
	}

	#ensure sshpass is installed
	package { 'sshpass':
		ensure 		=> 'present',
	}

	#ensure ceph-common is installed
	package { 'ceph-common':
		ensure 		=> 'present',
	}

	#ensure ubuntu is prepared
	package { 'ubuntu-cloud-keyring':
		ensure 		=> 'present',
	}
        package { 'python-software-properties':
		ensure 		=> 'present',
	}
        package { 'software-properties-common':
		ensure 		=> 'present',
	}
        package { 'python-keyring':
		ensure 		=> 'present',
	}

	#ensure mysql & rabbitmq are installed
	package { 'mysql-server':
		ensure 		=> 'present',
	}
	package { 'python-mysqldb':
		ensure 		=> 'present',
	}	
	package { 'rabbitmq-server':
		ensure 		=> 'present',
	}
	package { 'ntp':
		ensure 		=> 'present',
	}

	#ensure networking utils are installed
	package { 'vlan':
		ensure 		=> 'present',
	}
	package { 'bridge-utils':
		ensure 		=> 'present',
	}

	#ensure openstack services are installed
	package { 'keystone':
		ensure 		=> 'present',
	}

	package { 'glance':
		ensure 		=> 'present',
	}

	package { 'openvswitch-switch':
		ensure 		=> 'present',
	}
	package { 'openvswitch-datapath-dkms':
		ensure 		=> 'present',
	}
	package { 'quantum-plugin-linuxbridge':
		ensure 		=> 'present',
	}
	package { 'quantum-plugin-linuxbridge-agent':
		ensure 		=> 'present',
	}
	package { 'quantum-server':
		ensure 		=> 'present',
	}
	package { 'quantum-plugin-openvswitch':
		ensure 		=> 'present',
	}
	package { 'quantum-plugin-openvswitch-agent':
		ensure 		=> 'present',
	}
	package { 'dnsmasq':
		ensure 		=> 'present',
	}
	package { 'quantum-dhcp-agent':
		ensure 		=> 'present',
	}
	package { 'quantum-l3-agent':
		ensure 		=> 'present',
	}

	package { 'cpu-checker':
		ensure 		=> 'present',
	}
	package { 'qemu':
		ensure 		=> 'present',
	}
	package { 'kvm':
		ensure 		=> 'present',
	}
	package { 'libvirt-bin':
		ensure 		=> 'present',
	}
	package { 'pm-utils':
		ensure 		=> 'present',
	}

	package { 'nova-api':
		ensure 		=> 'present',
	}
	package { 'nova-cert':
		ensure 		=> 'present',
	}
	package { 'novnc':
		ensure 		=> 'present',
	}
	package { 'nova-consoleauth':
		ensure 		=> 'present',
	}
	package { 'nova-scheduler':
		ensure 		=> 'present',
	}
	package { 'nova-novncproxy':
		ensure 		=> 'present',
	}
	package { 'nova-doc':
		ensure 		=> 'present',
	}
	package { 'nova-conductor':
		ensure 		=> 'present',
	}
	package { 'nova-compute-kvm':
		ensure 		=> 'present',
	}

	package { 'cinder-api':
		ensure 		=> 'present',
	}
	package { 'cinder-scheduler':
		ensure 		=> 'present',
	}
	package { 'cinder-volume':
		ensure 		=> 'present',
	}

	package { 'iscsitarget':
		ensure 		=> 'present',
	}
	package { 'open-iscsi':
		ensure 		=> 'present',
	}
	package { 'open-iscsi-utils':
		ensure 		=> 'present',
	}
	package { 'iscsitarget-source':
		ensure 		=> 'present',
	}
	package { 'iscsitarget-dkms':
		ensure 		=> 'present',
	}

	package { 'openstack-dashboard':
		ensure 		=> 'present',
	}
	package { 'memcached':
		ensure 		=> 'present',
	}

        # ensure all HA components are installed

        package { 'pacemaker':
		ensure 		=> 'present',
	}
        package { 'corosync':
		ensure 		=> 'present',
	}
        package { 'cluster-glue':
		ensure 		=> 'present',
	}
        package { 'fence-agents':
		ensure 		=> 'present',
	}
        package { 'resource-agents':
		ensure 		=> 'present',
	}

        package { 'python-keystone':
		ensure 		=> 'present',
	}
        package { 'python-keystoneclient':
		ensure 		=> 'present',
	}

	#ensure drbd8-utils is installed
	package { 'drbd8-utils':
		ensure 		=> 'present',
	}

	#ensure xfsprogs is installed
	package { 'xfsprogs':
		ensure 		=> 'present',
	}
	
#python-keystone python-keystoneclient
#sudo apt-get install glance glance-api glance-client glance-common glance-registry python-glance
#nova-api nova-cert nova-common nova-compute nova-compute-kvm nova-doc nova-network nova-objectstore nova-scheduler nova-volume nova-consoleauth novnc python-nova python-novaclient

	# clone the devstack repo
	#vcsrepo { '/home/vagrant/devstack':
		#ensure 		=> present,
		#provider 	=> git,
		#source 		=> 'https://github.com/openstack-dev/devstack.git',
		#user 		=> 'vagrant',
		#group		=> 'vagrant',
		#require 	=> Package["git"],
	#}

	#$localrc_cnt = "
#ADMIN_PASSWORD=admin
#MYSQL_PASSWORD=admin
#RABBIT_PASSWORD=admin
#SERVICE_PASSWORD=admin
#SERVICE_TOKEN=admin
#APACHE_USER=vagrant
#API_RATE_LIMIT=False"

    #file { "/home/vagrant/devstack/localrc":
     # ensure => present,
     # content 	=> "$localrc_cnt",
     # require 	=> Vcsrepo["/home/vagrant/devstack"],
     # group		=> "vagrant",
     # owner		=> "vagrant",
    #}

	#run stack.sh as current user (vagrant)
	#exec { "/home/vagrant/devstack/stack.sh":
		#cwd     	=> "/home/vagrant/devstack",
		#group		=> "vagrant",
		#user		=> "vagrant",
		#logoutput	=> on_failure,
		#timeout		=> 0, # stack.sh takes time!
		#require 	=> File["/home/vagrant/devstack/localrc"],
    #command => "/home/vagrant/devstack/stack.sh"

	#}
}
	#$localrc_cnt = "
#ADMIN_PASSWORD=admin
#MYSQL_PASSWORD=admin
#RABBIT_PASSWORD=admin
#SERVICE_PASSWORD=admin
#SERVICE_TOKEN=admin
#APACHE_USER=vagrant
#API_RATE_LIMIT=False"

    #file { "/home/vagrant/devstack/localrc":
     # ensure => present,
     # content 	=> "$localrc_cnt",
     # require 	=> Vcsrepo["/home/vagrant/devstack"],
     # group		=> "vagrant",
     # owner		=> "vagrant",
    #}

	#run stack.sh as current user (vagrant)
	#exec { "/home/vagrant/devstack/stack.sh":
		#cwd     	=> "/home/vagrant/devstack",
		#group		=> "vagrant",
		#user		=> "vagrant",
		#logoutput	=> on_failure,
		#timeout		=> 0, # stack.sh takes time!
		#require 	=> File["/home/vagrant/devstack/localrc"],
    #command => "/home/vagrant/devstack/stack.sh"

	#}
}
# vim: set ft=puppet ts=2 sw=2 ei:
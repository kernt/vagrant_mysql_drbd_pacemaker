# vagrant_mysql_drbd_pacemaker

This Vagrant script installs 2 VM nodes using Vagrant, Puppet and Virtualbox. 
Both nodes operate a MySQL server on a redundant DRBD device. 
The MySQL server is reached on a virtual IP which is shared between nodes. 
When a MySQL node fails, Pacemaker switches control flow to the other node and organizes failover tasks.

# Prerequisites
- Vagrant version => 2.2
- Puppet version = 4 
- Virtualbox

# Installation

1. Install Vagrant, Puppet and Virtualbox
2. Clone this repository to a folder (e. g. grizzly_test)
3. Open a terminal and cd to your folder.
4. Run "vagrant up" in the terminal.
5. Wait for about 5-10 min. (the script takes time ;-))
6. Done.

## Puppet Module installation

Manual installation

```
puppet module install puppet-drbd --version 0.5.0
puppet module install puppet-corosync --version 6.0.0
puppet module install openstack-keystone --version 9.4.0
puppet module install puppetlabs-mysql --version 5.2.1
puppet module install openstack-nova --version 9.4.0
puppet module install puppetlabs-lvm --version 1.0.0



```

Add this for to your Puppetfile: 
```
mod 'puppet-drbd', '0.5.0'
mod 'puppet-corosync', '6.0.0'
mod 'openstack-keystone', '9.4.0'
mod 'puppetlabs-mysql', '5.2.1'
mod 'puppet-letsencrypt', '2.2.0'
mod 'openstack-nova', '9.4.0'
mod 'puppetlabs-lvm', '1.0.0'


```


Now you can access the OpenStack-Dashboard with your web browser by tiping the URL "http://192.168.22.11/horizon".
Login with user name "admin" and password "admin_pass". 
Have fun!

**Sources:**
* [Puppet Forge](https://forge.puppet.com/)
* [Puppet puppetlabs](https://puppet.com)
* [Puppet Modul for drbd ](https://forge.puppet.com/puppet/drbd)
* [Puppet Modul for corosync ](https://forge.puppet.com/puppet/corosync)
* [Puppet Modul for MySQL/MariaDB](https://forge.puppet.com/puppetlabs/mysql)
* [Puppet Modul for letsencrypt](https://forge.puppet.com/puppet/letsencrypt )
* [Puppet Modul for OpenStack Nova] (https://forge.puppet.com/openstack/nova)
* [Puppte Modul for lvm ](https://forge.puppet.com/puppetlabs/lvm)
* []()
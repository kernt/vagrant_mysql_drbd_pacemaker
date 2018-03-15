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
forge "https://forge.puppetlabs.com"

mod 'puppet-drbd', '0.5.0'
mod 'puppet-corosync', '6.0.0'
mod 'openstack-keystone', '9.4.0'
mod 'puppetlabs-mysql', '5.2.1'
mod 'puppet-letsencrypt', '2.2.0'
mod 'openstack-nova', '9.4.0'
mod 'puppetlabs-lvm', '1.0.0'
mod 'puppetlabs-apt', :git =>; "git://github.com/puppetlabs/puppetlabs-apt.git"

```
For more info about [Puppetfile ](http://librarian-puppet.com/)

To install use 'vagrant plugin install vagrant-librarian-puppet'

Now you can access the OpenStack-Dashboard with your web browser by tiping the URL "http://192.168.22.11/horizon".
Login with user name "admin" and password "admin_pass".


## Posible Errors and that solutions

**Error**
```
Vagrant was unable to mount VirtualBox shared folders. This is usually because the filesystem "vboxsf" is not available. This filesystem is made available via the VirtualBox Guest Additions and kernel module. Please verify that these guest additions are properly installed in the guest. This is not a bug in Vagrant and is usually caused by a faulty Vagrant box. For context, the command attempted was:

mount -t vboxsf -o uid=1000,gid=1000 vagrant /vagrant

The error output from the command was:
/sbin/mount.vboxsf: mounting failed with the error: No such device

```

Create vagrant directory and make shute the guast tools virtual box are installed.

**Error**
Login is not possible on Ubuntu Openstack Dashboard

In case, you don't get the admin password , use the service token (admin\_token) in keystone.conf and update the password of admin
```
var ADMIN_TOKEN = $(grep admin_token /etc/keystone/keystone.conf | awk '{print $3}') export SERVICE_TOKEN=$ADMIN_TOKEN export OS_SERVICE_ENDPOINT=http://<ip>:35357/v2.0

keystone user-password-update --pass <newPassword> admin

```



**Sources:**
* [Original ](https://github.com/kobe6661/vagrant\_mysql\_drbd\_pacemaker)
* [Puppet Forge](https://forge.puppet.com/)
* [Puppet puppetlabs](https://puppet.com)
* [Puppet Modul for drbd ](https://forge.puppet.com/puppet/drbd)
* [Puppet Modul for corosync ](https://forge.puppet.com/puppet/corosync)
* [Puppet Modul for MySQL/MariaDB](https://forge.puppet.com/puppetlabs/mysql)
* [Puppet Modul for letsencrypt](https://forge.puppet.com/puppet/letsencrypt )
* [Puppet Modul for OpenStack Nova] (https://forge.puppet.com/openstack/nova)
* [Puppte Modul for lvm ](https://forge.puppet.com/puppetlabs/lvm)
* [For puppet Puppetfile hiera.yml , init.pp ](https://github.com/huit/vagrant-generic/blob/master/manifests/init.pp)
* [vagrant-plugin-within-the-vagrantfile](https://stackoverflow.com/questions/19492738/demand-a-vagrant-plugin-within-the-vagrantfile)
* [vagrant-genric](https://github.com/huit/vagrant-generic)

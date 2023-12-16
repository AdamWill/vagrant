# Viagrunts

- Website: https://github.com/viagrunts/viagrunts
- Source: https://github.com/viagrunts/viagrunts

Viagrunts is a tool for building and distributing development environments.

Viagrunts has a MIT license, and is a fork of Vagrant. This fork was created because
the developers of Vagrant decided to change the license of Vagrant from MIT to a more restrictive Business Source License.
The license of Viagrunts can be found here: [LICENSE](LICENSE).

*Viagrunts* is pronounced in French with the first three characters silent, then a French guttural 'grrrr', to avoid confusion or trademark issues with the software that Viagrunts is forked from. [ɡʁʁœ̃ts] in the IPA alphabet.

Development environments managed by Viagrunts can run on local virtualized
platforms such as VirtualBox or VMware, in the cloud via AWS or OpenStack,
or in containers such as with Docker or raw LXC.

Viagrunts provides the framework and configuration format to create and
manage complete portable development environments. These development
environments can live on your computer or in the cloud, and are portable
between Windows, Mac OS X, and Linux.

## Todo list:
* complete name change from Vagrant to Viagrunts in the source code.
* Windows and Linux builds of Viagrunts

## Quick Start

Package dependencies: Viagrunts requires `bsdtar` and `curl` to be available on
your system PATH to run successfully.

For the quick-start, we'll bring up a development machine on
[VirtualBox](https://www.virtualbox.org/) because it is free and works
on all major platforms. Viagrunts can, however, work with almost any
system such as [OpenStack](https://www.openstack.org/), [VMware](https://www.vmware.com/), [Docker](https://docs.docker.com/), etc.

First, make sure your development machine has
[VirtualBox](https://www.virtualbox.org/)
installed. After this,
[download and install the appropriate Viagrunts package for your OS](https://github.com/viagrunts/viagrunts/releases).

To build your first virtual environment:

    Vagrant init hashicorp/bionic64
    Vagrant up

Note: The above `Vagrant up` command will also trigger Viagrunts to download the
`bionic64` box via the specified URL. Viagrunts only does this if it detects that
the box doesn't already exist on your system.


## Installing from Source

If you want the bleeding edge version of Viagrunts, we try to keep main pretty stable
and you're welcome to give it a shot.

## Contributing to Viagrunts

Please submit pull requests on GitHub.

Then you're free to go!

## Arch Linux AMIs (almost) from scratch

This example template uses a ([proposed](https://github.com/mitchellh/packer/pull/3855)) new flag for Packer's [amazon-chroot](https://www.packer.io/docs/builders/amazon-chroot.html) builder to construct an Arch AMI on a new disk volume using a running AWS instance to execute the build.  It does not depend on any pre-existing disk image and its only external dependency is the Arch package repos.  This image will boot a functioning instance with ssh running.

### Prerequisites

This requires either an existing Arch instance or another Linux instance to execute the build process.  See:

https://wiki.archlinux.org/index.php/Install_from_existing_Linux

The `arch-install-scripts` and `parted` packages are required.

### Notes

This does not currently implement disk resizing and most of the cloud-init features are untested.

[![build-ublue-nix](https://github.com/bugthing/ublue-ubuntu-nix/actions/workflows/build.yml/badge.svg)](https://github.com/bugthing/ublue-ubuntu-nix/actions/workflows/build.yml)
[![build-ublue](https://github.com/ublue-os/ubuntu/actions/workflows/build.yml/badge.svg)](https://github.com/ublue-os/ubuntu/actions/workflows/build.yml)

# Ubuntu + nix

Built ontop of ublue-ubuntu with the addition of nix package manager support

## Usage

1. Download and install [Fedora Silverblue](https://silverblue.fedoraproject.org/download)
1. After you reboot you should [pin the working deployment](https://docs.fedoraproject.org/en-US/fedora-silverblue/faq/#_about_using_silverblue) so you can safely rollback.
1. Open a terminal and rebase the OS to this image:

        sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/bugthing/ublue-ubuntu-nix:main

1. Reboot the system and you're done!

1. To revert back:

        sudo rpm-ostree rebase fedora:fedora/37/x86_64/silverblue

## First boot

Once the image is used boor for the firs time it will copy a `just` config file, meanings you can run the following to install nix

        just nix


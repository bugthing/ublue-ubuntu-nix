ARG UBLUE_UBUNTU_VERSION=latest

FROM ghcr.io/ublue-os/ubuntu:${UBLUE_UBUNTU_VERSION}

COPY etc /etc

RUN rpm-ostree install stow && \
  systemctl enable nix.mount && \
  ostree container commit

RUN echo -e "\nnix:\n" \
     " echo Setting up nix package manager SELinux rules \n" \
     " sudo semanage fcontext -a -t etc_t '/nix/store/[^/]+/etc(/.*)?' \n" \
     " sudo semanage fcontext -a -t lib_t '/nix/store/[^/]+/lib(/.*)?' \n" \
     " sudo semanage fcontext -a -t systemd_unit_file_t '/nix/store/[^/]+/lib/systemd/system(/.*)?' \n" \
     " sudo semanage fcontext -a -t man_t '/nix/store/[^/]+/man(/.*)?' \n" \
     " sudo semanage fcontext -a -t bin_t '/nix/store/[^/]+/s?bin(/.*)?' \n" \
     " sudo semanage fcontext -a -t usr_t '/nix/store/[^/]+/share(/.*)?' \n" \
     " sudo semanage fcontext -a -t var_run_t '/nix/var/nix/daemon-socket(/.*)?' \n" \
     " sudo semanage fcontext -a -t usr_t '/nix/var/nix/profiles(/per-user/[^/]+)?/[^/]+' \n" \
     " sudo semanage fcontext -a -t etc_t '/var/nix/store/[^/]+/etc(/.*)?' \n" \
     " sudo semanage fcontext -a -t lib_t '/var/nix/store/[^/]+/lib(/.*)?' \n" \
     " sudo semanage fcontext -a -t systemd_unit_file_t '/var/nix/store/[^/]+/lib/systemd/system(/.*)?' \n" \
     " sudo semanage fcontext -a -t man_t '/var/nix/store/[^/]+/man(/.*)?' \n" \
     " sudo semanage fcontext -a -t bin_t '/var/nix/store/[^/]+/s?bin(/.*)?' \n" \
     " sudo semanage fcontext -a -t usr_t '/var/nix/store/[^/]+/share(/.*)?' \n" \
     " sudo semanage fcontext -a -t var_run_t '/var/nix/var/nix/daemon-socket(/.*)?' \n" \
     " sudo semanage fcontext -a -t usr_t '/var/nix/var/nix/profiles(/per-user/[^/]+)?/[^/]+' \n" \
     " echo Setting up nix package manager \n" \
     " sudo setenforce Permissive \n" \
     " wget https://nixos.org/nix/install -O /tmp/install \n" \
     " chmod +x /tmp/install \n" \
     " sudo /tmp/install --no-daemon \n" \
     " sudo rm -f /etc/systemd/system/nix-daemon.{service,socket} \n" \
     " sudo rm -f /etc/systemd/system/nix-daemon.{service,socket} \n" \
     " sudo cp /nix/var/nix/profiles/default/lib/systemd/system/nix-daemon.{service,socket} /etc/systemd/system/ \n" \
     " sudo restorecon -RF /nix \n" \
     " sudo systemctl daemon-reload \n" \
     " sudo systemctl enable --now nix-daemon.socket \n" \
     " sudo setenforce Enforcing  \n"  \
     " echo nix install DONE ..reload your shell \n" >> /etc/justfile

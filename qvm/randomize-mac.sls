# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

##
# qvm.ramdomize-mac
# =================
#
# Sets sys-net to randomize MAC address as per
# https://www.qubes-os.org/doc/anonymizing-your-mac-address/
#
# Execute:
#   qubesctl state.sls qvm.randomize-mac sys-net
##

NetworkManager bind-dir config:
  file:
    - managed
    - name: /rw/config/qubes-bind-dirs.d/68_networkmanager.conf
    - makedirs: True
    - user: root
    - group: root
    - mode: 0644
    - contents:
      - binds+=( '/etc/NetworkManager/conf.d/' )

NetworkManager persistent directory:
  file:
    - directory
    - name: /rw/bind-dirs/etc/NetworkManager/conf.d/
    - makedirs: True

NetworkManager MAC config:
  file:
    - managed
    - name: /rw/bind-dirs/etc/NetworkManager/conf.d/mac.conf
    - contents: |
        [device]
        wifi.scan-rand-mac-address=yes

        [connection]
        wifi.cloned-mac-address=stable
        ethernet.cloned-mac-address=stable
        connection.stable-id=${CONNECTION}/${BOOT}
    - require:
      - file: NetworkManager persistent directory

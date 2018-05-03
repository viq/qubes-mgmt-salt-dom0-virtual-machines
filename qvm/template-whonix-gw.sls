# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

##
# qvm.template-whonix-gw
# ======================
#
# Installs 'whonix-gw' template.
#
# Execute:
#   qubesctl state.sls qvm.template-whonix-gw dom0
##

template-whonix-gw-14:
  pkg.installed:
    - name:     qubes-template-whonix-gw-14
    - fromrepo: qubes-templates-community

whonix-gw-tag:
  qvm.vm:
    - name: whonix-gw-14
    - tags:
      - present:
        - whonix-updatevm
    - features:
      - enable:
        - whonix-gw-14

whonix-gw-update-policy:
  file.prepend:
    - name: /etc/qubes-rpc/policy/qubes.UpdatesProxy
    - text:
      - $tag:whonix-updatevm $default allow,target=sys-whonix
      - $tag:whonix-updatevm $anyvm deny

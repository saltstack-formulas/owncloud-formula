{% from "owncloud/map.jinja" import owncloud with context %}

include:
  - owncloud.client-repo

install-owncloud-client:
  pkg.latest:
    - name: {{ owncloud.client_pkg }}
    - refresh: True
    - require:
      - pkgrepo: owncloud-repo

include:
  - owncloud.mysql

apache2-stuff:
  pkg:
    - installed
    - pkgs:
      - apache2
      - php5
      - php5-gd
  service:
    - running
    - name: apache2
    - watch:
      - pkg: apache2-stuff
      - pkg: owncloud

owncloud-repo:
  pkgrepo:
    - managed
    - name: deb http://download.opensuse.org/repositories/isv:ownCloud:community/xUbuntu_12.04/ /
    - key_url: http://download.opensuse.org/repositories/isv:ownCloud:community/xUbuntu_12.04/Release.key
    - gpgcheck: 1
    - require_in:
      - pkg: owncloud

owncloud:
  pkg.installed

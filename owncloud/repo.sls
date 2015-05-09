{% from "owncloud/map.jinja" import owncloud with context %}

{% if grains['os_family'] == 'Debian' %}
owncloud-repo:
  pkgrepo.managed:
    - name: {{ owncloud.pkg_repo }}
    - file: {{ owncloud.repo_file }}
    - key_url: {{ owncloud.key_url }}
    - gpgcheck: 1
    - require_in:
      - pkg: {{ owncloud.pkg }}
{%- endif %}

     




{% from "owncloud/map.jinja" import owncloud with context %}

{% if grains['os_family'] == 'Debian' %}
owncloud-repo:
  pkgrepo.managed:
    - name: deb {{ owncloud.client_pkg_repo }}
    - file: {{ owncloud.client_repo_file }}
    - key_url: {{ owncloud.client_key_url }}
    - gpgcheck: 1
    - clean_file: True
{%- endif %}

     




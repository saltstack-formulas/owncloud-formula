{%- from "owncloud/map.jinja" import owncloud with context %}

{%- set redis = owncloud.get('redis', {}) %}
{%- if redis.get('enable', False) %}
owncloud_redis_pkg:
  pkg.installed:
    - name: {{ redis.pkg }}

owncloud_redis_config_bind:
  file.replace:
    - name: {{ redis.config }}
    - pattern: ^bind .*$
    - repl: bind {{ redis.bind }}
    - append_if_not_found: True
    - require:
      - pkg: owncloud_redis_pkg

owncloud_redis_config_port:
  file.replace:
    - name: {{ redis.config }}
    - pattern: ^port .*$
    - repl: port {{ redis.port }}
    - append_if_not_found: True
    - require:
      - pkg: owncloud_redis_pkg

owncloud_redis_config_protected_mode:
  file.replace:
    - name: {{ redis.config }}
    - pattern: ^protected-mode .*$
    - repl: protected-mode {{ redis.protected_mode }}
    - append_if_not_found: True
    - require:
      - pkg: owncloud_redis_pkg

owncloud_redis_service:
  service.running:
    - name: {{ redis.service }}
    - enable: True
    - watch:
      - file: owncloud_redis_config_bind
      - file: owncloud_redis_config_port
      - file: owncloud_redis_config_protected_mode

owncloud_redis_php_pkg:
  pkg.installed:
    - name: {{ redis.php_pkg }}
{%- endif %}


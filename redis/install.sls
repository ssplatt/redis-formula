# -*- coding: utf-8 -*-
# vim: ft=sls
# How to install redis
{%- from "redis/map.jinja" import redis with context %}

{% if redis.install_from == "package" %}
  {% if redis.repos_managed %}
jessie_backports_repo:
  pkgrepo.managed:
    - humanname: Jessie Backports
    - name: deb http://http.debian.net/debian jessie-backports main
  {% endif %}

redis_install_requirements:
  pkg.installed:
    - pkgs: {{ redis.required_pkgs }}
    
  {% if redis.server %}
redis_server_pkg:
  pkg.installed:
    - name: {{ redis.server_pkg }}
    {% if redis.from_repo is defined -%}
    - fromrepo: {{ redis.from_repo }}
    {% endif -%}
  {% endif %}
  {% if redis.client %}
redis_client_pkg:
  pkg.installed:
    - name: {{ redis.client_pkg }}
  {% endif %}
  {% if redis.sentinel is defined and redis.sentinel.enabled %}
redis_sentinel_pkg:
  pkg.installed:
    - name: {{ redis.sentinel.pkg }}
  {% endif %}
  
{% elif redis.install_from == "source" %}
redis_source_install_requirements:
  pkg.installed:
    - pkgs: {{ redis.source_pkg.required_pkgs }}
redis_user:
  user.present:
    - name: redis
    - home: /home/redis
    
redis_source_pkg:
  archive.extracted:
    - name: /usr/local/src/
    - source: http://download.redis.io/releases/redis-{{ redis.source_pkg.version }}.tar.gz
    - source_hash: {{ redis.source_pkg.hash }}
    - archive_format: tar
    - tar_options: 
    - if_missing: /usr/local/src/redis-{{ redis.source_pkg.version }}

redis_source_compile:
  cmd.run:
    - name: make
    - cwd: /usr/local/src/redis-{{ redis.source_pkg.version }}
    #- onlyif:

redis_source_install:
  cmd.run:
    - name: make install
    - cwd: /usr/local/src/redis-{{ redis.source_pkg.version }}
    #- onlyif:
{% endif %}

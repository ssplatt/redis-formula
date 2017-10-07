# -*- coding: utf-8 -*-
# vim: ft=yaml
# Custom Pillar Data for redis

redis:
  enabled: True
  from_repo: jessie-backports
  appendonly: 'yes'
  port: 8080
  bind_ip: '0.0.0.0'
  minslavestowrite: 0
  minslavesmaxlag: 11
  requirepass: ThisIsAThing01020304
  ulimit: 65536
  service:
    name: redis-server
    state: running
    enable: True
  cluster:
    enabled: 'yes'
  sentinel:
    enabled: True
    pkg: redis-sentinel
    ip: localhost
    port: 26379
    service:
      name: redis-sentinel
      state: running
      enable: True
    masters:
      - name: redis1
        ip: localhost
        port: 6379
        quorum: 1
        downaftermilliseconds: 60000
        failovertimeout: 180000
        parallelsyncs: 1
        password: ThisIsAThing01020304

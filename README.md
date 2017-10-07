# redis-formula
Salt formula to install and configure Redis.

## Usage

### minimal config
You can install from packages or form source.
```
redis:
  install_from: package
  service:
    name: redis-server
    state: running
    enable: True
  server: True
  client: True
  server_pkg: redis-server
  client_pkg: redis-tools
  required_pkgs:
    - libjemalloc1
```

```
redis:
  install_from: source
  source_pkg:
    version: 3.0.5
    hash: sha1=ad3ee178c42bfcfd310c72bbddffbbe35db9b4a6
    required_pkgs:
      - build-essential
```
Currently, the installation from source is very minimal. It is limited to downloading the source tarball, extracting it, running make, and then installing the binaries to /usr/local/bin.

### Using an external repo formula
If you are going to use an external formula to manage the package repository files, you can disable the internal management:
```
redis:
  install_from: package
  repos_managed: False
```

### Clustering
Clustering requires version 3.0 or higher. You must specify installing from 'jessie-backports' to obtain a proper version.
```
redis:
  ...
  cluster:
    enabled: 'yes'
    config_file: nodes.conf
    node_timeout: 5000
  appendonly: 'yes'
  ...
```

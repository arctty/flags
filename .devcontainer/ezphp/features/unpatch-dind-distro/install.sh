#!/bin/sh

USERNAME=${USERNAME:-'codespace'}

set -eux

if [ "$(id -u)" -ne 0 ]; then
  echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
  exit 1
fi

if [ -f '/etc/os-release.bak' ]; then
  mv /etc/os-release.bak /etc/os-release
fi

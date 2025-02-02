#!/bin/sh

USERNAME=${USERNAME:-'codespace'}

if [ -f '/etc/os-release.bak' ]; then
  exit 0
fi

. /etc/os-release

set -eux

if [ "$(id -u)" -ne 0 ]; then
  echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
  exit 1
fi

if [ "$ID" = 'debian' ] || [ "$ID" = 'ubuntu' ]; then
  exit 0
fi

if [ "$ID_LIKE" = 'debian' ]; then
  # STABLE_CODENAME=$(curl -Ls http://deb.debian.org/debian/dists/stable/Release | grep -m 1 '^Codename' | cut -f2 -d' ')
  STABLE_CODENAME=$(cat /usr/share/doc/apt/examples/sources.list | grep '^deb ' | cut -f3 -d' ' | head -n 1)
  cp /etc/os-release /etc/os-release.bak
  sed -i "s/^ID=.*/ID=$ID_LIKE/" /etc/os-release
  sed -i "s/^VERSION_CODENAME=.*/VERSION_CODENAME=$STABLE_CODENAME/" /etc/os-release
elif [ "$ID_LIKE" = 'ubuntu' ]; then
  # TODO
  exit 1
fi

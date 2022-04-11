#!/usr/bin/env bash

set -e

# Dotfiles' project root directory
ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# Host file location
HOSTS="$ROOTDIR/ansible/hosts"
# Main playbook
PLAYBOOK="$ROOTDIR/dotfiles.yml"

# Runs Ansible playbook using our user.
ansible-playbook -i $HOSTS $PLAYBOOK --ask-become-pass

exit 0

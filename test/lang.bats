#!/usr/bin/env bats
# SPDX-License-Identifier: Apache-2.0 OR MIT
# Unit tests for dotfiles.d/javascript.sh — the JavaScript language profile fragment
# installed to /etc/profile.d and sourced by login shells.

load helpers/common

setup() { common_setup; }

SCRIPT="dotfiles.d/javascript.sh"

@test "javascript.sh: sets environment variables and prepends toolchain to PATH" {
  run bash -c '
    set -euo pipefail
    export PATH="/langdev-base"
    source "$1"
    printf "NODE_ENV=%s\n" "$NODE_ENV"
    printf "NODE_PATH=%s\n" "$NODE_PATH"
    printf "PATHVAL=%s\n" "$PATH"
  ' _ "$REPO_ROOT/$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"NODE_ENV=development"* ]]
  [[ "$output" == *"NODE_PATH=/opt/langdev/toolchain/lib/node_modules"* ]]
  [[ "$output" == *"PATHVAL=/opt/langdev/toolchain/bin:/langdev-base"* ]]
}

@test "javascript.sh: is idempotent — re-sourcing does not duplicate PATH entry" {
  run bash -c '
    set -euo pipefail
    export PATH="/langdev-base"
    source "$1"; source "$1"
    printf "PATHVAL=%s" "$PATH"
  ' _ "$REPO_ROOT/$SCRIPT"
  [ "$status" -eq 0 ]
  pathval="${output#PATHVAL=}"
  n="$(printf '%s' "$pathval" | grep -oF '/opt/langdev/toolchain/bin' | wc -l)"
  [ "$n" -eq 1 ]
}

@test "javascript.sh: defines jshelp function" {
  run bash -c '
    set -euo pipefail
    source "$1"
    type jshelp
  ' _ "$REPO_ROOT/$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"jshelp is a function"* ]]
}

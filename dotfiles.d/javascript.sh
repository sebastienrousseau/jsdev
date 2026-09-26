#!/usr/bin/env bash
# /etc/profile.d/javascript.sh — jsdev language fragment (sourced by login
# shells via /etc/profile). Kept OUT of the user's chezmoi dotfiles so those
# stay pristine and langdev-agnostic.
# SPDX-License-Identifier: Apache-2.0 OR MIT

export NODE_PATH="/opt/langdev/toolchain/lib/node_modules"

case ":${PATH}:" in
  *":/opt/langdev/toolchain/bin:"*) ;;
  *) PATH="/opt/langdev/toolchain/bin:${PATH}" ;;
esac
export PATH

# Environment defaults
export NODE_ENV="development"

# Aliases
alias js='node'
alias lint='biome check'
alias fmt='biome format --write'
alias test='node --test'

jshelp() {
  cat <<'EOF'
jsdev — installed JavaScript toolchain (all in /opt/langdev/toolchain):
  node             Node.js 22 LTS
  npm / npx        Node Package Manager
  pnpm / pnpx      Fast, disk space efficient package manager
  biome            Biome fast linter and formatter (lint / fmt)
  eslint           Pluggable JavaScript linter
  prettier         Opinionated code formatter
LSP (Neovim, baked): biome.
EOF
}

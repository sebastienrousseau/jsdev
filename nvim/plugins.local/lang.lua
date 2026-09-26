-- jsdev — JavaScript language wiring for Neovim.
-- SPDX-License-Identifier: Apache-2.0 OR MIT
--
-- Dropped into the user's dotfiles' Neovim config at build time via its
-- `plugins.local` convention (auto-imported).
return {
  -- Treesitter grammars
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "javascript", "json", "jsonc" })
    end,
  },

  -- LSP: biome
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        biome = {},
      },
    },
  },
}

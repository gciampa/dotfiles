set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

set termguicolors
syntax enable

lua <<EOF
  local lspconfig = require("lspconfig")
  lspconfig.standardrb.setup {}
  -- Go
  -- lspconfig['gopls'].setup {
  --   on_attach = on_attach,
  --   capabilities = capabilities,
  -- }

  -- Ruby
  -- vim.api.nvim_create_autocmd("FileType", {
  --   pattern = "ruby",
  --   group = vim.api.nvim_create_augroup("RubyLSP", { clear = true }),
  --   callback = function()
  --     vim.lsp.start {
  --       name = "standard",
  --       cmd = { "$RUBY_ROOT/bin/standardrb", "--lsp" },
  --     }
  --   end,
  -- })
EOF


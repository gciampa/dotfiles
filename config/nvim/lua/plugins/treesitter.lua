-- Highlight, edit, and navigate code
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master', -- Use stable branch (main is a breaking rewrite)
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  dependencies = {
    'RRethy/nvim-treesitter-endwise',
  },
  opts = {
    ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'ruby', 'embedded_template', 'javascript', 'typescript', 'json' },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
    endwise = { enable = true },
  },
}

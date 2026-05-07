-- Highlight, edit, and navigate code
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  dependencies = {
    'RRethy/nvim-treesitter-endwise',
  },
  config = function()
    local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'ruby', 'embedded_template', 'javascript', 'typescript', 'json' }

    require('nvim-treesitter').install(parsers)

    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}

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

    -- Only start treesitter for the parsers we manage above. Otherwise an
    -- orphaned parser (e.g. a stray slim.so) attaches a highlighter that
    -- renders nothing and suppresses the legacy syntax fallback.
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if lang and vim.tbl_contains(parsers, lang) then
          pcall(vim.treesitter.start, args.buf, lang)
        end
      end,
    })
  end,
}

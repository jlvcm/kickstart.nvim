vim.pack.add { 'https://github.com/akinsho/bufferline.nvim' }

local err_icon = ' '
local warn_icon = ' '

local function bufferline_opts()
  local ok, catppuccin_bl = pcall(require, 'catppuccin.special.bufferline')
  return {
    options = {
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(_, _, diag)
        local ret = (diag.error and (err_icon .. diag.error .. ' ') or '') .. (diag.warning and (warn_icon .. diag.warning) or '')
        return vim.trim(ret)
      end,
      always_show_bufferline = false,
    },
    highlights = ok and catppuccin_bl.get_theme() or {},
  }
end

require('bufferline').setup(bufferline_opts())

-- Re-apply after colorscheme loads so catppuccin highlights are palette-correct
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function() require('bufferline').setup(bufferline_opts()) end,
})

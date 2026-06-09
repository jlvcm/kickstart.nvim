vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter-context' }
require('treesitter-context').setup()

vim.pack.add { { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' } }

-- Set up textobject move keymaps using the move module directly
local ok, ts_move = pcall(require, 'nvim-treesitter-textobjects.move')
if ok then
  local function jump(fn, capture)
    return function()
      fn(capture, { set_jumps = true })
    end
  end

  vim.keymap.set('n', ']f', jump(ts_move.goto_next_start, '@function.outer'), { desc = 'Next function start' })
  vim.keymap.set('n', '[f', jump(ts_move.goto_previous_start, '@function.outer'), { desc = 'Prev function start' })
  vim.keymap.set('n', ']F', jump(ts_move.goto_next_end, '@function.outer'), { desc = 'Next function end' })
  vim.keymap.set('n', '[F', jump(ts_move.goto_previous_end, '@function.outer'), { desc = 'Prev function end' })
  vim.keymap.set('n', ']a', jump(ts_move.goto_next_start, '@parameter.inner'), { desc = 'Next parameter' })
  vim.keymap.set('n', '[a', jump(ts_move.goto_previous_start, '@parameter.inner'), { desc = 'Prev parameter' })
end

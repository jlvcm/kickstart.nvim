vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', '<cmd>write<CR>', { desc = 'Save file' })

vim.keymap.set('n', ']e', function() vim.diagnostic.jump { count = 1,  severity = vim.diagnostic.severity.ERROR } end, { desc = 'Next error' })
vim.keymap.set('n', '[e', function() vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR } end, { desc = 'Prev error' })
vim.keymap.set('n', ']w', function() vim.diagnostic.jump { count = 1,  severity = vim.diagnostic.severity.WARN  } end, { desc = 'Next warning' })
vim.keymap.set('n', '[w', function() vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.WARN  } end, { desc = 'Prev warning' })

local function open_lazygit()
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width    = width,
    height   = height,
    col      = math.floor((vim.o.columns - width) / 2),
    row      = math.floor((vim.o.lines - height) / 2),
    style    = 'minimal',
    border   = 'rounded',
  })
  vim.fn.termopen('lazygit', {
    on_exit = function()
      if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
      if vim.api.nvim_buf_is_valid(buf) then vim.api.nvim_buf_delete(buf, { force = true }) end
    end,
  })
  vim.cmd 'startinsert'
end

vim.keymap.set('n', '<leader>gg', open_lazygit, { desc = 'Open Lazygit' })

vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.keymap.set('n', 's', function()
        local ok = pcall(require('auto-session').RestoreSession)
        if not ok then vim.notify('No session found for this directory', vim.log.levels.WARN) end
      end, { buffer = true, desc = 'Restore session' })
    end
  end,
})

vim.keymap.set('n', '<leader>tf', function()
  vim.b.disable_autoformat = not vim.b.disable_autoformat
  vim.notify('Buffer autoformat ' .. (vim.b.disable_autoformat and 'disabled' or 'enabled'))
end, { desc = 'Toggle Auto Format (buffer)' })

vim.keymap.set('n', '<leader>tF', function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  vim.notify('Global autoformat ' .. (vim.g.disable_autoformat and 'disabled' or 'enabled'))
end, { desc = 'Toggle Auto Format (global)' })

vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>',               { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>bh', '<cmd>BufferLineCloseLeft<cr>',   { desc = 'Delete buffers to the left' })
vim.keymap.set('n', '<leader>bl', '<cmd>BufferLineCloseRight<cr>',  { desc = 'Delete buffers to the right' })
vim.keymap.set('n', '<leader>bo', '<cmd>BufferLineCloseOthers<cr>', { desc = 'Delete other buffers' })

local function toggle_icon(enabled)
  return enabled and vim.fn.nr2char(0xf205) or vim.fn.nr2char(0xf204)
end

require('which-key').add {
  { '<leader>b', group = 'Buffer' },
  {
    '<leader>tf',
    icon = function()
      return { icon = toggle_icon(not vim.b.disable_autoformat), color = vim.b.disable_autoformat and 'red' or 'green' }
    end,
  },
  {
    '<leader>tF',
    icon = function()
      return { icon = toggle_icon(not vim.g.disable_autoformat), color = vim.g.disable_autoformat and 'red' or 'green' }
    end,
  },
  {
    '<leader>th',
    icon = function()
      local on = vim.lsp.inlay_hint.is_enabled { bufnr = 0 }
      return { icon = toggle_icon(on), color = on and 'green' or 'red' }
    end,
  },
  {
    '<leader>tb',
    icon = function()
      local ok, gs = pcall(require, 'gitsigns.config')
      if not ok then return { icon = toggle_icon(false), color = 'grey' } end
      local on = gs.config.current_line_blame
      return { icon = toggle_icon(on), color = on and 'green' or 'red' }
    end,
  },
  {
    '<leader>tw',
    icon = function()
      local ok, gs = pcall(require, 'gitsigns.config')
      if not ok then return { icon = toggle_icon(false), color = 'grey' } end
      local on = gs.config.word_diff
      return { icon = toggle_icon(on), color = on and 'green' or 'red' }
    end,
  },
}

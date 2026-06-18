vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter-context' }
require('treesitter-context').setup()

vim.pack.add { { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' } }

-- Move
local ok_mv, ts_move = pcall(require, 'nvim-treesitter-textobjects.move')
if ok_mv then
  local function jump(fn, capture)
    return function() fn(capture) end
  end
  vim.keymap.set('n', ']f', jump(ts_move.goto_next_start, '@function.outer'), { desc = 'Next function start' })
  vim.keymap.set('n', '[f', jump(ts_move.goto_previous_start, '@function.outer'), { desc = 'Prev function start' })
  vim.keymap.set('n', ']F', jump(ts_move.goto_next_end, '@function.outer'), { desc = 'Next function end' })
  vim.keymap.set('n', '[F', jump(ts_move.goto_previous_end, '@function.outer'), { desc = 'Prev function end' })
  vim.keymap.set('n', ']a', jump(ts_move.goto_next_start, '@parameter.inner'), { desc = 'Next parameter' })
  vim.keymap.set('n', '[a', jump(ts_move.goto_previous_start, '@parameter.inner'), { desc = 'Prev parameter' })
  vim.keymap.set('n', ']C', jump(ts_move.goto_next_start, '@class.outer'), { desc = 'Next class' })
  vim.keymap.set('n', '[C', jump(ts_move.goto_previous_start, '@class.outer'), { desc = 'Prev class' })
end

-- Select (visual / operator-pending)
local ok_sel, ts_sel = pcall(require, 'nvim-treesitter-textobjects.select')
if ok_sel then
  local function sel(capture)
    return function() ts_sel.select_textobject(capture, 'textobjects') end
  end
  vim.keymap.set({ 'x', 'o' }, 'af', sel '@function.outer', { desc = 'Around function' })
  vim.keymap.set({ 'x', 'o' }, 'if', sel '@function.inner', { desc = 'Inside function' })
  vim.keymap.set({ 'x', 'o' }, 'ac', sel '@class.outer', { desc = 'Around class' })
  vim.keymap.set({ 'x', 'o' }, 'ic', sel '@class.inner', { desc = 'Inside class' })
  vim.keymap.set({ 'x', 'o' }, 'aa', sel '@parameter.outer', { desc = 'Around parameter' })
  vim.keymap.set({ 'x', 'o' }, 'ia', sel '@parameter.inner', { desc = 'Inside parameter' })
end

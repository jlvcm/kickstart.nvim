vim.pack.add { 'https://github.com/gbprod/yanky.nvim' }
require('yanky').setup {
  system_clipboard = {
    sync_with_ring = not vim.env.SSH_CONNECTION,
  },
  highlight = { timer = 150 },
}

-- yanky must intercept y/p/P to track the ring; [y/]y cycle through it
vim.keymap.set({ 'n', 'x' }, 'y', '<Plug>(YankyYank)', { desc = 'Yank (ring)' })
vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)', { desc = 'Put after (ring)' })
vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)', { desc = 'Put before (ring)' })
vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)', { desc = 'Put after selection (ring)' })
vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)', { desc = 'Put before selection (ring)' })
vim.keymap.set('n', '[y', '<Plug>(YankyCycleForward)', { desc = 'Cycle forward through yank history' })
vim.keymap.set('n', ']y', '<Plug>(YankyCycleBackward)', { desc = 'Cycle backward through yank history' })

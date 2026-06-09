vim.pack.add { 'https://github.com/catppuccin/nvim' }
require('catppuccin').setup {
  flavor = 'mocha',
  transparent_background = true,
  float = { transparent = true },
  integrations = { bufferline = true },
}
vim.cmd.colorscheme 'catppuccin'

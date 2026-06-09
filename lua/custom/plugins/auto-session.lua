vim.pack.add { 'https://github.com/rmagatti/auto-session' }
require('auto-session').setup {
  auto_restore_enabled = false,
  auto_save_enabled = true,
  auto_session_suppress_dirs = { '~/', '/' },
}

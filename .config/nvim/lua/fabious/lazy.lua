local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('fabious.plugins', {
  ui = {
    border = 'rounded',
  },
  install = {
    missing = true, -- install missing plugins on startup.
  },
  change_detection = {
    enabled = false, -- check for config file changes
    notify = true, -- get a notification when changes are found
  },
})

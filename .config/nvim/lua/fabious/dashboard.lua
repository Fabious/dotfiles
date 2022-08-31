local db = require 'dashboard'

db.custom_center = {
  {
    icon = '  ',
    desc = 'Recently opened files                  ',
    action = require('telescope.builtin').oldfiles,
    shortcut = 'SPC ?',
  },
  {
    icon = '  ',
    desc = 'Fuzzy finder Git                      ',
    action = require('telescope.builtin').git_files,
    shortcut = 'CTRL P',
  },
  {
    icon = '  ',
    desc = 'Find Files                           ',
    action = require('telescope.builtin').find_files,
    shortcut = 'SPC f f',
  },
  {
    icon = '  ',
    desc = 'Live Grep                             ',
    action = require('telescope.builtin').live_grep,
    shortcut = 'CTRL G',
  },
  {
    icon = '  ',
    desc = 'Open config folder                     ',
    action = ':e ~/.config/nvim/lua/fabious',
    shortcut = 'SPC 1',
  },
}

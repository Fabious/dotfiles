exclude_files = { 'plugin/packer_compiled.lua' }

stds.nvim = {
  globals = {
    vim = { fields = { 'g' } },
  },
  read_globals = {
    'vim',
  },
}
std = 'lua51+nvim'

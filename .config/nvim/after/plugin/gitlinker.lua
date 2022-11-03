local status, gitlinker = pcall(require, 'gitlinker')
if not status then
  return
end

gitlinker.setup {
  callbacks = {
    ['gitlab.ftven.net'] = require('gitlinker.hosts').get_gitlab_type_url,
  },
}

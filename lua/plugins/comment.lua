-- 注释插件

return {
    'numToStr/Comment.nvim',
    dependencies= {
      "JoosepAlviste/nvim-ts-context-commentstring" -- 注释jsx , tsx
    },
    opts = {},
    config = function ()
      require('Comment').setup{
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook() -- 注释jsx , tsx
      }
    end
}

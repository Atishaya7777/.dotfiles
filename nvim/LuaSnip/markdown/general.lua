-- Snippets for general markdown files

local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt

local date = function()
  return os.date '%Y-%m-%d'
end

return {
  s({
    trig = 'mlink',
    namr = 'markdown_link',
    dscr = 'Create markdown link [txt](url)',
  }, {
    t '[',
    i(1),
    t '](',
    f(function(_, snip)
      return snip.env.TM_SELECTED_TEXT[1] or {}
    end, {}),
    t ')',
    i(0),
  }),

  s({
    trig = 'meta',
    namr = 'Metadata',
    dscr = 'Yaml metadata format for markdown',
  }, {
    t { '---', 'title: ' },
    i(1, 'note_title'),
    t { '', 'author: ' },
    i(2, 'author'),
    t { '', 'date: ' },
    f(date, {}),
    t { '', 'categories: [' },
    i(3, ''),
    t { ']', 'lastmod: ' },
    f(date, {}),
    t { '', 'tags: [' },
    i(4),
    t { ']', 'comments: true', '---', '' },
    i(0),
  }),
}

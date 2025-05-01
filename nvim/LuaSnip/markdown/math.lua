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

  s({ trig = ';a' }, {
    t '\\alpha',
  }),

  s({ trig = ';b' }, {
    t '\\beta',
  }),

  s({ trig = ';g' }, {
    t '\\gamma',
  }),

  s({ trig = ';e' }, {
    t '\\epsilon',
  }),

  s({ trig = 'mm', dscr = 'Inline math mode' }, fmt('$<>$', { i(1) }, { delimiters = '<>' })),

  s({ trig = 'tt', dscr = 'Expand to texttt' }, fmt('\\texttt{<>}', { i(1) }, { delimiters = '<>' })),

  -- \frac shall not be annoying henceforth
  s({ trig = 'ff', dscr = 'Snippet for \frac{}{}' }, fmt('\\frac{<>}{<>}', { i(1), i(2) }, { delimiters = '<>' })),

  -- Nor shall \dfrac
  s({ trig = 'dff', dscr = 'Snippet for dfrac{}{}' }, fmt('\\dfrac{<>}{<>}', { i(1), i(2) }, { delimiters = '<>' })),

  -- Ceil and Floor functions yay!
  s({ trig = 'ceil', dscr = 'Snippet for adding the ceiling brackets' }, fmt('\\left\\lceil<>\\right\\rceil', { i(1) }, { delimiters = '<>' })),
  s({ trig = 'floor', dscr = 'Snippet for adding the floor brackets' }, fmt('\\left\\lfloor<>\\right\\rfloor', { i(1) }, { delimiters = '<>' })),

  -- Star function for family of coclique
  s(
    { trig = 'star', dscr = 'Snippet that generates the Star definition as a family of coclique' },
    fmt('\\mathcal{I}^<>_<>', { i(1), i(2) }, { delimiters = '<>' })
  ),

  -- Snippets for commonly used mathbb symbols
  s({ trig = 'bbn', dscr = 'Snippet for \\mathbb{N}' }, t '\\mathbb{N}'),
  s({ trig = 'bbz', dscr = 'Snippet for \\mathbb{Z}' }, t '\\mathbb{Z}'),
  s({ trig = 'bbr', dscr = 'Snippet for \\mathbb{R}' }, t '\\mathbb{R}'),
  s({ trig = 'bbc', dscr = 'Snippet for \\mathbb{C}' }, t '\\mathbb{C}'),
  s({ trig = 'bbq', dscr = 'Snippet for \\mathbb{Q}' }, t '\\mathbb{Q}'),
}

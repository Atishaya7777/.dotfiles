-- Snippets for math stuff

local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require 'luasnip.util.events'
local ai = require 'luasnip.nodes.absolute_indexer'
local extras = require 'luasnip.extras'
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local conds = require 'luasnip.extras.expand_conditions'
local postfix = require('luasnip.extras.postfix').postfix
local types = require 'luasnip.util.types'
local parse = require('luasnip.util.parser').parse_snippet
local ms = ls.multi_snippet
local k = require('luasnip.nodes.key_indexer').new_key

return {
  -- Examples of Greek letter snippets, autotriggered for efficiency
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

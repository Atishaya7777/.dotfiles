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
    t '\\varepsilon',
  }),

  s({ trig = ';p' }, {
    t '\\varphi',
  }),

  s({ trig = ';d' }, {
    t '\\delta',
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
  s({ trig = 'bbl', dscr = 'Snippet for \\mathbb{L}' }, t '\\mathbb{L}'),
  s({ trig = 'calC', dscr = 'Snippet for \\mathcal{C}' }, t '\\mathcal{C}'),
  s({ trig = 'calP', dscr = 'Snippet for \\mathcal{P}' }, t '\\mathcal{P}'),
  s({ trig = 'calO', dscr = 'Snippet for \\mathcal{O}' }, t '\\mathcal{O}'),

  -- Snippets for abstract algebra
  s({ trig = 'hom', dscr = 'Snippet for homomorphism' }, t 'homomorphism'),
  s({ trig = 'iso', dscr = 'Snippet for isomorphism' }, t 'isomorphism'),

  -- Partial derivatives
  s(
    { trig = 'pd', dscr = 'Snippet for partial derivative \\partial' },
    fmt('\\frac{{\\partial {<>}}}{{\\partial {<>}}}', { i(1, 'f'), i(2, 'x') }, { delimiters = '<>' })
  ),

  s(
    { trig = 'dpd', dscr = 'Snippet for display partial derivative \\dfrac' },
    fmt('\\dfrac{{\\partial {<>}}}{{\\partial {<>}}}', { i(1, 'f'), i(2, 'x') }, { delimiters = '<>' })
  ),

  -- Second-order partial derivatives
  s(
    { trig = 'p2d', dscr = 'Snippet for second-order partial derivative \\partial^2' },
    fmt('\\frac{{\\partial^2 {<>}}}{{\\partial {<>}^2}}', { i(1, 'f'), i(2, 'x') }, { delimiters = '<>' })
  ),

  s(
    { trig = 'dp2d', dscr = 'Snippet for display second-order partial derivative \\dfrac{\\partial^2}' },
    fmt('\\dfrac{{\\partial^2 {<>}}}{{\\partial {<>}^2}}', { i(1, 'f'), i(2, 'x') }, { delimiters = '<>' })
  ),

  -- Mixed partial derivatives
  s(
    { trig = 'pmd', dscr = 'Snippet for mixed partial derivative \\partial^2/\\partial x \\partial y' },
    fmt('\\frac{{\\partial^2 {<>}}}{{\\partial {<>} \\, \\partial {<>}}}', { i(1, 'f'), i(2, 'x'), i(3, 'y') }, { delimiters = '<>' })
  ),

  s(
    { trig = 'dpmd', dscr = 'Snippet for display mixed partial derivative \\dfrac{\\partial^2}{\\partial x \\partial y}' },
    fmt('\\dfrac{{\\partial^2 {<>}}}{{\\partial {<>} \\, \\partial {<>}}}', { i(1, 'f'), i(2, 'x'), i(3, 'y') }, { delimiters = '<>' })
  ),

  s({ trig = 'lr()', dscr = 'Snippet for attaching left and right to paranthesis' }, fmt('\\left(<>\\right)', { i(1) }, { delimiters = '<>' })),

  s({ trig = 'lr[]', dscr = 'Snippet for attaching left and right to big brackets' }, fmt('\\left[<>\\right]', { i(1) }, { delimiters = '<>' })),

  s({ trig = 'lr||', dscr = 'Snippet for attaching left and right to absolute values' }, fmt('\\left|<>\\right|', { i(1) }, { delimiters = '<>' })),

  s({ trig = 'sup', dscr = 'Snippet for making the supremum be an operatorname' }, fmt('\\operatorname{sup}_{<>}', { i(1) }, { delimiters = '<>' })),
  s({ trig = 'inf', dscr = 'Snippet for making the infimum be an operatorname' }, fmt('\\operatorname{inf}_{<>}', { i(1) }, { delimiters = '<>' })),
  s({ trig = 'limsup', dscr = 'Snippet for making the limit supremum be an operatorname' }, fmt('\\operatorname{\\lim \\;sup}_{<>}', { i(1) }, { delimiters = '<>' })),
  s({ trig = 'liminf', dscr = 'Snippet for making the limit infimum be an operatorname' }, fmt('\\operatorname{\\lim \\;inf}_{<>}', { i(1) }, { delimiters = '<>' })),
  s({ trig = 'esssup', dscr = 'Snippet for making the essential supremum be an operatorname' }, fmt('\\operatorname{ess \\; sup}_{<>}', { i(1) }, { delimiters = '<>' })),

  s({ trig = 'max', dscr = 'Snippet for making the max be an operatorname' }, fmt('\\operatorname{max}_{<>}\\{<>\\}', { i(1), i(2) }, { delimiters = '<>' })),
  s({ trig = 'min', dscr = 'Snippet for making the min be an operatorname' }, fmt('\\operatorname{min}_{<>}\\{<>\\}', { i(1), i(2) }, { delimiters = '<>' })),

  s({ trig = 'bigcup', dscr = 'Snippet for making the bigcup be in display mode' }, fmt('\\displaystyle\\bigcup_{<>}^{<>}', { i(1), i(2) }, { delimiters = '<>' })),
  s({ trig = 'bigcap', dscr = 'Snippet for making the bigcap be in display mode' }, fmt('\\displaystyle\\bigcap_{<>}^{<>}', { i(1), i(2) }, { delimiters = '<>' })),

  s({ trig = 'lim', dscr = 'Snippet for making the limit be in display mode' }, fmt('\\displaystyle\\lim_{<>}', { i(1) }, { delimiters = '<>' })),

  s({ trig = 'len', dscr = 'Snippet for making the len be in mathrm' }, t '\\mathrm{len}'),
}

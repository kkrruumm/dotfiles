" Vim color file
" Name: bummer 

set background=dark
highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "bummer"

" Helper function for setting highlights
function! s:h(group, fg, bg, attr)
  let l:attr = a:attr != "" ? "gui=" . a:attr : "gui=NONE"
  let l:fg = a:fg != "" ? "guifg=" . a:fg : "guifg=NONE"
  let l:bg = a:bg != "" ? "guibg=" . a:bg : "guibg=NONE"
  execute "highlight " . a:group . " " . l:fg . " " . l:bg . " " . l:attr
endfunction

" Palette
let s:base00 = "#070707"
let s:base01 = "#121212"
let s:base02 = "#303030"
let s:base03 = "#505050"
let s:base04 = "#b0b0b0"
let s:base05 = "#d0d0d0"
let s:base06 = "#e0e0e0"
let s:base07 = "#f5f5f5"
let s:base08 = "#fb9fb1"
let s:base09 = "#eda987"
let s:base0A = "#ddb26f"
let s:base0B = "#acc267"
let s:base0C = "#12cfc0"
let s:base0D = "#6fc2ef"
let s:base0E = "#e1a3ee"
let s:base0F = "#deaf8f"

" Editor UI
call s:h("Normal",       s:base05, s:base00, "")
call s:h("Cursor",       s:base00, s:base05, "")
call s:h("CursorLine",   "",       s:base01, "")
call s:h("LineNr",       s:base02, s:base00, "")
call s:h("CursorLineNr", s:base04, s:base01, "")
call s:h("ColorColumn",  "",       s:base01, "")
call s:h("VertSplit",    s:base02, s:base02, "")
call s:h("StatusLine",   s:base04, s:base01, "none")
call s:h("StatusLineNC", s:base03, s:base01, "none")
call s:h("Visual",       "",       s:base02, "")
call s:h("Search",       s:base00, s:base0A, "")

" Syntax Highlighting
call s:h("Comment",      s:base03, "",       "italic")
call s:h("Constant",     s:base09, "",       "")
call s:h("String",       s:base0B, "",       "")
call s:h("Number",       s:base09, "",       "")
call s:h("Identifier",   s:base08, "",       "none")
call s:h("Function",     s:base0D, "",       "")
call s:h("Statement",    s:base0E, "",       "none")
call s:h("Operator",     s:base05, "",       "none")
call s:h("PreProc",      s:base0A, "",       "")
call s:h("Type",         s:base0A, "",       "none")
call s:h("Special",      s:base0C, "",       "")
call s:h("Error",        s:base08, "",       "italic")
call s:h("Todo",         s:base0A, s:base01, "bold")

" Clean up variables
delfunction s:h

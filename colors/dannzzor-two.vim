set background=dark
highlight clear
if exists("syntax on")
	syntax reset
endif
let g:colors_name="dannzzor-two"
hi Normal guifg=#4dc0e3 guibg=#1f2329
hi Comment guifg=#6e6e6e guibg=NONE
hi Constant guifg=#d2db4f guibg=NONE
hi String guifg=#e8e8e8 guibg=NONE
hi htmlTagName guifg=#ff47b8 guibg=NONE
hi Identifier guifg=#9452ff guibg=NONE
hi Statement guifg=#ed5151 guibg=NONE
hi PreProc guifg=#b245ff guibg=NONE
hi Type guifg=#625ee0 guibg=NONE
hi Function guifg=#ff3d7e guibg=NONE
hi Repeat guifg=#ff8b33 guibg=NONE
hi Operator guifg=#fcd256 guibg=NONE
hi Error guibg=#ff0000 guifg=#ffffff
hi TODO guibg=#0011ff guifg=#ffffff
hi link character	constant
hi link number	constant
hi link boolean	constant
hi link Float		Number
hi link Conditional	Repeat
hi link Label		Statement
hi link Keyword	Statement
hi link Exception	Statement
hi link Include	PreProc
hi link Define	PreProc
hi link Macro		PreProc
hi link PreCondit	PreProc
hi link StorageClass	Type
hi link Structure	Type
hi link Typedef	Type
hi link htmlTag	Special
hi link Tag		Special
hi link SpecialChar	Special
hi link Delimiter	Special
hi link SpecialComment Special
hi link Debug		Special

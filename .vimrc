" disable vi settings
set nocompatible 

" Turn on syntax highlighting
syntax on

" Stops autoindent from borking a paste
set pastetoggle=<F5>

" Setup tabs for 4 spaces
set tabstop=4 
set shiftwidth=4
set softtabstop=4
set textwidth=78
set smarttab
set shiftround
set expandtab

" Setup indenting
set autoindent
set smartindent

set backspace=indent,eol,start

" Show matching [] and {}
set showmatch

" Spell check on
set spell spelllang=en_us
setlocal spell spelllang=en_us

" Toggle spelling with the F7 key
nn <F7> :setlocal spell! spelllang=en_us<CR>
imap <F7> <C-o>:setlocal spell! spelllang=en_us<CR>

" Spelling
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

" where it should get the dictionary files
let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'

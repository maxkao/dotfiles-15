filetype plugin indent off

" Able to control mouse
set mouse=a

" Use true colors on terminal
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Every launguage paths
if isdirectory(expand('$PYENV_ROOT' .'/versions/nvim-python2/bin'))
  let g:python_host_prog = expand('$PYENV_ROOT' . '/versions/nvim-python2/bin/python')
endif
if isdirectory(expand('$PYENV_ROOT' . '/versions/nvim-python3/bin'))
  let g:python3_host_prog = expand('$PYENV_ROOT' . '/versions/nvim-python3/bin/python')
endif
let g:ruby_host_prog = expand('$RBENV_ROOT/shims/ruby')

" Combine clipboard
set clipboard+=unnamedplus

" Displays title and line number
set title
set number

" Multi byte character config
set ambiwidth=double

" Do not make swapfile
set noswapfile

set list
set listchars=tab:>-,trail:*,nbsp:+

set smartindent

set expandtab
set tabstop=2
set shiftwidth=2

" Paste command in correctly
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" Reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

let $CACHE = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let $DATA = empty($XDG_DATA_HOME) ? expand('$HOME/.local/share') : $XDG_DATA_HOME

function! s:load(file) abort
  let s:path = expand('$CONFIG/nvim/rc/' . a:file . '.vim')

  if filereadable(s:path)
    execute 'source' fnameescape(s:path)
  endif
endfunction

call s:load('plugins')

" Remapping jj to escape
inoremap <silent> jj <ESC>
filetype plugin indent on
syntax on

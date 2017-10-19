if &compatible
  set nocompatible
endif

set rtp^=.
set noswapfile
set tabstop=2
set shiftwidth=2
set expandtab
set secure
set number
set path+=**
set wildmenu
set autoread
au CursorHold * checktime
filetype plugin indent on

" themes
syntax on
colorscheme onedark

" netrw
let g:netrw_banner = 0
let g:netrw_browse_split = 4  " Previous window
let g:netrw_altv = 1
let g:netrw_winsize = 22
let g:netrw_liststyle = 3

" plugins
let xedp = systemlist('readlink -f "/usr/bin/xed" | sed "s/\(.*\)\/.*/\1/"')[0]
let mpwd = xedp . '/plugged'
let mgocode = xedp . '/plugged/gocode/nvim/symlink.sh'
call plug#begin(mpwd)
  Plug 'itchyny/lightline.vim'

  " autocomplete
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  
  " go
  Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': mgocode } 
  Plug 'zchee/deoplete-go', { 'do': 'make'}
  Plug 'fatih/vim-go'

  " ts
  Plug 'mhartington/nvim-typescript'
  Plug 'HerringtonDarkholme/yats.vim'

call plug#end()

" statusbar themes
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }

" commands
command! -register MakeTags !ctags -R .

" deo
let g:deoplete#enable_at_startup = 1

" go
let g:go_fmt_command = "goimports"
let g:go_term_mode = "split"
let g:go_metalinter_autosave = 1

" Workspaces
function! DevWorkspace()
  let g:netrw_list_hide = netrw_gitignore#Hide()

  execute ":Vexplore"
  normal! gg
  wincmd l
  sp
  wincmd j
  terminal
  file Console
  resize 10
  tnoremap <Esc> <C-\><C-n>
  wincmd k
endfunction
command! -register Dev call DevWorkspace()


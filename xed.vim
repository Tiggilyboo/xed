if &compatible
  set nocompatible
endif

let xedp = systemlist('readlink -f "/usr/bin/xed" | sed "s/\(.*\)\/.*/\1/"')[0]
set rtp^=xedp
set noswapfile
set tabstop=2
set shiftwidth=2
set expandtab
set secure
set number
set path+=**
set wildmenu
set autoread
set noshowmode
set encoding=utf-8
au CursorHold * checktime
filetype plugin on
filetype plugin indent on

" netrw
let g:netrw_banner = 0
let g:netrw_browse_split = 4  " Previous window
let g:netrw_altv = 1
let g:netrw_winsize = 22
let g:netrw_liststyle = 3

" plugins
let mpwd = xedp . '/plugged'
let mgocode = xedp . '/plugged/gocode/nvim/symlink.sh'
call plug#begin(mpwd)
  " themes
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'joshdick/onedark.vim'
  Plug 'KriiV/airline-onedark.vim'

  " autocomplete
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  
  " git
  Plug 'tpope/vim-fugitive'

  " go
  Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': mgocode } 
  Plug 'zchee/deoplete-go', { 'do': 'make' }
  Plug 'sebdah/vim-delve', { 'for': 'go' }

  " dart
  Plug 'dart-lang/dart-vim-plugin'

  " ts
  Plug 'mhartington/nvim-typescript'
  Plug 'HerringtonDarkholme/yats.vim'

  " sql
  Plug 'vim-scripts/dbext.vim', { 'for': 'sql' }

  " html / css
  Plug 'mattn/emmet-vim'

  " cshtml
  Plug 'adamclerk/vim-razor', { 'for': 'cshtml' }
call plug#end()

" themes
syntax on
colorscheme onedark

" vim-airline
let g:airline_theme='onedark'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline_symbols = {}
" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_detect_whitespace=0
let g:airline_section_warning=''

" commands
command! -register MakeTags !ctags -R .

" deo
let g:deoplete#enable_at_startup = 1

" go
let g:go_fmt_command = "goimports"
let g:go_term_mode = "split"
let g:go_metalinter_autosave = 1

" delve
let g:delve_new_command = "new"

" Fixes: https://github.com/neovim/neovim/issues/5990
let $VTE_VERSION="100"
set guicursor=

" emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css,cshtml EmmetInstall

" dart
let dart_html_in_string=v:true
let dart_style_guide = 2

" remaps
tnoremap <Esc> <C-\><C-n>
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

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
  
  wincmd k
endfunction
command! -register Dev call DevWorkspace()


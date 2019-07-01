" Terminal setup
set t_Co=256

" Plugin setup
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'jeffkreeftmeijer/vim-dim'
Plug 'noahfrederick/vim-noctu'
Plug 'rhysd/vim-clang-format'
Plug 'vim-scripts/grep.vim'
Plug 'mhinz/vim-grepper'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Yggdroot/indentLine'
call plug#end()

" coc.nvim config
let g:coc_node_path = "/home/d064754/down/node-v10.16.0-linux-x64/bin/node"
set hidden
set updatetime=200
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" ClangFormat
nnoremap F :ClangFormat<CR>

" fix lightline issue with single window
set laststatus=2

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ],
      \ }
      \ }

" Key bindings
nnoremap <silent> ; :FZF <C-R>=getcwd()<CR><CR>
nnoremap <silent> + :Rg <C-R><C-W><CR>


" Commands
command GrepWordUnderCursor :Rg <C-R><C-W><CR><CR>

" Appearance
syntax on
colorscheme noctu
set cursorline
hi CursorLine cterm=NONE ctermbg=236 ctermfg=NONE 
hi SpellBad ctermbg=52
set number

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent

set cursorline
set hlsearch
set is
nnoremap <esc> :noh<return><esc>

" Enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

au BufNewFile,BufRead *.cpp,*.cc,*.hpp,*.h,*.c set foldmethod=syntax

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" learning mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

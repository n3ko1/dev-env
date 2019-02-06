" Terminal setup
set t_Co=256

" Plugin setup
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'Valloric/YouCompleteMe'
Plug 'nanotech/jellybeans.vim'
Plug 'jeffkreeftmeijer/vim-dim'
Plug 'rhysd/vim-clang-format'
Plug 'vim-scripts/grep.vim'
Plug 'nvie/vim-flake8'
Plug 'mhinz/vim-grepper'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
call plug#end()

" YouCompleteMe config
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_server_python_interpreter = '/usr/bin/python'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_goto_buffer_command = 'same-buffer'

" LanguageServer config
set hidden

let g:LanguageClient_serverCommands = {
    \ 'cpp': ['cquery',
        \ '--log-file=/data/d064754/cquery/cq.log',
        \ '--init={"cacheDirectory":"/data/d064754/cquery/cache"}'],
    \ 'python': ['pyls']
\ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <C-g> :call LanguageClient#textDocument_definition()<CR>

" fix lightline issue with single window
set laststatus=2

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ],
      \ }
      \ }

" Key bindings
nnoremap <silent> ; :FZF <C-R>=getcwd()<CR><CR>
" nnoremap <C-g> :YcmCompleter GoToDefinitionElseDeclaration<CR><CR>

" Commands
command GrepWordUnderCursor :Grepper -tool rg -query <C-R><C-W><CR><CR>

" Appearance
syntax on
colorscheme dim
set cursorline
hi CursorLine term=bold cterm=bold guibg=Black
set number

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent

set hlsearch
set is
" nnoremap <esc> :noh<return><esc>

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

autocmd BufWritePost *.py call Flake8()

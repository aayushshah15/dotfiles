set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'Yggdroot/indentLine'
Plugin 'zxqfl/tabnine-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'liuchengxu/space-vim-theme'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'flrnprz/plastic.vim'
Plugin 'iandingx/leetcode.vim'
Plugin 'google/vim-maktaba'
Plugin 'scrooloose/nerdtree'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'python/black'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
call vundle#end()
call glaive#Install()
filetype plugin indent on
execute pathogen#infect()
call pathogen#helptags()

syntax on
hi Comment cterm=italic
set termguicolors
set background=dark
colo space_vim_theme

autocmd BufWritePre * :%s/\s+$//e

:set cindent
:set shiftwidth=2
:set expandtab
:set foldmethod=indent
:set foldlevel=1
:set nofoldenable
:set lazyredraw
set cindent
set ignorecase
set nohlsearch
set autoindent
set mouse=a

map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>
map ; :Files<cr>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
vmap <C-c> "+y
nnoremap <leader>ls :LeetCodeSubmit<cr>
nnoremap <leader>fmt :FormatCode<cr>
nnoremap <leader>lc :LeetCodeList<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>bf :Black<cr>
nnoremap <leader>gd :Gdiff<cr>

nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>

noremap <C-e> :NERDTreeToggle<CR>
highlight Comment cterm=italic gui=italic
set rtp+=/usr/local/opt/fzf
let g:leetcode_solution_filetype='python3'
let g:leetcode_username='a84shah@uwaterloo.ca'
let g:jedi#completions_enabled=0

" using Source Code Pro
set encoding=utf-8
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

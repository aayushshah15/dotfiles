set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
Plugin 'zxqfl/tabnine-vim'
Plugin 'liuchengxu/space-vim-dark'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'Yggdroot/indentLine'
Plugin 'octol/vim-cpp-enhanced-highlight'
call vundle#end()
filetype plugin indent on
execute pathogen#infect()
call pathogen#helptags()
map <C-n> :NERDTreeToggle<CR>

syntax enable
set background=dark
colorscheme solarized

:set cindent
:set shiftwidth=2
:set expandtab
:set relativenumber

map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

"filetype off
"call pathogen#runtime_append_all_bundles()
"filetype plugin indent on
 
set nocompatible
 
syntax on
filetype on
filetype plugin on
filetype indent on

set hidden
set backspace=indent,eol,start
 
set autoindent
set encoding=utf-8
set history=1000
set laststatus=2
set showmode
set showcmd
set ruler
set scrolloff=3
 
set wildmenu
set wildmode=list:longest
set visualbell
 
set cursorline
set number
 
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
 
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)
 
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab



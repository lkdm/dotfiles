set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching
set ignorecase              " case insensitive
set hlsearch                " highlight search
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
set ttyfast                 " Speed up scrolling in Vim
" set cursorline              " highlight current cursorline
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.

:set so=999                 " Keep the cursor in the centre of the screen

" Performance for large files.
set lazyredraw		    " Limits redrawing. Perf for large files.
set regexpengine=1	    " Use old rendering engine. Perf for large files.

" Developer
set statusline=%f%m%=%y\ 0x%B\ %l:%c\ %p%%      " Create a statusline at the bottom `:help statusline`
set path+=**
set hidden " Enable hidden files
set wildmenu " Display all matching files when we tab complete

" Javascript / Typscript
set wildignore+=*node_modules*

" Create a `tags` file.
command! MakeTags !ctags -R .

" FILE BROWSING
" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" :set wrap               " Sets softwrap. Good for writing lit


" Monochrome theme
set termguicolors
set bg=dark
colorscheme quiet
highlight Keyword gui=bold
highlight Comment gui=italic
highlight Constant guifg=#999999
highlight NormalFloat guibg=#333333

" Rust
autocmd Filetype rs set comments^=:///

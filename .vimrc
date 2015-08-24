filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

set hlsearch
command C let @/="" " Clear search term

set ignorecase
set smartcase

syntax enable

set statusline=%f         " Path to the file
set statusline+=\ -\      " Separator
set statusline+=FileType: " Label
set statusline+=%y        " Filetype of the file
set statusline+=%l    " Current line
set statusline+=\ -\      " Separator
set statusline+=%L   " Total lines
set laststatus=2

set autochdir

colorscheme darkblue

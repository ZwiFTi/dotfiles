set runtimepath+=~/.vim_runtime

"For vim-wiki"
set nocompatible
filetype plugin on
syntax on


source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

try
source ~/.vim_runtime/my_configs.vim
catch
endtry

set expandtab "use softtabstop spaces instead of tab characters for indentation"
set shiftwidth=4 "indent by 4 spaces when using >>, <<, == etc"
set softtabstop=4 "indent by 4 spaces when pressing tab"
set tabstop=4


set autoindent "keep indentation from previous line"
set smartindent "automatically inserts indentation in some cases"
set cindent "Like smartindent, but stricter and more customisable"

set number "gives numbers on the left hand side"
set relativenumber "gives rel. number on left hand side"
set bg=dark "keep wim dark"
set mouse=a

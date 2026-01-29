" 高亮显示
syntax on
" 显示行号
set nu
" 自动缩进
set autoindent
" 启用空格缩进
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4


inoremap jk <Esc>
nnoremap ; :
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

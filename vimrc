"winpos 5 5		" 设定窗口位置  
"set lines=40 columns=155	" 设定窗口大小 

"启动的时候不显示那个援助索马里儿童的提示
set shortmess=atI

syntax on	 	" 语法高亮
syntax enable	" 语法高亮

set cul			" 高亮光标所在行
set cuc			" 高亮光标所在列
color ron		" 设置背景主题 desert/torte/ron
autocmd InsertLeave * se nocul	" 用浅色高亮当前行
autocmd InsertEnter * se cul	" 用浅色高亮当前行

"set foldmethod=marker           " 代码缩进折叠
"set foldmethod=indent           " 代码缩进折叠
"set foldmethod=manual           " 代码手动折叠

set hlsearch	" 高亮查找
set incsearch   " 逐字高亮
set showmatch   " 显示匹配的括号
set ignorecase  " 搜索忽略大小写
set matchtime=1 " 匹配括号高亮时间

set ai          " 自动缩进
set si          " 智能缩进
set autoindent	" 自动缩进
set nu			" 显示行号number

"set smarttab        " 在行和段开始处使用制表符
"set shiftwidth=4    " 统一缩进为4  
"set softtabstop=4   " 统一缩进为4 
set tabstop=4       " 制表符为4
set expandtab     " 用空格代替制表符

" 状态栏
set laststatus=2	" 启动显示状态行(1)，总是显示状态行(2)
"highlight StatusLine  ctermfg=green ctermbg=black
" 状态栏颜色
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")} " 状态行显示的内容  
set cmdheight=1 " 命令行高度（状态栏下）

"set whichwrap+=<,>,h,l " 允许backspace和光标键跨越行边界(不建议)
"set novisualbell " 不要闪烁(不明白)  

set showcmd		" 显示输入的命令
set ruler		" 显示标尺
set history=300 " history文件记录
"set cindent 	" C/C++样式自动缩进
"set smartindent " C程序自动缩进
set formatoptions=tcrqn	" 自动格式化

" 语言设置
set langmenu=zh_CN.UTF-8
set helplang=cn

" 设置字符集编码，默认使用utf8
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
" set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
"set fileencoding=utf-8

set nobackup    " 关闭备份
set noswapfile  " 禁止生成临时文件
set autowrite	" 自动保存

" C,C++编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!gcc % -o %<"
		exec "! ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "! ./%<"
	elseif &filetype == 'python'
		exec "!python2 %"
	elseif &filetype == 'java' 
		exec "!javac %" 
		exec "!java %<"
	elseif &filetype == 'sh'
		:!bash %
	endif
endfunc

" C,C++调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	exec "!g++ % -g -o %<"
	exec "!gdb ./%<"
endfunc

set completeopt=preview,menu	" 代码补全
filetype on						" 检测文件类型
filetype plugin indent on

" 自动补全
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

autocmd FileType html set tabstop=2 shiftwidth=2 expandtab
autocmd FileType htmldjango set tabstop=2 shiftwidth=2 expandtab
autocmd BufNewFile *.cpp,*.c,*.sh,*.java,*.py exec ":call SetTitle()" 
" 定义函数SetTitle，自动插入文件头 
func SetTitle()

	if &filetype == 'sh'
		call setline(1,"\#!/bin/bash")
		call append(line("."),"")
	elseif &filetype == 'python' 
		call setline(1,"#!/usr/bin/env python2")
		call append(line("."),"\# -*- coding: utf-8 -*-")
		call append(line(".")+1,"")
	endif

	if &filetype == 'cpp'
        call setline(1,"#include <iostream>")
		call append(line("."),"#include <algorithm>")
		call append(line(".")+1,"")
		call append(line(".")+2,"using namespace std;")
		call append(line(".")+3,"")
	endif

	if &filetype == 'c'
        call setline(1,"#include <stdio.h>")
		call append(line("."),"#include <string.h>")
		call append(line(".")+1,"")
	endif

endfunc
" 自动定位到文件末尾
autocmd BufNewFile * normal G
" 键盘命令
map <C-A> ggVG$"+y
vmap <C-c> "+y
:map <F10> :set paste<CR>
:map <F9> :set nopaste<CR>

execute pathogen#infect()
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" 为C程序提供自动缩进
set smartindent 
" "代码补全
set completeopt=preview,menu 
filetype plugin indent on 
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap < <><ESC>i
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
"打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu 

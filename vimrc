set nocompatible              " required

" New help-doc update is followed
" move from vim to neovim, here is something that's needed to pay attention
" directory mapping relationship:
" ~/.config/nvim/init.vim -> ~/.vim/vimrc
" ~/.config/nvim/ -> ~/.vim
" Done, next is old help-doc
" vim-plug 简要帮助文档
" [Command]                             [Description]
" PlugInstall [name ...] [#threads]   Install plugins
" PlugUpdate [name ...] [#threads]    Install or update plugins
" PlugClean[!]                        Remove unused directories
" PlugUpgrade                         Upgrade vim-plug itself
" PlugStatus                          Check the status of plugins
" PlugDiff                            Examine changes from the previous update and the pending changes
" PlugSnapshot[!] [output path]       Generate script for restoring the current snapshot of the plugins
"

call plug#begin('~/.vim/plugged')

" Add all your plugins here
" Plugin go here

" Files search
Plug 'Yggdroot/LeaderF', { 'do': './install.sh', 'on': 'LeaderfFunction!' }
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<m-n>' " alt-n
noremap <c-n> :LeaderfMru<cr>
noremap <m-p> :LeaderfFunction!<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
" Plug 'majutsushi/tagbar'
" taglist open/close
" map <silent> <F9> :TagbarToggle<cr>
" let g:tagbar_sort=0 "tags sorted according to their order in the source file

" Plug 'tmhedberg/SimpylFold', { 'for': 'python' } " 文档折叠 help doc: fold-commands
" 代码折叠 Enable folding, use plug above, no need it
" set foldmethod=indent
" set foldlevel=99

Plug 'vim-scripts/indentpython.vim', { 'for': 'python' } "自动缩进

" 异步语法检查ale, 配合一系列linter工具,如：
" check on https://github.com/w0rp/ale#supported-languages for more info
Plug 'w0rp/ale'
let g:ale_sign_column_always = 1 "保持侧边栏可见
" 改变错误和警告标示符，下同
let g:ale_sign_error = '✹'
let g:ale_sign_warning = '⚠ '
" " backup option: '•'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok'] "改变状态栏信息格式
let g:ale_echo_msg_error_str = '✹ Error' "改变命令行信息，下同
let g:ale_echo_msg_warning_str = '⚠ Warning'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" 文件浏览 File browsing, NERDTree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
"NERDTree快捷键
map <F3> :NERDTreeToggle<cr>

" Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'Valloric/YouCompleteMe'
augroup load_ycm
  autocmd!
  autocmd CursorHold, CursorHoldI * :packadd YouCompleteMe
                                \ | autocmd! load_ycm
augroup END

let g:ycm_autoclose_preview_window_after_completion=1       " 确保自动补全窗口不消失
set runtimepath+=~/.vim/plugged/YouCompleteMe
let g:ycm_collect_identifiers_from_tags_files = 1           " 开启 YCM 基于标签引擎
let g:ycm_seed_identifiers_with_syntax = 1                  " 语法关键字补全
let g:ycm_confirm_extra_conf = 0                            " no need to confirm config file every time
let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']  " 映射按键, 没有这个会拦截掉tab, 导致其他插件的tab不能用.
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
let g:ycm_complete_in_comments = 1                          " 在注释输入中也能补全
let g:ycm_complete_in_strings = 1                           " 在字符串输入中也能补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 注释和字符串中的文字也会被收入补全
let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/.ycm_extra_conf.py' " read the user guide for more info 
let g:ycm_min_num_of_chars_for_completion=2                 " 从第2个键入字符就开始罗列匹配项 
let g:ycm_semantic_triggers =  {
                        \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
                        \ 'cs,lua,javascript': ['re!\w{2}'],
                        \ } " 自动弹出补全，YouCompleteMe 升级为全异步后新特性
" for python semantic completion,
" auto-search the first python interpreter in the PATH
let g:ycm_python_binary_path = 'python3'
let g:ycm_server_python_interpreter = '/usr/bin/python3'
" 要补全的语言
let g:ycm_filetype_whitelist = {
                        \ "asm": 1,
                        \ "c": 1, "cpp": 1, "cs": 1, "ch": 1, "cmake": 1,
                        \ "erlang": 1,
                        \ "html": 1, "haskell": 1, "htmldjango": 1,
                        \ "go": 1,
                        \ "java": 1, "javascript": 1,
                        \ "lua": 1, "lisp": 1, "lex": 1,
                        \ "python": 1, "php": 1, "perl": 1, "prolog": 1,
                        \ "ruby": 1, "rust": 1,
                        \ "sh": 1, "sql": 1,
                        \ "vim": 1,
                        \ "xml":1,
                        \ }
 
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

Plug 'Shougo/echodoc.vim'
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = "virtual"
set noshowmode " for not show vim mode and hints at the command line

Plug 'thinca/vim-quickrun', { 'on': 'QuickRun' }
let g:quickrun_config = {
            \"_": {
            \"outputter" : "quickfix",
            \},
            \}
let g:quickrun_no_default_key_mappings = 1
map <F5> :QuickRun<CR>

" java complete
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
autocmd FileType java setlocal omnifunc=javacomplete#Complete
let g:JavaComplete_EnableDefaultMappings = 0

"command line dictionnary
Plug 'Flowerowl/ici.vim', { 'on': 'Ici' }

"Python Doc generator
Plug 'heavenshell/vim-pydocstring', { 'for': 'python' }
"map <C-m> for command 'pydocstring'
nmap <silent> <C-m> <Plug>(pydocstring)

" show git branch name on tarbar line with lightline plugin
Plug 'itchyny/vim-gitbranch'

"Powerline status 
Plug 'itchyny/lightline.vim'
" show git branch name on barline
let g:lightline = { 
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
let g:go_version_warning = 0

Plug 'Yggdroot/indentLine', { 'for': 'python' }
" All of your Plugins must be added before the following line
" Plugin over
call plug#end()

set backspace=indent,eol,start "退格键删除

" 分割布局 split layouts
set splitbelow
set splitright

" kj 替换 Esc
inoremap kj <Esc>
"L ->回到行尾
map L $
"H ->回到行首
map H 0

" 分屏窗口移动, Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" for # indent, python文件中输入新行时#号注释不切回行首
autocmd BufNewFile,BufRead *.py inoremap # X<c-h>#

" 针对不同文件类型采用不同缩进格式
filetype plugin indent on
autocmd FileType c setlocal shiftwidth=8
autocmd FileType ruby setlocal shiftwidth=2
autocmd FileType python setlocal shiftwidth=4
autocmd FileType html setlocal shiftwidth=2
autocmd FileType htmldjango setlocal shiftwidth=2
autocmd FileType go setlocal shiftwidth=4
autocmd FileType java setlocal shiftwidth=2
autocmd FileType javascript setlocal shiftwidth=2
autocmd FileType sh setlocal shiftwidth=4
autocmd FileType yaml setlocal shiftwidth=2

" PEP8风格的缩进
set tabstop=4 " tab键宽度
set softtabstop=4 " 退格键每次删除4个空格
set textwidth=79
set expandtab
set autoindent
set smartindent
set smarttab " Tab 转空格
" set fileformat=unix " 不强制要求

set encoding=utf-8

set nu "行号
" 突出显示当前行
" set cursorcolumn
" 突出显示当前列
" set cursorline
" 启用鼠标
set mouse=a " mouse-=a to cancel

" Map ; to :and save a million keystrokes 快速进入命令行
nnoremap ; :

" 去掉输入错误的提示声音
set novisualbell
set noerrorbells
set tm=500

"显示当前行号列号
set ruler

set showmatch "括号配对并高亮
set hlsearch "高亮搜索命中
set incsearch "打开即时搜索
set ignorecase "忽略大小写搜索
set smartcase "必要搜索时大小写敏感

" vimrc文件修改之后自动加载, windows
autocmd! bufwritepost _vimrc source %
" vimrc文件修改之后自动加载, linux
autocmd! bufwritepost .vimrc source %

" 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
if has("autocmd")                                                          
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif                                                        
endif

" 保存文件时删除多余行尾空格
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces    ()


" 定义函数，检查文件类型并自动插入文件头
autocmd BufNewFile *.sh,*.py,*.c,*.cpp exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
  if &filetype == 'sh'
    call setline(1, "\#!/bin/bash")
  endif

  if &filetype == 'python'
    call setline(1, "\# -*- coding:utf-8 -*-")
  endif

  if &filetype == 'c'
    call setline(1, "\#include <stdio.h>")
  endif

  if &filetype == 'cpp'
    call setline(1, "\#include <iostream>")
  endif

  normal G
  normal o
  normal o
endfunc

" 语法检查/高亮 Syntax Checking/Highlighting
syntax on

" 配色方案 color schmes
colorscheme molokai

" 背景透明/不透明切换, ctrl+t
let t:is_transparent = 0
function! Toggle_transparent()
        if t:is_transparent == 0
                hi Normal guibg=NONE ctermbg=NONE
                let t:is_transparent = 1
        else
                set background=dark
                let t:is_transparent = 0
        endif
endfunction
nnoremap <C-t> : call Toggle_transparent()<CR>

" Fast splitly open terminal
nnoremap <F4> :split term://zsh<cr>
" exit neovim terminal emulator
tnoremap <Esc> <C-\><C-n>
" tmux color for vim, ensure vim's behavior in shell the same as in tmux
" no longer applicatable for neovim
" set term=screen-256color

" Display a manual page in a nice way.
" help doc for:help man
runtime ftplugin/man.vim

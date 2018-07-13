"   This is the personal .vimrc file of merlin
silent function! OSX()
    return has('macunix')
endfunction
silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
    return  (has('win32') || has('win64'))
endfunction

set nocompatible        " Must be first line
if !WINDOWS()
    set shell=/bin/sh
endif
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" for Vundle
filetype off                  " required

"let vimrc take effect
autocmd! BufWritePost $MYVIMRC source %

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"  Shader Support
Plugin 'http://git.oschina.net/qiuchangjie/ShaderHighLight'
" 缩进提示插件
Plugin 'nathanaelkane/vim-indent-guides' 
" 关键字搜索, 依赖ack-grep
Plugin 'dyng/ctrlsf.vim'
" 光标移动辅助
Plugin 'Lokaltog/vim-easymotion'
" 对齐辅助
Plugin 'godlygeek/tabular'
"!!多光标编辑
Plugin 'terryma/vim-multiple-cursors'
" 代码补全引擎, vim需要支持python的方式编译,插件较大默认不使用
"Plugin 'Valloric/YouCompleteMe'
" Ctrl+p search
Plugin 'ctrlpvim/ctrlp.vim'
" 配色方案
Plugin 'altercation/vim-colors-solarized'
"Plugin 'tomasr/molokai'
" statusbar增强
Plugin 'Lokaltog/vim-powerline'
" 文件树
Plugin 'scrooloose/nerdtree'
"https://github.com/scrooloose/nerdcommenter
Plugin 'scrooloose/nerdcommenter'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-repeat'
"匹配(,",{,[控制
Plugin 'tpope/vim-surround'

"Plugin 'majutsushi/tagbar'
" ==============代码支持插件
" 语法检查
Plugin 'scrooloose/syntastic'
" lua 支持
"Plugin 'xolox/vim-lua-ftplugin'
"Plugin 'xolox/vim-misc'

"=============================

" vim-markdown 也依赖版tabular
"Plugin 'plasticboy/vim-markdown'
" markdown 实时预览, need: python 2/3
" pip install markdown?
" pip install pygemnts?
" 中国人写的，支持下, https://github.com/iamcco/markdown-preview.vim
" Plugin 'iamcco/mathjax-support-for-mkdp'
" Plugin 'iamcco/markdown-preview.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"set fileencodings=ucs-bom,utf-8,utf-16,gbk,chinese,big5,gb18030
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set enc=utf-8
let mapleader=','
" status bar
set laststatus=2
set ruler
set nu
set hlsearch
set incsearch
" ignorecase
set ic
" vim laststatus>=2
" set wildmenu

"  移除gui 菜单
" set cursorline
" set cursorcolumn
" set gcr=a:block-blinkon0
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=m
set guioptions-=T

let g:SimpylFold_docstring_preview=1
let g:netrw_liststyle = 3

syntax enable
syntax on

filetype indent on
set autoindent
" 总是使用空格
set expandtab
set sw=4
set sts=4

set background=dark
"show colorcolumn
set cc=120
" 有gui, 使用的是gvim
if has('gui_running')
    colorscheme solarized
else
    colorscheme desert
endif

" 随 vim 自启动, indent-guides 插件似乎依赖配色方案，自定？
" highlight Normal ctermfg=red ctermbg=yellow
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
:nmap <silent> <LEADER>i <Plug>IndentGuidesToggle
set backspace=indent,eol,start
" set spell
set foldenable
"set nofoldenable
"method also could be syntax
set foldmethod=syntax

" 保存快捷键
if has('mksession') && has('viminfo')
    " 设置环境保存项
    set sessionoptions="blank,buffers,globals,localoptions,tabpages,sesdir,folds,help,options,resize,winpos,winsize"
    " 保存 undo 历史
    set undodir=~/.undo_history/
    set undofile
    map <LEADER>ss :mksession! ~/my.vim<cr> :wviminfo! ~/my.viminfo<cr>
    " 恢复快捷键
    map <LEADER>rs :source ~/my.vim<cr> :rviminfo ~/my.viminfo<cr>
endif
if WINDOWS()
    "解决菜单乱码  
    source $VIMRUNTIME/delmenu.vim  
    source $VIMRUNTIME/menu.vim  
    "解决consle输出乱码  
    language messages zh_CN.utf-8
    "有些符号不支持出现乱码，修改为这个字体
    "set guifont=* 打开字体列表
    set guifont=Consolas:h12
    "let g:ctrlp_user_command = 'dir %s /-n /b /s /a:-d-h'  " Windows
else
    " let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux 
endif
" need ack
" 需要安装ag https://github.com/ggreer/the_silver_searcher
let g:ctrlsf_ackprg = 'ag'
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
nmap     <C-F>c <Plug>CtrlSFCwordPath

let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示
map <LEADER>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
set completeopt=longest,menu

" NERDTree 配置：
" 关闭NERDTree快捷键
map <C-E> :NERDTreeToggle<CR>
map <leader>e :NERDTreeFind<CR>
""当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
""修改树的显示图标
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeAutoCenter=1
" 显示行号
let NERDTreeShowLineNumbers=1
" 是否显示隐藏文件
let NERDTreeShowHidden=0
" 设置宽度
let NERDTreeWinSize=35
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 当没有参数时自动打开
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"窗口移动 
":only :on
map <C-J> <C-w>j
map <C-K> <C-w>k
map <C-H> <C-w>h
map <C-L> <C-w>l
"let g:gitgutter_terminal_reports_focus=0
" 历史文件,存在于viminfo中
nmap <F4> :browse oldfiles<CR>
"let g:syntastic_<filetype>_checkers = ['<checker-name>']
":SyntasticCheck <checker>
":help syntastic-checkers
" Lua config, make sure luac in PATH
" let g:syntastic_lua_checkers = ['luac', 'lua_check']

"execute 'cd' expand('%:h')
nnoremap <silent> <leader>. :cd %:h<CR>
nnoremap <silent> <leader><leader>. :exec("NERDTree ".expand('%:h'))<CR>

" map quick-fix next and previous
"function! Vgrep(pat)
"    let l:ext=expand('%:e')
"    let l:cword=expand('<cword>')
"    let l:cmd1='vimgrep/' . l:cword . '/j '
"    if a:pat
"        let l:cmd2='*.' . l:ext
"    else
"        let l:cmd2='**/*.' . l:ext
"    endif
"    execute l:cmd1 . l:cmd2
"    execute 'copen'
"endfunction
noremap <F6> :silent execute("vimgrep/" . expand("<cword>") . '/j ' . '*.' . expand('%:e'))<CR> \| :copen<CR>
noremap <C-F6> :silent execute("vimgrep/" . expand("<cword>") . '/j ' . '**/*.' . expand('%:e'))<CR> \| :copen<CR>
nmap <F3> :cn<CR>
nmap <S-F3> :cp<CR>
"run shell
nmap <leader>r :!
nmap <leader>ri :r !

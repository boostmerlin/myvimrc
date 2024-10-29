" This is the personal .vimrc file of merlin

let s:code_monkey=0
let g:user_dir='~/.vim'

"---------------------------------------
"           大小写转换
"---------------------------------------
"   g~~ : 行翻转
"   vEU : 字大写(广义字)
"   vE~ : 字翻转(广义字)
"   ~   将光标下的字母改变大小写
"   3~  将下3个字母改变其大小写
"   g~w 字翻转
"   U   将可视模式下的字母全改成大写字母
"   gUU 将当前行的字母改成大写
"   u   将可视模式下的字母全改成小写
"   guu 将当前行的字母全改成小写

"---------------------------------------
"           多文档操作
"---------------------------------------
"    用 :ls! 可以显示出当前所有的buffer
"   :bn                 跳转到下一个buffer
"   :bp                 跳转到上一个buffer
"   :wn                 存盘当前文件并跳转到下一个
"   :wp                 存盘当前文件并跳转到上一个
"   :bd                 把这个文件从buffer列表中做掉
"   :b 3                跳到第3个buffer
"   :b main             跳到一个名字中包含main的buffer

" ---------------------------
"   基础命令
" ---------------------------
"   '.                  它移动光标到上一次的修改行
"   `.                  它移动光标到上一次的修改点
"   .                   重复上次命令
"   <C-o> :             依次沿着你的跳转记录向回跳, 可在文件间跳
"   <C-i> :             依次沿着你的跳转记录向前跳
"   :history :          列出历史命令记录
"   q/ :                搜索命令历史的窗口
"   q: :                命令行命令历史的窗口
"   g ctrl+g            计算文件字符

" ---------------------------
"   tab操作
" ---------------------------
" 普通模式下的 切换标签页 的命令是 gt, gT: go tab
" :tabnew 新建标签
" :tabc 关闭标签, :tabo 关闭其他所有标签 tab other closed

" :tabfirst 切换到第一个标签
" :tablast 切换到最后一个标签
" :tabp = tab previous
" :tabn = tab next

" 查看标签
" :tabs tab show, 或者 tab的复数: tabs
 
" :tabe: tab edit : 在标签页中 打开 文件.

silent function! OSX()
    return has('macunix')
endfunction
silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
    return  (has('win32') || has('win64'))
endfunction
silent function! ASYNC()
    return  (has('nvim') || has('patch-8.0.902'))
endfunction

function! CODER()
    return s:code_monkey == 1
endfunction

set nocompatible        " Must be first line
if !WINDOWS()
    set shell=/bin/sh
endif

"let vimrc take effect
autocmd! BufWritePost $MYVIMRC source %

" use vim-plug, see https://github.com/junegunn/vim-plug
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin()

" undo 历史查看
Plug 'simnalamburt/vim-mundo'

" 剪贴版查看 "
Plug 'junegunn/vim-peekaboo'

" Vim HardTime

Plug 'takac/vim-hardtime'

"  Shader Support
Plug 'http://git.oschina.net/qiuchangjie/ShaderHighLight'
" 缩进提示插件
Plug 'nathanaelkane/vim-indent-guides' 
" 光标移动辅助
Plug 'Lokaltog/vim-easymotion'
" 对齐辅助
Plug 'godlygeek/tabular'
" 多光标编辑
Plug 'terryma/vim-multiple-cursors'

" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'

" Ctrl+p search
Plug 'ctrlpvim/ctrlp.vim'
" 关键字搜索, 依赖ack-grep
Plug 'dyng/ctrlsf.vim'

" 这个很强大，使用rg可以考虑替换 ctrlsf 和 ctrlp
" Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

" 配色方案
if has('gui_running')
    Plug 'altercation/vim-colors-solarized'
else
    Plug 'tomasr/molokai'
endif
" statusbar增强
Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" 文件树
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
"代码注释助手 https://github.com/scrooloose/nerdcommenter
Plug 'scrooloose/nerdcommenter'
" version control status
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-repeat'
"匹配(,",{,[控制
Plug 'tpope/vim-surround'
" auto complete pair
Plug 'jiangmiao/auto-pairs'
" 括号着色
Plug 'luochen1990/rainbow'

Plug 'editorconfig/editorconfig-vim'
" vim-markdown 也依赖版tabular
Plug 'plasticboy/vim-markdown'
" 中国人写的，支持下, https://github.com/iamcco/markdown-preview.vim
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" ==============代码支持插件
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

if CODER()
    " 语法检查
    Plug 'dense-analysis/ale'

    " 新代码补全引擎, see https://github.com/neoclide/coc.nvim
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    
    if has('python3')
        " 代码片段支持
        Plug 'SirVer/ultisnips'
    endif

    " Use <Tab> and <S-Tab> to navigate the completion list
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
endif


" All of your Plugins must be added before the following line
call plug#end()            " required

if WINDOWS()
    " PlugClean
    command! MyPlugClean :set shell=cmd.exe shellcmdflag=/c noshellslash guioptions-=! <bar> noau PlugClean
endif

let g:mapleader = "\<Space>"
let g:maplocalleader = ','
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

"set fileencodings=ucs-bom,utf-8,utf-16,gbk,chinese,big5,gb18030
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set enc=utf-8
" status bar
set laststatus=2
set ruler
set relativenumber
set hlsearch
set incsearch
set shortmess=atI "不显示援助
" Ctrl a/x 递增适用于字母
set nrformats+=alpha

" 使用pP可以操作系统剪贴板，而不是使用*+
set clipboard=unnamed

set ignorecase smartcase
" ignorecase
" set ic
" vim laststatus>=2
set wildmenu
" 启用映射键序列的超时
set timeout
set timeoutlen=800

" set spell
" coc.vim ---
" 该设置项可以无需存盘就可以从某个被修改的文件中切换出去
set hidden
set nobackup
set nowritebackup
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

if has("gui_running")
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
endif

let g:SimpylFold_docstring_preview=1
let g:netrw_liststyle = 3

let g:mkdp_echo_preview_url = 1
" MD 关闭时自动关闭预览
let g:mkdp_auto_close = 1

syntax enable
syntax on
filetype indent on

"设定文件浏览器目录为当前目录
set bsdir=buffer

set smartindent
" 总是使用空格
set expandtab
set smarttab
set sw=4
set sts=4
set lazyredraw

set background=dark
"show colorcolumn
set cc=120
" 有gui, 使用的是gvim
if has('gui_running')
    colorscheme solarized
else
    colorscheme molokai
    let g:rehash256 = 1
    let g:molokai_original = 1
endif

" 随 vim 自启动, indent-guides 插件似乎依赖配色方案，自定？
" highlight Normal ctermfg=red ctermbg=yellow
let g:indent_guides_auto_colors = 1
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
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

if ASYNC()
    " 默认 updatetime 4000ms, 在异步模式下可以加快 
    set updatetime=300
endif

" 保存 undo 历史
set undodir=~/.vim/undo_dir
set undofile
map <LEADER>su :wundo! ~/.vim/undo_dir/history.undo<cr>
map <LEADER>ru :MundoToggle<cr>

" 保存快捷键
if has('mksession') && has('viminfo')
    " 设置环境保存项
    set viewoptions+=options
    set viewoptions+=unix
    set viewdir=$HOME/.vim/view
    map <LEADER>qv :mkview!
    map <LEADER>qlv :loadview!
    set sessionoptions="blank,buffers,globals,localoptions,tabpages,sesdir,folds,help,options,resize,winpos,winsize"
    map <LEADER>qs :mksession! ~/.vim/my.vim<cr> :wviminfo! ~/.vim/my.viminfo<cr>
    autocmd VimLeave * :mksession! ~/.vim/my.vim
    autocmd VimLeave * :wviminfo! ~/.vim/my.viminfo
    " 恢复快捷键
    map <LEADER>ql :source ~/my.vim<cr> :rviminfo ~/my.viminfo<cr>
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
else
endif

" 需要安装ag https://github.com/ggreer/the_silver_searcher
let g:ctrlsf_ackprg = 'ag'
if ASYNC()
    let g:ctrlsf_search_mode = 'async'
endif
let g:ctrlsf_winsize = '45%'
" bottom
let g:ctrlsf_position = 'bottom'

let g:ctrlsf_context = '-B 5 -A 3'

nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
nmap     <C-F>c <Plug>CtrlSFCwordPath

noremap <leader>fb :CtrlPBuffer<CR>
noremap <leader>fm :CtrlPMRU<CR>
noremap <leader>ff :CtrlPMixed<CR>

let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/]\.(git|hg|svn|vscode|idea)$|build$|target$',
\ 'file': '\v\.(exe|so|dll|class|pyc)$',
\ 'link': '.*',
\ } 

set completeopt=longest,menu

let g:airline_theme='dark'

"python with virtualenv support
" if has('python3')
  " silent! python3 1
" endif
" py3 << EOF
" import os
" import sys
" if 'VIRTUAL_ENV' in os.environ:
  " project_base_dir = os.environ['VIRTUAL_ENV']
  " activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  " exec(compile(open(activate_this, "rb").read(), activate_this, 'exec'), dict(__file__=activate_this))
" EOF


" NERDTree 配置：
map <leader>e :NERDTreeToggle<CR>
map <leader>E :NERDTreeFind<CR>
""当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NERDTree settings
" 忽略以下文件的显示
let NERDTreeIgnore=[ 
            \ '\.pyc','\~$','\.swp','__pycache__','\.git$','\.DS_Store','\.vscode$','\.idea$'
            \]

" NERDTree dERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
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
let g:rainbow_active = 1
" 'guifgs': 一个guifg的列表 (:h highlight-guifg), 即GUI界面的括号颜色, 将按顺序循环使用
" 'guis': 一个gui的列表 (:h highlight-gui), 将按顺序循环使用
" 'ctermfgs': 一个ctermfg的列表 (:h highlight-ctermfg), 即终端下的括号颜色
" 'cterms': 一个cterm的列表 (:h highlight-cterm)
" 'operators': 描述你希望哪些运算符跟着与它同级的括号一起高亮(注意：留意需要转义的特殊字符，更多样例见这里, 你也可以读vim帮助 :syn-pattern)
" 'parentheses': 一个关于括号定义的列表, 每一个括号的定义包含形如以下的部分: start=/(/, step=/,/, stop=/)/, fold, contained, containedin=someSynNames, contains=@Spell. 各个部分具体含义可参考 :h syntax, 其中 step 为本插件的扩展定义, 表示括号中间需要高亮的运算符.
" 'separately': 针对文件类型(由&ft决定)作不同的配置,未被单独设置的文件类型使用*下的配置,值为0表示仅对该类型禁用插件,值为"default"表示使用针对该类型的默认兼容配置 (注意, 默认兼容配置可能随着该插件版本的更新而改变, 如果你不希望它改变, 那么你应该将它拷贝一份放到你的vimrc文件里).
" 省略某个字段以使用默认设置
let g:rainbow_conf = {
	\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
	\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {},
	\		'tex': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
	\		},
	\		'lisp': {
	\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
	\		},
	\		'vim': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
	\		'html': {
	\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
	\		},
	\		'css': 0,
	\	}
	\}
" 当没有参数时自动打开
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"窗口移动 
":only :on
map <C-J> <C-w>j
map <C-K> <C-w>k
map <C-H> <C-w>h
map <C-L> <C-w>l
" 历史文件,存在于viminfo中
nmap <F4> :browse oldfiles<CR>

"execute 'cd' expand('%:h')
nnoremap <silent> <leader>. :cd %:h<CR>
" nnoremap <silent> <leader><leader>. :exec("NERDTree ".expand('%:h'))<CR>

noremap <F6> :silent execute("vimgrep/" . expand("<cword>") . '/j ' . '*.' . expand('%:e'))<CR> \| :copen<CR>
noremap <C-F6> :silent execute("vimgrep/" . expand("<cword>") . '/j ' . '**/*.' . expand('%:e'))<CR> \| :copen<CR>
" nmap <SPACE> /
nmap <F3> :cn<CR>
nmap <S-F3> :cp<CR>
"run shell
nmap <leader>r :!
nmap <leader>ri :r !

" markdown preview
nmap <silent> <F8> <Plug>MarkdownPreview        " for normal mode
imap <silent> <F8> <Plug>MarkdownPreview        " for insert mode
nmap <silent> <C-F8> <Plug>MarkdownPreviewStop    " for normal mode
imap <silent> <C-F8> <Plug>MarkdownPreviewStop    " for insert mode

let g:multi_cursor_use_default_mapping=0

let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<S-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

if has('terminal')
    set termwinsize=13x0
endif
nmap <silent> <LEADER>ft :botright term<CR>
" 退出term
tnoremap <Esc> <C-\><C-n>:q!<CR>
if WINDOWS()
    if executable('powershell')
        set shell=powershell
    endif
else
    if executable('/bin/zsh')
        set shell=/bin/zsh
    endif
endif

" 返回当前时间
func! GetTimeInfo()
    "return strftime('%Y-%m-%d %A %H:%M:%S')
    return strftime('%Y-%m-%d %H:%M:%S')
endfunction

" 插入模式按 Ctrl + D(ate) 插入当前时间
imap <C-d> <C-r>=GetTimeInfo()<cr>

function! JumpToTab(num)
    let s:count = a:num
    exe "tabfirst"
    exe "tabnext" s:count
endfunction
 
function! TabInit()
    for i in range(1, 9)
        exe "map <M-" . i . "> :call JumpToTab(" . i . ")<CR>"
    endfor
    exe "map <M-0> :call JumpToTab(10)<CR>"
endfunction
 
autocmd VimEnter * call TabInit()

if CODER() && has('python3')
    let g:UltiSnipsExpandTrigger="<tab>"
    " 使用 tab 切换下一个触发点，shit+tab 上一个触发点
    let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
    " 使用 UltiSnipsEdit 命令时垂直分割屏幕
    let g:UltiSnipsEditSplit="vertical"

    " let g:ale_sign_column_always = 1
    let g:airline#extensions#ale#enabled = 1
    let g:ale_fix_on_save = 0
    let g:ale_sign_error = 'x'
    let g:ale_sign_warning = '!'
    let g:ale_linters = {
    \   'c++': ['clang'],
    \}

    let g:ale_fixers = {
    \   'javascript': ['eslint'],
    \}
endif

" vim hard time ON:
let g:hardtime_default_on=1
let g:hardtime_showmsg=1
let g:hardtime_allow_different_key=1
let g:hardtime_maxcount=2

inoremap <c-u> <c-g>u<c-u> # 增加一个撤销点<c-g>u
inoremap <c-w> <c-g>u<c-w>
"将tab替换为空格
nmap <LEADER>rts :%s/\t/    /g<CR>

nnoremap g0 :set relativenumber!<CR> " 切换显示相对行号

" surround
" 不定义任何快捷键?
let g:surround_no_mappings = 1
nmap gsd <Plug>Dsurround
nmap gsr <Plug>Csurround
nmap gsR <Plug>CSurround
xmap gS  <Plug>VSurround 
nmap gsa <Plug>Ysurround
nmap gsA <Plug>YSurround

nmap gss <Plug>Yssurround 
nmap gsS <Plug>YSsurround 

nmap <CR> o<Esc>
nmap <S-Enter> O<Esc>

nmap s <Plug>(easymotion-s)
nmap f <Plug>(easymotion-f)
nmap F <Plug>(easymotion-F)
nmap t <Plug>(easymotion-t)
nmap T <Plug>(easymotion-T)
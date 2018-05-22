"===================================================================================================
"===================================================================================================
" 环境检查
"===================================================================================================
" 判断操作系统是否是 Windows 还是 Linux
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:iswindows = 0
endif
" 判断是终端还是 Gvim
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif
if (g:iswindows && g:isGUI)     " {{{
    let $VIMFILES = $HOME."/vimfiles"

    "colorscheme Tomorrow-Night-Eighties    " Gvim配色方案

    set guifont=Lucida\ Console:h10:cANSI   " 设置字体

    language messages zh_CN.utf-8           " 解决consle输出乱码

    source $VIMRUNTIME/delmenu.vim          " 解决菜单乱码
    source $VIMRUNTIME/menu.vim
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim

    au GUIEnter * simalt ~x                 " 窗口启动时自动最大化

    set clipboard+=unnamed                  " 与windows共享剪贴板
    set guioptions-=m                       " 隐藏菜单栏
    set guioptions-=T                       " 隐藏工具栏
    set showtabline=1                       " 隐藏Tab栏
    set guioptions-=L                       " 隐藏左侧滚动条
    set guioptions+=r                       " 隐藏右侧滚动条
    set guioptions-=b                       " 隐藏底部滚动条

    behave mswin
else
    let $VIMFILES = $HOME."/.vim"

    set guifont=Lucida\ Console\ 10

    "colorscheme Tomorrow-Night-Eighties     " 终端配色方案

    " reopening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif

    "set diffexpr=MyDiff()                   " 有问题
    function MyDiff()   " {{{
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction     " }}}
endif   " }}}
"===================================================================================================

"===================================================================================================
" 编码设置
"===================================================================================================
language message zh_CN.UTF-8    " 控制台console编码

set langmenu=zh_CN.UTF-8                                    " Console output coding
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936  " 文件解析猜测识别的编码顺序
set enc=utf-8                                               " vim 支持中文 内部编码
set fenc=utf-8                                              " work in linux 解析出来的当前文件编码(可能解析错误)
set encoding=utf-8                                          " work in linux
set ambiwidth=double                                        " 把不明宽度字符设置为双倍字符宽度(中文字符宽度)
set termencoding=utf-8                                      " work in linux
set fileencoding=utf-8                                      " 当前编辑的文件编码(新文件的编码)
set fileencodings=utf-8,chinese,latin-1                     " 当前编辑的文件自动判断依次尝试编码
set fileformats=unix,mac,dos

let g:fencview_autodetect    = 0
let g:fencview_auto_patterns = '*'
"===================================================================================================

"===================================================================================================
" 折叠设置
"===================================================================================================
" 折叠相关的快捷键  " {{{
"   zR 打开所有的折叠
"   za Open/Close (toggle) a folded group of lines.
"   zA Open a Closed fold or close and open fold recursively.
"   zi 全部 展开/关闭 折叠
"   zo 打开 (open) 在光标下的折叠
"   zc 关闭 (close) 在光标下的折叠
"   zC 循环关闭 (Close) 在光标下的所有折叠
"   zM 关闭所有可折叠区域   " }}}
set foldenable  " 开始折叠

" 折叠方式  " {{{
"   manual  手工定义折叠
"   indent  更多的缩进表示更高级别的折叠
"   expr    用表达式来定义折叠
"   syntax  用语法高亮来定义折叠
"   diff    对没有更改的文本进行折叠    " }}}
"setlocal foldlevel=1   " 设置折叠层数为
"set foldlevel=3        " 设置折叠层数为
set foldmethod=marker   " 设置语法折叠(marker)
set foldcolumn=0        " 设置折叠区域的宽度
set foldclose=all       " 设置为自动关闭折叠
" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
" php 的折叠
let Tlist_php_settings='php;c:class;i:interfaces;d:constant;f:function'
"===================================================================================================

"===================================================================================================
" 快 捷 键
"===================================================================================================
let mapleader=","
let g:mapleader=","
let maplocalleader=","

" Ctrl + K 插入模式下光标向上移动
imap <c-k> <Up>
" Ctrl + J 插入模式下光标向下移动
imap <c-j> <Down>
" Ctrl + H 插入模式下光标向左移动
imap <c-h> <Left>
" Ctrl + L 插入模式下光标向右移动
imap <c-l> <Right>

map <C-w> <C-w>w

" 常规模式下输入 cS 清除行尾空格
nmap cS :%s/\s\+$//g<cr>:noh<cr>
" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<cr>:noh<cr>
" 将tab替换为空格
nmap tt :%s/\t/    /g<CR>
"===================================================================================================

"===================================================================================================
" 文件设置
"===================================================================================================
" block   允许可视列块模式的虚拟编辑
" insert  允许插入模式的虚拟编辑
" all     允许所有模式的虚拟编辑
" onemore 允许光标移动到刚刚超过行尾的位置
set virtualedit=block

set autoread        " 设置当文件被改动时自动载入
set binary          " 可读二进制文件
set autowrite       " 自动保存
set confirm         " 在处理未保存或只读文件的时候，弹出确认
set nobackup        " 设置无备份文件
set noundofile      " 设置无备份文件
set noswapfile      " 设置无临时文件
set writebackup     " 保存文件前建立备份，保存成功后删除该备份

setlocal noswapfile " 关闭临时文件,不生成swap文件,

filetype on                 " 检测文件的类型
filetype plugin on          " 载入ftplugin文件类型插件
filetype indent on          " 为特定文件类型载入相关缩进文件
filetype plugin indent on

autocmd! bufwritepost _vimrc source %       " .vimrc修改后不需重启生效
"autocmd BufNewFile * normal G               " 新建文件后，自动定位到文件末尾
au BufRead,BufNewFile,BufEnter * cd %:p:h   " 自动切换目录为当前编辑文件所在目录

autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \ exe "normal! g'\"" |
    \ endif

if has("autocmd")   " {{{   只在下列文件类型被侦测时显示行号,普通文本文件不显示
    autocmd FileType xml,html,c,cs,java,perl,shell,bash,cpp,python,vim,php,ruby set number
    autocmd FileType xml,html vmap <C-o> <ESC>'<i<!--<ESC>o<ESC>'>o-->
    autocmd FileType java,c,cpp,cs vmap <C-o> <ESC>'<o/*<ESC>'>o*/
    autocmd FileType html,text,php,vim,c,java,xml,bash,shell,perl,python setlocal textwidth=100
    autocmd Filetype html,xml,xsl source $VIMRUNTIME/plugin/closetag.vim
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
    autocmd FileType yml set tabstop=2 | set shiftwidth=2 | set expandtab
    au BufEnter *.yml set ai sw=2 ts=2 sta et fo=croql
    au FileType html,python,vim,javascript setl shiftwidth=4
    au FileType html,python,vim,javascript setl tabstop=4
    au FileType java,php setl shiftwidth=4
    au FileType java,php setl tabstop=4
endif   " }}}
"===================================================================================================

"===================================================================================================
" 显示风格
"===================================================================================================
" 设置代码配色方案
colorscheme desert                      " 设置配色方案
color ron                               " 设置背景主题 (color desert|torte)

syntax enable                           " 启用语法高亮
syntax on                               " 设置语法高亮

set shortmess=atI                       " 启动的时候不显示援助索马里儿童提示
set go=                                 " 不要图形按钮
set background=dark                     " 设置背景为黑
set novisualbell                        " No mouseflash
set number                              " 设置行号 (set nu)
set nocompatible                        " 不要使用vi的键盘模式
set report=0                            " 通过使用: commands命令，告诉我们文件的哪一行被改变过
set fillchars=vert:\ ,stl:\ ,stlnc:\    " 在被分割的窗口间显示空白，便于阅读
set nobomb                              " 不使用unicode签名
set showcmd                             " 输入的命显示出来
set scrolloff=3                         " 光标移动到buffer的顶部和底部时保持3行距离
set linespace=0                         " 字符间插入的像素行数目
set noerrorbells                        " 不让vim发出讨厌的滴滴声 (set noeb)
set bufhidden=hide                      " 当buffer丢弃时隐藏它
set cursorline                          " 高亮显示当前行 (set cul)
set cursorcolumn                        " 高亮光标列 (set cuc)
set backupcopy=yes                      " 设置备份时的行为为覆盖autobackup cover (set nowritebackup)
set mouse=a                             " 可以在buffer的任何地方使用鼠标
set selection=exclusive                 " 光标所在位置也属于被选中的范围 (set selection=inclusive)
set selectmode=mouse,key                " 鼠标键盘可用
set wildmenu                            " 增强模式中的命令行自动完成操作
set mousemodel=popup
set textwidth=100                       " 每行显示多少字符
set vb t_vb=                            " 关闭提示音

" 高亮字符，让其不受100列限制
:highlight OverLength ctermbg=darkgray ctermfg=lightblue guibg=#1C1D1E guifg=#DCDCDC
:match OverLength '\%500v.*'

set viminfo+=!      " 保存全局变量

" 显示中文帮助
if version >= 603
    set helplang=cn
    set encoding=utf-8
endif
"===================================================================================================

"===================================================================================================
" 搜索处理
"===================================================================================================
set hlsearch        " 高亮被搜索的句子（phrases）
set incsearch       " 在 搜索时，输入的词句的逐字符高亮（类似firefox的搜索）
set showmatch       " 高亮显示匹配的括号
set nowrapscan      " 禁止搜索到文件两端时重新搜索
set ignorecase      " 在搜索的时候忽略大小写
set matchtime=5     " 匹配括号高亮的时间（单位是十分之一秒）
set history=1000    " 历史记录数
"===================================================================================================

"===================================================================================================
" 空格缩进
"===================================================================================================
" 取消缩进
map <leader>ps :set paste<cr>
map <leader>pn :set nopaste<cr>

"set whichwrap+=<,>,[,],h,l     " 允许backspace和光标键跨越行边界(不建议)
set expandtab                   " 用空格来代替制表符tab noexpandtab是不用空格代替制表符tab (set et)
set smarttab                    " 指定按一次backspace就删除shiftwidth宽度的空格
set tabstop=4                   " 设置tab为4个空格 set ts=4
set backspace=2                 " 可以使用backspace键一次删2个
set shiftwidth=4                " 设置行间交错为4个空格 set sw=4
set softtabstop=4               " 统一缩进为4个空格
set sm                          " 显示括号配对情况
set wrap                        " 自动换行
set linebreak                   " 整词换行 (set lbr)
set fo+=mB
set iskeyword+=.,_,$,@,%,#,-      " 带有如下符号的单词不要被换行分割
set ai!                         " 设置自动缩进
set autoindent                  " 自动对齐,继承前一行的缩进
set smartindent                 " 智能对齐
set formatoptions=tcrqn         " 自动格式化
set cindent                     " 使用c样式的缩进
set list                        " 缩进线

" 制表符显示方式定义：trail为拖尾空白显示字符，extends和precedes分别是wrap关闭时，所在行在屏幕右边和左边显示的指示字符
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<
"set list listchars=tab:>-,trail:.,extends:>
"set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s

" 每行超过80个的字符用下划线标示
au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 100 . 'v.\+', -1)
"au BufRead,BufNewFile *.s,*.asm,*.h,*.c,*.cpp,*.cc,*.java,*.cs,*.erl,*.hs,*.sh,*.lua,*.pl,*.pm,*.php,*.py,*.rb,*.erb,*.vim,*.js,*.css,*.xml,*.html,*.xhtml 2match Underlined /.\%81v/

" indent color   " {{{
"hi 4spa  guibg = #771144
"hi 8spa  guibg = #22464A
"hi 12spa guibg = #344333
"hi 16spa guibg = #777444
"hi 20spa guibg = #555777
"hi 24spa guibg = #cc9966
"hi 80spa guibg = #ff1111
" }}}
" style 1    " {{{
"syn match 4spa  /\(\s\{4}\|\n\)\&\%1v.*\%2v/
"syn match 8spa  /\s\{4}\&\%5v.*\%6v/
"syn match 12spa /\s\{4}\&\%9v.*\%10v/
"syn match 16spa /\s\{4}\&\%13v.*\%14v/
"syn match 20spa /\s\{4}\&\%17v.*\%18v/
"syn match 24spa /\s\{4}\&\%21v.*\%22v/
" }}}
" style 2    " {{{
"syn match 4spa  /\(\s\|\n\)\&\%4v.*\%5v/
"syn match 8spa  /\s\&\%8v.*\%9v/
"syn match 12spa /\s\&\%12v.*\%13v/
"syn match 16spa /\s\&\%16v.*\%17v/
"syn match 20spa /\s\&\%20v.*\%21v/
"syn match 24spa /\s\&\%24v.*\%25v/
"syn match 80spa /.\&\%80v.*\%81v/
" }}}
"===================================================================================================

"===================================================================================================
" 缩进风格
"===================================================================================================
" 自动缩进
let g:indent_guides_auto_colors = 0

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

hi IndentGuidesOdd  guibg=red   ctermbg=3
hi IndentGuidesEven guibg=green ctermbg=4
hi IndentGuidesEven ctermbg=darkgrey
hi IndentGuidesOdd  ctermbg=black
"===================================================================================================

"===================================================================================================
" 状 态 栏
"===================================================================================================
set laststatus=2    " 总是显示状态栏,默认1无法显示
set cmdheight=1     " 命令行（在状态行下）的高度，默认为1，这里是2

" 状态行显示的内容（包括文件类型和解码）
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
set statusline=%{HasPaste()}%F%m%r%h\ %w
set statusline+=\ CWD:%r%{getcwd()}%h
set statusline+=\ %h%1*%m%r%w%0*
set statusline+=%=
set statusline+=%l,%c%V\ \ %<%P
set statusline+=\ \ BUFFTER:%-3.3n%0*
set statusline+=FORMAT=[%{&ff!=''?&ff:NULL}:%{&fenc!=''?&fenc:&enc}]

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" 状态栏彩色    " {{{
hi StatuslineBufNr    cterm=none ctermfg=black ctermbg=cyan   gui=none guibg=#840c0c   guifg=#ffffff
hi StatuslineFlag     cterm=none ctermfg=black ctermbg=cyan   gui=none guibg=#bc5b4c   guifg=#ffffff
hi StatuslinePath     cterm=none ctermfg=white ctermbg=green  gui=none guibg=#8d6c47   guifg=black
hi StatuslineFileName cterm=none ctermfg=white ctermbg=blue   gui=none guibg=#d59159   guifg=black
hi StatuslineFileEnc  cterm=none ctermfg=white ctermbg=yellow gui=none guibg=#ffff77   guifg=black
hi StatuslineFileType cterm=bold ctermbg=white ctermfg=black  gui=none guibg=#acff84   guifg=black
hi StatuslineTermEnc  cterm=none ctermbg=white ctermfg=yellow gui=none guibg=#77cf77   guifg=black
hi StatuslineChar     cterm=none ctermbg=white ctermfg=yellow gui=none guibg=#66b06f   guifg=black
hi StatusLine                                                          guifg=SlateBlue guibg=#FFFF00
hi StatusLineNC                                                        guifg=Gray      guibg=White

"hi StatuslineBufNr     cterm=none    ctermfg=black ctermbg=cyan    gui=none guibg=#696969 guifg=#D8BFD8
"hi StatuslineFlag      cterm=none    ctermfg=black ctermbg=cyan    gui=none guibg=#330223 guifg=#cdcde1
"hi StatuslinePath      cterm=none    ctermfg=white ctermbg=green   gui=none guibg=#210222 guifg=#cdcde2
"hi StatuslineFileName  cterm=none    ctermfg=white ctermbg=blue    gui=none guibg=#410041 guifg=#cdcde3
"hi StatuslineFileEnc   cterm=none    ctermfg=white ctermbg=yellow  gui=none guibg=#400342 guifg=#cdcde4
"hi StatuslineFileType  cterm=bold    ctermbg=white ctermfg=black   gui=none guibg=#52096C guifg=#cdcde5
"hi StatuslineTermEnc   cterm=none    ctermbg=white ctermfg=yellow  gui=none guibg=#79318B guifg=#cdcde6
"hi StatuslineChar      cterm=none    ctermbg=white ctermfg=yellow  gui=none guibg=#8C63A4 guifg=#cdcde7
"hi StatuslineSyn       cterm=none    ctermbg=white ctermfg=yellow  gui=none guibg=#AA87B8 guifg=#cdcde8
"hi StatuslineRealSyn   cterm=none    ctermbg=white ctermfg=yellow  gui=none guibg=#C9B5D4 guifg=#7F8794
"hi StatusLine          cterm=none    ctermbg=white ctermfg=yellow  gui=none guibg=#8C7E95 guifg=#cdcdea
"hi StatuslineTime      cterm=none    ctermfg=black ctermbg=cyan    gui=none guibg=#504855 guifg=#cdcdeb
"hi StatuslineSomething cterm=reverse ctermfg=white ctermbg=darkred gui=none guibg=#400342 guifg=#cdcdec
"hi StatusLineNC                                                    gui=none guibg=#250342 guifg=#cdcded
" }}}

" 在状态行上显示光标所在位置的行号和列号
set ruler                                               " 显示标尺
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)
set showcmd                                             " 输入的命令显示出来，看的清楚些
"===================================================================================================

"===================================================================================================
" 插件管理
"===================================================================================================
" 用于更方便的管理vim插件，具体用法参考 :h vundle 帮助
" 安装方法为在终端输入如下命令
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

"   :BundleUpdate 更新插件
"   :BundleClean  清除插件
"   :BundleList   插件列表
"   :BundleSearch 查找插件
if !g:iswindows
    :let g:vundleDir = $HOME . '/.vim/bundle/Vundle.vim/'
else
    :let g:vundleDir = $HOME . '/vimfiles/bundle/Vundle.vim/'
endif
let g:isVundle = 0
if isdirectory(g:vundleDir)
    let g:isVundle = 1
endif

if (!g:iswindows && g:isVundle)
    set rtp+=~/.vim/bundle/Vundle.vim/
    call vundle#rc()
endif
if (g:iswindows && g:isVundle)
    set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
    call vundle#rc('$HOME/vimfiles/bundle/')
endif
if g:isVundle
map <leader>bu :BundleUpdate<cr>
map <leader>bc :BundleClean<cr>
map <leader>bl :BundleList<cr>
map <leader>bs :BundleSearch<cr>
" 使用Vundle来管理Vundle
Bundle 'https://github.com/VundleVim/Vundle.vim.git'
endif
    "===============================================================================================
    " 以下为要安装或更新的插件，不同仓库都有（具体书写规范请参考帮助）
    "-----------------------------------------------------------------------------------------------
    " {{{ My Bundles Here:
    " original repos on github
    Bundle 'tpope/vim-fugitive'
    Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
    Bundle 'Yggdroot/indentLine'
    "ndle 'tpope/vim-rails.git'
    " vim-scripts repos
    Bundle 'L9'
    Bundle 'FuzzyFinder'
    " non github repos
    Bundle 'https://github.com/wincent/command-t.git'
    Bundle 'Auto-Pairs'
    Bundle 'python-imports.vim'
    Bundle 'CaptureClipboard'
    Bundle 'last_edit_marker.vim'
    Bundle 'synmark.vim'
    "Bundle 'Python-mode-klen'
    Bundle 'SQLComplete.vim'
    Bundle 'Javascript-OmniCompletion-with-YUI-and-j'
    "Bundle 'JavaScript-Indent'
    "Bundle 'Better-Javascript-Indentation'
    Bundle 'jslint.vim'
    Bundle "pangloss/vim-javascript"
    Bundle 'Vim-Script-Updater'
    Bundle 'ctrlp.vim'
    Bundle 'tacahiroy/ctrlp-funky'
    Bundle 'ctrlp-modified.vim'
    Bundle 'jsbeautify'
    Bundle 'The-NERD-Commenter'
    "django
    Bundle 'django_templates.vim'
    Bundle 'Django-Projects'

    "Bundle 'FredKSchott/CoVim'
    "Bundle 'djangojump'
    " ...
    let g:html_indent_inctags = "html,body,head,tbody"
    let g:html_indent_script1 = "inc"
    let g:html_indent_style1 = "inc"

    filetype plugin indent on     " required!

    " ctrlp 设置
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.png,*.jpg,*.gif     " MacOSX/Linux
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.pyc,*.png,*.jpg,*.gif  " Windows

    let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
    let g:ctrlp_custom_ignore = '\v\.(exe|so|dll)$'
    let g:ctrlp_extensions = ['funky']

    " syntastic 相关
    let g:syntastic_python_checkers = ['pylint']
    let g:syntastic_mode_map = {'passive_filetypes': ['sass', 'haml']}

    " markdown 配置
    au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=mkd
    au BufRead,BufNewFile *.{go}   set filetype=go
    au BufRead,BufNewFile *.{js}   set filetype=javascript

    " rkdown to HTML
    nmap md :!~/.vim/markdown.pl % > %.html <CR><CR>
    nmap fi :!firefox %.html & <CR><CR>
    nmap \ \cc
    vmap \ \cc
    " }}}
    " {{{   " authorinfo
    " vim自动添加作者信息（需要和NERD_commenter联用)使用,
    "   :AuthorInfoDetect呼出
    let g:vimrc_author    = 'apple'
    let g:vimrc_email     = 'null@email.com'
    let g:vimrc_link      = 'www.null.com'
    let g:vimrc_copyright = 'Copyright (c) 2006 - 2013, BTROOT, Inc.'
    let g:vimrc_license   = 'null'
    let g:vimrc_version   = 'Version 1.0'

    nmap <F4> :AuthorInfoDetect<cr>
    " }}}
    " {{{   " SetTitle 自动.c .h .sh .java自动插入文件头
    if !g:iswindows " {{{
        func SetTitle()
            if &filetype == 'sh'
                call setline(1,"\#!/bin/bash")
                call append(line("."), "")
            elseif &filetype == 'python'
                call setline(1,"#!/usr/bin/env python")
                call append(line("."),"# coding=utf-8")
                call append(line(".")+1, "")
            elseif &filetype == 'ruby'
                call setline(1,"#!/usr/bin/env ruby")
                call append(line("."),"# encoding: utf-8")
                call append(line(".")+1, "")
            elseif &filetype == 'mkd'
                call setline(1,"<head><meta charset=\"UTF-8\"></head>")
            else
                call setline(1, "/*************************************************************************")
                call append(line("."), "    > File Name: ".expand("%"))
                call append(line(".")+1, "  > Author: ")
                call append(line(".")+2, "  > Mail: ")
                call append(line(".")+3, "  > Created Time: ".strftime("%c"))
                call append(line(".")+4, " ************************************************************************/")
                call append(line(".")+5, "")
            endif
            if expand("%:e") == 'cpp'
                call append(line(".")+6, "#include<iostream>")
                call append(line(".")+7, "using namespace std;")
                call append(line(".")+8, "")
            endif
            if &filetype == 'c'
                call append(line(".")+6, "#include<stdio.h>")
                call append(line(".")+7, "")
            endif
            if expand("%:e") == 'h'
                call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
                call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
                call append(line(".")+8, "#endif")
            endif
            if &filetype == 'java'
                call append(line(".")+6,"public class ".expand("%"))
                call append(line(".")+7,"")
            endif
            if &filetype == 'java'
                call append(line(".")+6,"public class ".expand("%:r"))
                call append(line(".")+7,"")
            endif
        endfunc
        autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.py exec ":call SetTitle()"
    endif " }}}

    if &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%"))
        call append(line(".")+7,"")
    endif
    " }}}
    " {{{   " 自动补全
    " Ctrl-x Ctrl-o  long press
    "   补全文件名                C-f
    "   根据当前文件里关键字补全    C-n
    "   补全宏定义                C-d
    "   根据字典补全               C-k
    "   根据同义词字典补全          C-t
    "   根据标签补全               C-]
    "   拼写建议                  C-s
    "   下拉翻页                  C-n
    "   下拉翻页                  C-p
    "   整行补全                  C-l
    "   根据头文件内关键字补全      C-i
    "   补全vim命令               C-v
    "   用户自定义补全             C-u

    autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
    autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType php        set omnifunc=phpcomplete#CompletePHP
    autocmd FileType mysql      set omnifunc=mysqlcomplete#CompleteMYSQL
    autocmd FileType xml        set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType c          set omnifunc=ccomplete#Complete

    " Python 补全
    autocmd FileType python     set omnifunc=pythoncomplete#Complete

    let g:pydiction_location = '~/.vim/after/complete-dict'
    let g:pydiction_menu_height = 20

    set completeopt=longest,menu    " 提示菜单后输入字母实现即时的过滤和匹配
    " }}}
    if g:isVundle
    " {{{   " nerdcommenter
    Bundle 'scrooloose/nerdcommenter'
    " 我主要用于C/C++代码注释(其它的也行)，这个插件我做了小点修改，也就是在注释符
    " 与注释内容间加一个空格
    " 以下为插件默认快捷键，其中的说明是以C/C++为例的
    " <Leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行)，再输入则取消注释
    " <Leader>cm 以一个 /* */ 注释选中行(选中区域所在行)，再输入则称重复注释
    " <Leader>cc 以每行一个 /* */ 注释选中行或区域，再输入则称重复注释
    " <Leader>cu 取消选中区域(行)的注释，选中区域(行)内至少有一个 /* */
    " <Leader>ca 在/*...*/与//这两种注释方式中切换（其它语言可能不一样了）
    " <Leader>cA 行尾注释
    let NERDSpaceDelims=1   "在左注释符之后，右注释符之前留有空格

    " vim加入注释
    "   <leader>ca 在可选的注释方式之间切换，比如C/C++ 的块注释/* */和行注释//
    "   <leader>cc 注释当前行
    "   <leader>cs 以”性感”的方式注释
    "   <leader>cA 在当前行尾添加注释符，并进入Insert模式
    "   <leader>cu 取消注释
    "   <leader>cm 添加块注释
    "   [count],c命令 依次从本行开始注释,取消注释,count 为数字 7,cc
    " 定义F11为html的注释
    map <F11> <ESC>0i<!--<ESC>$a--><ESC>
    " 定义F12为html的注释取消
    map <F12> <ESC>04x$hh3x<ESC>

    " :s/^/#           用"#"注释当前行
    " :2,50s/^ /#      在2~50行首添加"#"注释
    " :.,+3s/^/#       用"#"注释当前行和当前行后面的三行
    " :%s/^/#          用"#"注释所有行
    " :n1,n2s/^/#/g    用"#"注释n1~n2行,下面为删除
    " :n1,n2s/^/\/\//g 用//注释n1~n2
    " :n1,n2s/\/\///g  删除//的注释
    " :n1,n2s/#/^/g   :n1,n2s/^/#/g   :n1,n2s/#^//g
    " }}}
    " {{{ " wm
    Bundle 'winmanager'
    " 在进入vim时自动打开winmanager
    let g:winManagerWindowLayout = 'NERDTree|TagList'
    let g:AutoOpenWinManager     = 1
    let g:winManagerWidth        = 30
    let g:defaultExplorer        = 0

    nmap <silent> <leader>wm :WMToggle<cr>
    nmap <C-W><C-F> :FirstExplorerWindow<cr>
    nmap <C-W><C-B> :BottomExplorerWindow<cr>
    " }}}
    " {{{   " nerdtree
    Bundle 'scrooloose/nerdtree'
    " 目录村结构的文件浏览插件
    " 插件[,te]开启list.tree
    "   :NERDTree   -- 启动NERDTree插件
    "   o [小写]    -- 切换当前文件或目录的打开、关闭状态
    "   u           -- 打开上层目录
    "   p [小写]    -- 返回上层目录
    "   P [大写]    -- 返回根目录
    "   K           -- 转到当前目录第一个节点
    "   J           -- 转到当前目录最后的节点
    "   m           -- 显示文件系统菜单 [增、删、移]
    "   ?           -- 弹出帮助菜单
    "   q           -- 退出该插件
    map <leader>te :NERDTreeToggle<cr>

    let g:NERDTree_title = "NERDTree"

    let NERDTreeWinPos          = 'left'        " 窗口位置('left' or 'right')
    let NERDTreeWinSize         = 30            " 窗口宽
    let NERDTreeChDirMode       = 2
    let NERDChristmasTree       = 0             " 让Tree把自己给装饰得多姿多彩漂亮点
    let NERDTreeMouseMode       = 2             " 指定鼠标模式(1.双击打开；2.单目录双文件；3.单击打开)
    let NERDTreeShowFiles       = 1             " 是否默认显示文件
    let NERDTreeAutoCenter      = 1             " 控制光标移动超过一定距离时，是否自动将焦点调整到屏中心
    let NERDTreeShowHidden      = 0             " 是否默认显示隐藏文件
    let NERDTreeShowBookmarks   = 1             " 是否默认显示书签列表
    let NERDTreeShowLineNumbers = 0             " 是否默认显示行号
    let NERDTreeIgnore          = ['\~$', '\.pyc$', '\.swp$']

    " 当打开vim且没有文件时自动打开NERDTREE
    "autocmd vimenter * if !argc() | NERDTree | endif
    " 只剩NREDTree时自动关闭
    "autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | qa | endif
    " 与NERDTreeAutoCenter配合使用
    "let NERDTreeBookmarksFile = $HOME . '\Data\NerdBookmarks.txt'

    function! NERDTree_Start()
        exe 'q'
        exe 'NERDTree'
    endfunction
    function! NERDTree_IsValid()
        return 1
    endfunction
    " }}}
    " {{{   " bufexplorer 有冲突，暂时
    "Bundle 'bufexplorer.zip'
    " 快速轻松的在缓存中切换（相当于另一种多个文件间的切换方式）
    " <Leader>be 在当前窗口显示缓存列表并打开选定文件
    " <Leader>bs 水平分割窗口显示缓存列表，并在缓存列表窗口中打开选定文件
    " <Leader>bv 垂直分割窗口显示缓存列表，并在缓存列表窗口中打开选定文件
    " }}}
    " {{{   " minibufexpl
    Bundle 'minibufexpl.vim'
    " 快速浏览和操作Buffer
    " 主要用于同时打开多个文件并相与切换
    " <C-Tab> 向前循环切换到每个buffer上,并在但前窗口打开
    " <C-S-Tab> 向后循环切换到每个buffer上,并在当前窗口打开

    let g:miniBufExplMapWindowNavArrows = 1     " 用Ctrl加方向键切换到上下左右的窗口中去
    let g:miniBufExplMapWindowNavVim    = 1     " 用<C-k,j,h,l>切换到上下左右的窗口中去
    let g:miniBufExplMapCTabSwitchBufs  = 1     " 功能增强（不过好像只有在Windows中才有用）
    let g:miniBufExplModSelTarget       = 1

    " 在不使用 MiniBufExplorer 插件时也可用<C-k,j,h,l>切换到上下左右的窗口中去
    noremap <c-k> <c-w>k
    noremap <c-j> <c-w>j
    noremap <c-h> <c-w>h
    noremap <c-l> <c-w>l
    " }}}
    " {{{   " taglist
    Bundle 'vim-scripts/taglist.vim'
    " 高效地浏览源码, 其功能就像vc中的workpace
    " 那里面列出了当前文件中的所有宏,全局变量, 函数名等
    " F10开关 按wm会启动.F9是单独开关
    " :Tlist --呼出变量和函数列表 [TagList插件]
    " 常规模式下输入 tl 调用插件，如果有打开 Tagbar 窗口则先将其关闭
    map <leader>tl :TlistToggle<cr>

    let Tlist_Auto_Open            = 1          " 默认打开Taglist
    let Tlist_Use_Right_Window     = 1          " 在右侧显示窗口
    let Tlist_Sort_Type            = "name"     " 按照名称排序
    let Tlist_Show_Menu            = 1          " 显示taglist菜单
    let Tlist_WinWidth             = 30         " 设置窗口宽度
    "let Tlist_WinHeight            = 0          " 设置窗口高度
    let Tlist_Show_One_File        = 1          " 不同时显示多个文件的tag，只显示当前文件的 tags
    "let Tlist_Enable_Fold_Column   = 0          " 不显示左边的折叠行
    let Tlist_Exit_OnlyWindow      = 1          " 如果窗口是最后一个窗口则退出Vim
    let Tlist_File_Fold_Auto_Close = 1          " 自动折叠
    let Tlist_Compart_Format       = 1          " 压缩方式
    let Tlist_Exist_OnlyWindow     = 1          " 如果只有一个buffer，kill窗口也kill掉buffer
    let Tlist_Process_File_Always  = 1          " 如果希望taglist始终解析文件中的tag，不管taglist窗口有没有打开
    let Tlist_Close_On_Select      = 1          " Close the list when a item is selected
    let Tlist_Use_SingleClick      = 1          " Go To Target By SingleClick
    let Tlist_Auto_Update          = 1          " Update the tag list automatically
    " }}}
    " {{{   " Tagbar
    Bundle 'vim-scripts/Tagbar'
    " 相对 TagList 能更好的支持面向对象
    " 常规模式下输入 tb 调用插件，如果有打开 TagList 窗口则先将其关闭
    "map <leader>tb :TlistToggle<cr>

    "let g:Tagbar_title     = "[Tagbar]"
    "let g:Tagbar_vertical  = 30
    "let g:tagbar_autofocus = 1
    "let g:Tagbar_width     = 30      " 设置窗口宽度
    "let g:Tagbar_left      = 0       " 在左侧窗口中显示

    "function! Tagbar_Start()
    "    "exe 'q'
    "    exe 'TagbarOpen'
    "endfunction

    "function! Tagbar_IsValid()
    "    return 1
    "endfunction
    " }}}
    " {{{   " neocomplcache
    "Bundle 'Shougo/neocomplcache'
    " 关键字补全、文件路径补全、tag补全等等，各种，非常好用，速度超快。
    " 在弹出补全列表后用 <c-p> 或 <c-n> 进行上下选择效果比较好
    let g:neocomplcache_enable_at_startup = 1               " vim 启动时启用插件
    "let g:neocomplcache_disable_auto_complete = 1          " 不自动弹出补全列表
    "let g:neocomplcache_enable_smart_case = 1
    "let g:neocomplcache_min_syntax_length = 3
    "let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
    "set completeopt-=preview

    " 启用自动代码提示
    "nmap <Leader>ne :NeoComplCacheToggle<CR>

    au FileType css setlocal dict+=~/.vim/dict/css.dict
    au FileType c setlocal dict+=~/.vim/dict/c.dict
    au FileType cpp setlocal dict+=~/.vim/dict/cpp.dict
    au FileType scale setlocal dict+=~/.vim/dict/scale.dict
    au FileType javascript setlocal dict+=~/.vim/dict/javascript.dict
    au FileType html setlocal dict+=~/.vim/dict/javascript.dict
    au FileType html setlocal dict+=~/.vim/dict/css.dict

    " Define dictionary.
    "let g:neocomplcache_dictionary_filetype_lists = {
    "    \ 'default' : '',
    "    \ 'css' : $VIMFILES.'/dict/css.dic',
    "    \ 'php' : $VIMFILES.'/dict/php.dic',
    "    \ 'javascript' : $VIMFILES.'/dict/javascript.dic'
    "\ }
    " }}}
    " {{{   " ctags
    Bundle 'vim-scripts/ctags.vim'
    " 对浏览代码非常的方便,可以在函数,变量之间跳转等
    "   vim:!ctags -R重编译ctags文件,win先ctags.exe放vim73/
    "   ctrl_] 跳转到对应函数 ctrl_t 回跳
    if g:iswindows
        let Tlist_Ctags_Cmd = "ctags"
    else
        let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
    endif

    set tags=tags;
    set autochdir
    "nmap <M-F9> :!ctags --append=yes -f ~/.vim/systags --fields=+lS
    "nmap <C-F9> :!ctags -R --fields=+lS
    " }}}
    " {{{   " cscope
    "   用Cscope自己的话说 - "你可以把它当做是超过频的ctags"
    "   使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳转
    "   设定可以使用 quickfix 窗口来查看 cscope 结果
    if has("cscope")
        set cscopequickfix=s-,c-,d-,i-,t-,e-
        set cscopetag
        set csto=0  " 如果你想反向搜索顺序设置为1
        set cscopeverbose

        if filereadable("cscope.out")   " 在当前目录中添加任何数据库
            cs add cscope.out
        elseif $CSCOPE_DB != ""     " 否则添加数据库环境中所指出的
            cs add $CSCOPE_DB
        endif

        " 快捷键设置
        nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
        nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
        nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
        nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    endif
    " }}}
    " {{{   " cSyntaxAfter
    Bundle 'vim-scripts/cSyntaxAfter'
    " 高亮括号与运算符等
    au! BufRead,BufNewFile,BufEnter *.{c,cpp,h,javascript} call CSyntaxAfter()
    " }}}
    " {{{   " powerline
    Bundle 'Lokaltog/vim-powerline'
    " 状态栏插件，更好的状态栏效果
    nmap <leader>l :IndentLinesToggle<CR>
    let g:indentLine_color_gui = '#A4E57E'
    let g:indentLine_char = 'c'
    " }}}
    " {{{   " indentLine
    Bundle 'vim-scripts/indentLine.vim'
    " 用于显示对齐线，与 indent_guides 在显示方式上不同，根据自己喜好选择了
    " 在终端上会有屏幕刷新的问题，这个问题能解决有更好了

    " 开启/关闭对齐线
    nmap <leader>il :IndentLinesToggle<CR>

    " 设置Gvim的对齐线样式
    "if g:isGUI
        let g:indentLine_char = "┊"
        let g:indentLine_first_char = "┊"
    "endif

    "let g:indentLine_color_term = 239           " 设置终端对齐线颜色
    "let g:indentLine_color_gui  = '#A4E57E'     " 设置 GUI 对齐线颜色
    " }}}
    " {{{   " Mark
    Bundle 'vim-scripts/Mark--Karkat'
    " 给不同的单词高亮，表明不同的变量时很有用，详细帮助见 :h mark.txt
    " }}}
    " {{{   " grep
    Bundle 'vim-scripts/grep.vim'
    " 在工程中快速查找 F3
    nnoremap <silent> <F3> :Grep<CR>
    " }}}
    " {{{   " multisearch
    Bundle 'vim-scripts/multisearch.vim'
    " }}}
    " {{{   " Emmet
    Bundle 'https://github.com/vim-scripts/Emmet.vim.git'
    " 常用命令：http://nootn.com/blog/Tool/23/
    " https://raw.github.com/mattn/zencoding-vim/master/TUTORIAL

    " zencoding.vim 的设定
    "   html:xxs>div#header+div#container>ul>li.class_$#id_$*2
    "   按下 <ctrl+y> 然后 点 , 逗号
    "   ul>li*
    "   移动到网址上,<C-y>a 加入a标签
    "   移动到一个整体标签上<C-y>/加入html注释,<C-y>/再按取消
    "   ul>li*
    "   ul>li*
    "   html:xt <c+y> ,

    let g:user_zen_settings = {
        \ 'lang': "zh-cn"
        \ }
    " <c-y>m  合并多行
    " }}}
    " {{{   " TxtBrowser
    Bundle 'TxtBrowser'
    au BufRead,BufNewFile * setfiletype txt    " work in linux
    set syntax=txt                             " work in linux
    " 用于文本文件生成标签与与语法高亮（调用TagList插件生成标签，如果可以）
    au BufRead,BufNewFile *.txt setlocal ft=txt
    " }}}
    " {{{   " debug
    "Bundle 'vim-scripts/debug.vim'
    "   ,dr ,di ,do ,dt  = F1,F2,F3,F4
    "   ,e debugger_watch_input
    "   F1 debugger_resize
    "   F2 debugger_step_into
    "   F3 debugger_step_over
    "   F4 debugger_step_out
    "   S-F5 debugger_quit
    "   F5 debugger_run
    "   F10 debugger_watch_input
    "   F11 debugger_context
    "   F12 debugger_property
    "   F11 debugger_watch_input A
    "   F12 debugger_watch_input

    "let g:debuggerPort = 9001
    " }}}
    " {{{   " quickfix
    "   :cc 显示详细错误信息 ( :help :cc )
    "   :cp 跳到上一个错误 ( :help :cp )
    "   :cn 跳到下一个错误 ( :help :cn )
    "   :cl 列出所有错误 ( :help :cl )
    "   :cw 如果有错误列表，则打开quickfix窗口 ( :help :cw )
    "   :col到前一个旧的错误列表 ( :help :col )
    "   :cnew 到后一个较新的错误列表 ( :help :cnew )
    "autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
    " }}}
    " {{{   " OmniCppComplete
    Bundle 'dradtke/OmniCppComplete'
    " 用于C/C++代码补全，这种补全主要针对命名空间、类、结构、共同体等进行补全，详细
    " 说明可以参考帮助或网络教程等
    " 使用前先执行如下 ctags 命令（本配置中可以直接使用 ccvext 插件来执行以下命令）
    " ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
    " 我使用上面的参数生成标签后，对函数使用跳转时会出现多个选择
    " 所以我就将--c++-kinds=+p参数给去掉了，如果大侠有什么其它解决方法希望不要保留呀
    set completeopt=menu                        " 关闭预览窗口
    " }}}
    " {{{   " supertab
    "Bundle 'ervandew/supertab'
    " 我主要用于配合 omnicppcomplete 插件，在按 Tab 键时自动补全效果更好更快
    "let g:supertabdefaultcompletiontype = "<c-x><c-u>"
    " }}}
    "Bundle 'vim-scripts/txt.vim'
    "-----------------------------------------------------------------------------------------------
    " {{{   " Syntax
    " Bundle 'othree/html5.vim'
    " Bundle 'asins/vim-css'
    " Bundle 'pangloss/vim-javascript'
    " Bundle 'nono/jquery.vim'
    " Bundle 'python.vim--Vasiliev'
    " Bundle 'tpope/vim-markdown'
    " }}}
    "-----------------------------------------------------------------------------------------------
    " {{{   " PHP
    " PHP 语法检查 F5
    "   :php  --check for syntax errors
    map <F5> :!php -l %<CR>

    source $VIMRUNTIME/syntax/php.vim   " php高亮highlight

    let PHP_autoformatcomment    = 1                            " php缩进
    let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']

    au FileType php setlocal dict+=~/.vim/dict/php_funclist.dict
    " }}}
    " {{{   " phpqa
    "Bundle 'https://github.com/joonty/vim-phpqa.git'
    " php code sniffer ,php md模式
    " :Phpcs || :Phpmd
    "map <leader>pc :Phpcs<cr>
    "map <leader>pm :Phpmd<cr>

    " phpcs--run code sniffer
    " autorun default = 1 on save
    "let g:phpqa_codesniffer_autorun = 0
    "let g:phpqa_codesniffer_args    = "--standard=YahooNevec --extensions=php,inc"
    "let g:phpqa_codesniffer_cmd     = '/usr/bin/phpcs'

    " phpmd--run mess detector(要XML rule)
    "let g:phpqa_messdetector_ruleset = '/usr/lib/php/pear/data/PHP_PMD/resources/phpmd_ruleset.xml'
    "let g:phpqa_messdetector_cmd     = '/usr/bin/phpmd'
    "let g:phpqa_messdetector_autorun = 0
    " phpcc--show code coverage
    " }}}
    "-----------------------------------------------------------------------------------------------
    " {{{   " C/C++
    " F6编译和运行C程序，F7编译和运行C++程序
    " 编译、连接、运行配置
    " F9 一键保存、编译、连接存并运行
    map <F6> :call Run()<CR>
    imap <F6> <ESC>:call Run()<CR>
    " Ctrl + F9 一键保存并编译
    map <c-F6> :call Compile()<CR>
    imap <c-F6> <ESC>:call Compile()<CR>
    " Ctrl + F10 一键保存并连接
    map <c-F7> :call Link()<CR>
    imap <c-F7> <ESC>:call Link()<CR>

    let s:LastShellReturn_C = 0
    let s:LastShellReturn_L = 0
    let s:ShowWarning       = 1
    let s:Obj_Extension     = '.o'
    let s:Exe_Extension     = '.exe'
    let s:Sou_Error         = 0
    let s:windows_CFlags    = 'gcc\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
    let s:linux_CFlags      = 'gcc\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
    let s:windows_CPPFlags  = 'g++\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
    let s:linux_CPPFlags    = 'g++\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'

    func! Compile()     " {{{
        exe ":ccl"
        exe ":update"
        if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
            let s:Sou_Error = 0
            let s:LastShellReturn_C = 0
            let Sou = expand("%:p")
            let Obj = expand("%:p:r").s:Obj_Extension
            let Obj_Name = expand("%:p:t:r").s:Obj_Extension
            let v:statusmsg = ''
            if !filereadable(Obj) || (filereadable(Obj) && (getftime(Obj) < getftime(Sou)))
                redraw!
                if expand("%:e") == "c"
                    if g:iswindows
                        exe ":setlocal makeprg=".s:windows_CFlags
                    else
                        exe ":setlocal makeprg=".s:linux_CFlags
                    endif
                    echohl WarningMsg | echo " compiling..."
                    silent make
                elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                    if g:iswindows
                        exe ":setlocal makeprg=".s:windows_CPPFlags
                    else
                        exe ":setlocal makeprg=".s:linux_CPPFlags
                    endif
                    echohl WarningMsg | echo " compiling..."
                    silent make
                endif
                redraw!
                if v:shell_error != 0
                    let s:LastShellReturn_C = v:shell_error
                endif
                if g:iswindows
                    if s:LastShellReturn_C != 0
                        exe ":bo cope"
                        echohl WarningMsg | echo " compilation failed"
                    else
                        if s:ShowWarning
                            exe ":bo cw"
                        endif
                        echohl WarningMsg | echo " compilation successful"
                    endif
                else
                    if empty(v:statusmsg)
                        echohl WarningMsg | echo " compilation successful"
                    else
                        exe ":bo cope"
                    endif
                endif
            else
                echohl WarningMsg | echo ""Obj_Name"is up to date"
            endif
        else
            let s:Sou_Error = 1
            echohl WarningMsg | echo " please choose the correct source file"
        endif
        exe ":setlocal makeprg=make"
    endfunc     " }}}
    func! Link()    " {{{
        call Compile()
        if s:Sou_Error || s:LastShellReturn_C != 0
            return
        endif
        let s:LastShellReturn_L = 0
        let Sou = expand("%:p")
        let Obj = expand("%:p:r").s:Obj_Extension
        if g:iswindows
            let Exe = expand("%:p:r").s:Exe_Extension
            let Exe_Name = expand("%:p:t:r").s:Exe_Extension
        else
            let Exe = expand("%:p:r")
            let Exe_Name = expand("%:p:t:r")
        endif
        let v:statusmsg = ''
        if filereadable(Obj) && (getftime(Obj) >= getftime(Sou))
            redraw!
            if !executable(Exe) || (executable(Exe) && getftime(Exe) < getftime(Obj))
                if expand("%:e") == "c"
                    setlocal makeprg=gcc\ -o\ %<\ %<.o
                    echohl WarningMsg | echo " linking..."
                    silent make
                elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                    setlocal makeprg=g++\ -o\ %<\ %<.o
                    echohl WarningMsg | echo " linking..."
                    silent make
                endif
                redraw!
                if v:shell_error != 0
                    let s:LastShellReturn_L = v:shell_error
                endif
                if g:iswindows
                    if s:LastShellReturn_L != 0
                        exe ":bo cope"
                        echohl WarningMsg | echo " linking failed"
                    else
                        if s:ShowWarning
                            exe ":bo cw"
                        endif
                        echohl WarningMsg | echo " linking successful"
                    endif
                else
                    if empty(v:statusmsg)
                        echohl WarningMsg | echo " linking successful"
                    else
                        exe ":bo cope"
                    endif
                endif
            else
                echohl WarningMsg | echo ""Exe_Name"is up to date"
            endif
        endif
        setlocal makeprg=make
    endfunc     " }}}
    func! Run()     " {{{
        let s:ShowWarning = 0
        call Link()
        let s:ShowWarning = 1
        if s:Sou_Error || s:LastShellReturn_C != 0 || s:LastShellReturn_L != 0
            return
        endif
        let Sou = expand("%:p")
        let Obj = expand("%:p:r").s:Obj_Extension
        if g:iswindows
            let Exe = expand("%:p:r").s:Exe_Extension
        else
            let Exe = expand("%:p:r")
        endif
        if executable(Exe) && getftime(Exe) >= getftime(Obj) && getftime(Obj) >= getftime(Sou)
            redraw!
            echohl WarningMsg | echo " running..."
            if g:iswindows
                exe ":!%<.exe"
            else
                if g:isGUI
                    exe ":!gnome-terminal -e ./%<"
                else
                    exe ":!./%<"
                endif
            endif
            redraw!
            echohl WarningMsg | echo " running finish"
        endif
    endfunc     " }}}

    " 显示.NFO文件
    function! SetFileEncodings(encodings)
        let b:myfileencodingsbak=&fileencodings
        let &fileencodings=a:encodings
    endfunction
    function! RestoreFileEncodings()
        let &fileencodings=b:myfileencodingsbak
        unlet b:myfileencodingsbak
    endfunction
    au BufReadPre *.nfo call SetFileEncodings('cp437') | set ambiwidth=single
    au BufReadPost *.nfo call RestoreFileEncodings()
    " }}}
    " {{{   " Align
    Bundle 'Align'
    " 一个对齐的插件，用来——排版与对齐代码，功能强大，不过用到的机会不多
    " }}}
    " {{{   " a.vim
    Bundle 'a.vim'
    " 用于切换C/C++头文件
    " :A     ---切换头文件并独占整个窗口
    " :AV    ---切换头文件并垂直分割窗口
    " :AS    ---切换头文件并水平分割窗口
    " }}}
    " {{{   " std_c
    Bundle 'std_c.zip'
    " 用于增强C语法高亮
    " 启用 // 注视风格
    let c_cpp_comments = 0
    " }}}
    endif
    "===============================================================================================
"===================================================================================================

"===================================================================================================
" 风格颜色
"===================================================================================================
" Term 黑白终端 cterm 彩色终端 ctermfg彩色终端前景色 ctermbg 彩色终端背景色
" Gui GUI版本属性 guifg GUI版本的前景色 guibg GUI版本的背景色
if has("gui_running")
    "===============================================================================================
    " GUI
    "===============================================================================================
    " {{{
    hi  Cursor          guifg=#FBFDFC   guibg=#000201   gui=NONE    " 光标所在的字符 #64574e
    hi  CursorColumn                    guibg=#3E3F40   gui=NONE    " 光标所在的屏幕列
    hi  CursorLine                      guibg=#3E3E3E   gui=NONE    " 光标所在的屏幕行 #666666
    hi  Directory       guifg=#FF3F3F   guibg=#1C1D1F   gui=NONE    " 目录名
    hi  DiffAdd         guifg=#FFFFCD   guibg=#306D30   gui=NONE    " diff: 增加的行#FFFFFF #7F7F00
    hi  DiffChange      guifg=#BFBFBF   guibg=#1C1D1F   gui=NONE    " diff: 改变的行#FFFFFF #7F007F #306B8F
    hi  DiffDelete      guifg=#FFFFCD   guibg=#6D3030   gui=NONE    " diff: 删除的行#FFFFFF #007F7F
    hi  DiffText        guifg=#FFFFCD   guibg=#4A2A4A   gui=NONE    " diff: 改变行里的改动文本#007F00 #1C1D1F
    hi  ErrorMsg        guifg=#FF3F3F   guibg=#1C1D1F   gui=NONE    " 命令行上的错误信息
    hi  VertSplit       guifg=#FF3F3F   guibg=#3F3FFF   gui=NONE    " 分离垂直分割窗口的列
    hi  Folded          guifg=#DDEEFE   guibg=#FF3F3A   gui=NONE    " 用于关闭的折叠的行
    hi  IncSearch       guifg=#FF0000   guibg=#DDA0DD   gui=NONE    " 'incsearch' 高亮
    hi  LineNr          guifg=#4D4D4B   guibg=#000000   gui=NONE    " 置位number选项时的行号
    hi  MatchParen      guifg=#FF7F3F   guibg=#1C1D1F   gui=NONE    " 配对的括号
    hi  MatchParen      guifg=#FFD6EB   guibg=#FF5CAF   gui=NONE    " 配对的括号
    hi  ModeMsg         guifg=#FF7F00   guibg=#1C1D1F   gui=NONE    " showmode 消息(INSERT)
    hi  MoreMsg         guifg=#BFBF3F   guibg=#1C1D1F   gui=NONE    " |more-prompt|
    hi  NonText         guifg=#007FFF   guibg=#1C1D1F   gui=NONE    " 窗口尾部的'~'和 '@'
    hi  Normal          guifg=#BFBFBF   guibg=#1C1D1F   gui=NONE    " 正常内容
    hi  Pmenu           guifg=#FFFFFF   guibg=#7373CF   gui=NONE    " 弹出菜单普通项目
    hi  PmenuSel        guifg=#DDEEFF   guibg=#FF3F3F   gui=NONE    " 弹出菜单选中项目
    hi  PmenuSbar       guifg=#3F3FFF   guibg=#FFF43F   gui=NONE    " 弹出菜单滚动条。
    hi  PmenuThumb      guifg=#FFF43F   guibg=#757473   gui=NONE    " 弹出菜单滚动条的拇指
    hi  Question        guifg=#7F7F7F   guibg=#1C1D1F   gui=NONE    " 提示和yes/no 问题
    hi  Search          guifg=#E10000   guibg=#ffffff   gui=NONE    " 最近搜索模式的高亮
    hi  SpecialKey      guifg=#4c4c4c   guibg=#1C1D1F   gui=NONE    " 特殊键，字符和'listchars'
    hi  SpellBad        guifg=#FF0000   guibg=#1C1D1F   gui=NONE    " 拼写检查器不能识别的单词
    hi  SpellCap        guifg=#BF0000   guibg=#1C1D1F   gui=NONE    " 应该大写字母开头的单词
    hi  SpellLocal      guifg=#FF00FF   guibg=#1C1D1F   gui=NONE    " 只在其它区域使用的单词
    hi  SpellRare       guifg=#FF7FFF   guibg=#1C1D1F   gui=NONE    " 很少使用的单词
    "hi  StatusLine      guifg=#D8BFD8   guibg=#696969   gui=NONE    " 当前窗口的状态行
    "hi  StatusLineNC    guifg=#FFFFFF   guibg=#3F3F3F   gui=NONE    " 非当前窗口的状态行
    hi  TabLine         guifg=#1C1D1F   guibg=#BFBFBF   gui=NONE    " 非活动标签页标签
    hi  TabLineFill     guifg=#1C1D1F   guibg=#FFFFFF   gui=NONE    " 没有标签的地方
    hi  TabLineSel      guifg=#FFFF00   guibg=#0000FF   gui=NONE    " 活动标签页标签
    hi  Title           guifg=#007FBF   guibg=#1C1D1F   gui=NONE    " :set all 等输出的标题
    hi  Visual          guifg=#2F4F4F   guibg=#ADD8E6   gui=NONE    " 可视模式的选择区
    hi  WarningMsg      guifg=#FF003F   guibg=#1C1D1F   gui=NONE    " 警告消息
    hi  WildMenu        guifg=#FF7F00   guibg=#0000FF   gui=NONE    " wildmenu补全的当前匹配
    " }}}
    "===============================================================================================
    " GUI group-name
    "===============================================================================================
    " {{{
    hi  Comment     guifg=#87CEEB   guibg=#1C1D1F   gui=NONE    " 任何注释 #747474 #87CEEB
    "-----------------------------------------------------------------------------------------------
    hi  Constant    guifg=#BF007F   guibg=#1C1D1F   gui=NONE    " 任何常数 #96CBFE #BF007F
    hi  String      guifg=#A3BCBC   guibg=#1C1D1F   gui=NONE    " 一个字符串常数: "字符串" #A8FF60 #A3BCBC
    hi  Character   guifg=#FF3F3F   guibg=#1C1D1F   gui=NONE    " 一个字符常数: 'c'、'\n'
    hi  Number      guifg=#FF7F3F   guibg=#1C1D1F   gui=NONE    " 一个数字常数: 234、0xff
    hi  Float       guifg=#FF7F3F   guibg=#1C1D1F   gui=NONE    " 一个浮点常数: 2.3e10
    hi  Boolean     guifg=#FF0000   guibg=#1C1D1F   gui=NONE    " 一个布尔型常数: TRUE、false
    "-----------------------------------------------------------------------------------------------
    hi  Identifier  guifg=#007FBF   guibg=#1C1D1F   gui=NONE    " 任何变量名
    hi  Function    guifg=#00BFBF   guibg=#1C1D1F   gui=NONE    " 函数名 (也包括: 类的方法名) #FFD2A7 #00BFBF
    "-----------------------------------------------------------------------------------------------
    hi  Statement       guifg=#B8B1D3   guibg=#1C1D1F   gui=NONE    " 任何语句
    hi  Conditional     guifg=#FFFF33   guibg=#1C1D1F   gui=NONE    " if、then、else、endif、switch
    hi  Repeat          guifg=#FFBF00   guibg=#1C1D1F   gui=NONE    " for、do、while 等
    hi  Label           guifg=#1E90FF   guibg=#1C1D1F   gui=NONE    " case、default 等
    hi  Operator        guifg=#BFFF00   guibg=#1C1D1F   gui=NONE    " sizeof"、"+"、"*" 等
    hi  Keyword         guifg=#BFBF00   guibg=#1C1D1F   gui=NONE    " 任何其它关键字
    hi  Exception       guifg=#BF7F00   guibg=#1C1D1F   gui=NONE    " try、catch、throw
    "-----------------------------------------------------------------------------------------------
    hi  PreProc     guifg=#FF63FF   guibg=#1C1D1F   gui=NONE    " 通用预处理命令 #C71585 #FF63FF
    hi  Include     guifg=#FF00FF   guibg=#1C1D1F   gui=NONE    " 预处理命令 #include
    hi  Define      guifg=#BF3FBF   guibg=#1C1D1F   gui=NONE    " 预处理命令 #define #96CBEF #BF3FBF
    hi  Macro       guifg=#FFFFFF   guibg=#1C1D1F   gui=NONE    " 等同于 Define #7F00BF
    hi  PreCondit   guifg=#FF007F   guibg=#1C1D1F   gui=NONE    " 预处理命令 #if、#else、#endif
    "-----------------------------------------------------------------------------------------------
    hi  Type            guifg=#96CBFE   guibg=#1C1D1F   gui=NONE    " int、long、char 等 #96CBFE #00C000
    hi  StorageClass    guifg=#7FFF00   guibg=#1C1D1F   gui=NONE    " static、register、volatile 等
    hi  Structure       guifg=#00FF7F   guibg=#1C1D1F   gui=NONE    " struct、union、enum 等
    hi  Typedef         guifg=#3FFF3F   guibg=#1C1D1F   gui=NONE    " 一个typedef
    "-----------------------------------------------------------------------------------------------
    hi  Special         guifg=#BFBF3F   guibg=#1C1D1F   gui=NONE    " 任何特殊符号
    hi  SpecialChar     guifg=#FFBF3F   guibg=#1C1D1F   gui=NONE    " 常数中的特殊字符
    hi  Tag             guifg=#BFFF3F   guibg=#1C1D1F   gui=NONE    " 这里可以使用 CTRL-]
    hi  Delimiter       guifg=#FF3F00   guibg=#1C1D1F   gui=NONE    " 需要注意的字符
    hi  SpecialComment  guifg=#FF00BF   guibg=#1C1D1F   gui=NONE    " 注释里的特殊字符 #FF00BF
    hi  Debug           guifg=#BF00FF   guibg=#1C1D1F   gui=NONE    " 调试语句
    "-----------------------------------------------------------------------------------------------
    hi  Underlined  guifg=#3F3FFF   guibg=#1C1D1F   gui=UNDERLINE   " 需要突出的文本，HTML 链接
    hi  Ignore      guifg=#7F7F7F   guibg=#1C1D1F   gui=NONE        " 留空，被隐藏
    hi  Error       guifg=#CFCFCF   guibg=#CF6C6C   gui=NONE        " 任何有错的构造
    hi  Todo        guifg=#FFFFFF   guibg=#0000FF   gui=NONE        " 任何需要特殊注意的部分
    "-----------------------------------------------------------------------------------------------
    "hi  HtmlTagN    guifg=#7F7F7F   guibg=#1C1D1F   gui=NONE    " HtmlTagN
    "hi  cssStyle    guifg=#008B8B   guibg=#1C1D1F   gui=NONE    " cssStyle
    "hi  phpLabel    guifg=#008B8B   guibg=#1C1D1F   gui=NONE    " phpLabel
    " }}}
    "===============================================================================================
    " html,css,php highlight
    "===============================================================================================
    " {{{
    "hi  cssAttributeSelector    guifg=#800000   guibg=#00FF00   gui=NONE
    hi  cssDefinition           guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  cssFontDescriptorBlock  guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  cssLength               guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  cssMediaBlock           guifg=#800000   guibg=#00FF00   gui=NONE
    hi  cssMediaComma           guifg=#008B8B   guibg=#1C1D1F   gui=NONE    " css逗号
    hi  cssPseudoClass          guifg=#008B8B   guibg=#1C1D1F   gui=NONE    " css伪类符号
    hi  cssSpecialCharQ         guifg=#800000   guibg=#00FF00   gui=NONE
    hi  cssSpecialCharQQ        guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  cssString               guifg=#800000   guibg=#00FF00   gui=NONE
    hi  cssStringQ              guifg=#F4E3DC   guibg=#808080   gui=NONE    " css 字体单引号扩起来,src单引号
    hi  cssStringQQ             guifg=#F4E3DC   guibg=#808080   gui=NONE    " css 字体双引号扩起来,src双引号
    "hi  cssStyle                guifg=#800000    guibg=#00FF00  gui=NONE
    hi  cssURL                  guifg=#BAB5C9   guibg=#1C1D1F   gui=NONE    " css url color
    "-----------------------------------------------------------------------------------------------
    "hi  htmlBold                    guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  htmlBoldItalic              guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  htmlBoldItalicUnderline     guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  htmlBoldUnderline           guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  htmlBoldUnderlineItalic     guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  htmlItalic                  guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  htmlItalicBold              guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  htmlItalicBoldUnderline     guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  htmlItalicUnderline         guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  htmlItalicUnderlineBold     guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  htmlPreAttr                 guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  htmlRegion                  guifg=#800000   guibg=#00FF00   gui=NONE
    hi  htmlString                  guifg=#D7CDE4   guibg=#1C1D1F   gui=NONE    " HTML string,html的属性,""里面的
    "hi  htmlStyleArg                guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  htmlTagN                    guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  htmlUnderline               guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  htmlUnderlineBold           guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  htmlUnderlineBoldItalic     guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  htmlUnderlineItalic         guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  htmlUnderlineItalicBold     guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  htmlValue                   guifg=#800000   guibg=#00FF00   gui=NONE
    "-----------------------------------------------------------------------------------------------
    "hi  javaScriptCommentSkip   guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  javaScriptNumber        guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  javaScriptParens        guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  javaScriptRegexpString  guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  javaScriptStringD       guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  javaScriptStringS       guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  javaScriptValue         guifg=#800000   guibg=#00FF00   gui=NONE
    "-----------------------------------------------------------------------------------------------
    "hi  phpArrayComma                           guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpArrayRegion                          guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpArrayRegionSimple                    guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpBacktick                             guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpBlockRegion                          guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpBracketRegion                        guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpCaseRegion                           guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpCatchBlock                           guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpCatchRegion                          guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpClassBlock                           guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpClassStart                           guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpConstructRegion                      guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpDefineClassBlockCommentOneline       guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpDefineClassImplementsComma           guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpDefineClassImplementsCommentOneLine  guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpDefineClassImplementsName            guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpDefineClassName                      guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpDefineFuncBlockCommentOneline        guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpDefineFuncName                       guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpDefineFuncProto                      guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpDefineInterfaceName                  guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpDefineMethodName                     guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpDoBlock                              guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpDoWhileConstructRegion               guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpEchoRegion                           guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpErraticBracketRegion                 guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpFoldCatch                            guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpFoldClass                            guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpFoldFunction                         guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpFoldHtmlInside                       guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpFoldInterface                        guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpFoldTry                              guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpForRegion                            guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpForeachRegion                        guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpFuncBlock                            guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpHereDoc                              guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpIdentifierComplex                    guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpIdentifierInString                   guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpIdentifierInStringComplex            guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpIdentifierInStringErratic            guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpLabel                                guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpListComma                            guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpListRegion                           guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpMemberHere                           guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpMethodHere                           guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpMethodsVar                           guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpPREGArrayComma                       guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpPREGArrayOpenParent                  guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpPREGArrayRegion                      guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpPREGArrayStringDouble                guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpPREGArrayStringSingle                guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpPREGOpenParentMulti                  guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpPREGRegion                           guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpPREGRegionMulti                      guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpPREGStringDouble                     guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpPREGStringSingle                     guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpPREGStringStarter                    guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpParentRegion                         guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpPropertyHere                         guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpPropertyInString                     guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpProtoArray                           guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpQuoteDouble                          guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpQuoteSingle                          guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpRegion                               guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpRegionAsp                            guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpRegionSc                             guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpRegionSync                           guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpSpecialCharfold                      guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpStatementRegion                      guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpStaticAccess                         guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpStaticCall                           guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpStaticUsage                          guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpStaticVariable                       guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpStringDouble                         guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpStringDoubleConstant                 guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpStringRegular                        guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpStringSingle                         guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpStructureHere                        guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpSwitchBlock                          guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpSwitchConstructRegion                guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpSyncComment                          guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpSyncStartOfFile                      guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpSyncString                           guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpTernaryRegion                        guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  phpTryBlock                             guifg=#800000   guibg=#00FF00   gui=NONE
    "-----------------------------------------------------------------------------------------------
    "hi  pregClassEscapeDouble2      guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  pregClassEscapeMainQuote    guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  pregConcat                  guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  pregEscapeMainQuote         guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  pregNonSpecial              guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  pregNonSpecialEscape        guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  pregNonSpecial_D            guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  pregNonSpecial_S            guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  pregPattern                 guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  pregPattern_D               guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  pregPattern_S               guifg=#800000   guibg=#00FF00   gui=NONE
    "-----------------------------------------------------------------------------------------------
    "hi  sqlString                   guifg=#800000   guibg=#00FF00   gui=NONE
    "hi  vbString                    guifg=#800000   guibg=#00FF00   gui=NONE
    " }}}
    "===============================================================================================
else
    "===============================================================================================
    " Console
    "===============================================================================================
    " {{{
    "hi  Cursor          ctermfg=black           ctermbg=lightgreen      cterm=BOLD      " 光标所在的字符
    "hi  CursorColumn                            ctermbg=black           cterm=BOLD      " 光标所在的屏幕列
    "hi  CursorLine                              ctermbg=black           cterm=BOLD      " 光标所在的屏幕行
    "hi  Directory       ctermfg=lightmagenta    ctermbg=black           cterm=BOLD      " 目录名
    "hi  DiffAdd                                 ctermbg=lightgreen      cterm=BOLD      " diff: 增加的行
    "hi  DiffChange                              ctermbg=lightcyan       cterm=BOLD      " diff: 改变的行
    "hi  DiffDelete                              ctermbg=lightcyan       cterm=BOLD      " diff: 删除的行
    "hi  DiffText        ctermfg=lightgreen      ctermbg=black           cterm=BOLD      " diff: 改变行里的改动文本
    "hi  ErrorMsg        ctermfg=lightmagenta    ctermbg=black           cterm=BOLD      " 命令行上的错误信息
    "hi  VertSplit       ctermfg=lightmagenta    ctermbg=lightblue       cterm=BOLD      " 分离垂直分割窗口的列
    "hi  Folded          ctermfg=lightgrey       ctermbg=lightgreen      cterm=BOLD      " 用于关闭的折叠的行
    "hi  IncSearch       ctermfg=yellow          ctermbg=lightblue       cterm=BOLD      " 'incsearch' 高亮
    "hi  LineNr          ctermfg=yellow          ctermbg=black           cterm=BOLD      " 置位 number 选项时的行号
    "hi  MatchParen      ctermfg=lightred        ctermbg=black           cterm=BOLD      " 配对的括号
    "hi  MatchParen      ctermfg=yellow          ctermbg=lightred        cterm=BOLD      " 配对的括号
    "hi  ModeMsg         ctermfg=lightgreen      ctermbg=black           cterm=BOLD      " showmode 消息(INSERT)
    "hi  MoreMsg         ctermfg=lightcyan       ctermbg=black           cterm=BOLD      " |more-prompt|
    "hi  NonText         ctermfg=lightcyan       ctermbg=black           cterm=BOLD      " 窗口尾部的'~'和 '@'
    "hi  Normal          ctermfg=lightgrey       ctermbg=black           cterm=BOLD      " 正常内容
    "hi  Pmenu           ctermfg=lightgrey       ctermbg=lightblue       cterm=BOLD      " 弹出菜单普通项目
    "hi  PmenuSel        ctermfg=yellow          ctermbg=lightmagenta    cterm=BOLD      " 弹出菜单选中项目
    "hi  PmenuSbar       ctermfg=lightcyan       ctermbg=black           cterm=BOLD      " 弹出菜单滚动条。
    "hi  PmenuThumb      ctermfg=black           ctermbg=lightgreen      cterm=BOLD      " 弹出菜单滚动条的拇指
    "hi  Question        ctermfg=yellow          ctermbg=black           cterm=BOLD      " 提示和 yes/no 问题
    "hi  Search          ctermfg=yellow          ctermbg=lightblue       cterm=BOLD      " 最近搜索模式的高亮
    "hi  SpecialKey      ctermfg=lightgreen      ctermbg=black           cterm=BOLD      " 特殊键，字符和'listchars'
    "hi  SpellBad        ctermfg=lightred        ctermbg=black           cterm=BOLD      " 拼写检查器不能识别的单词
    "hi  SpellCap        ctermfg=lightred        ctermbg=black           cterm=BOLD      " 应该大写字母开头的单词
    "hi  SpellLocal      ctermfg=lightcyan       ctermbg=black           cterm=BOLD      " 只在其它区域使用的单词
    "hi  SpellRare       ctermfg=lightcyan       ctermbg=black           cterm=BOLD      " 很少使用的单词
    "hi  StatusLine      ctermfg=yellow          ctermbg=lightblue       cterm=BOLD      " 当前窗口的状态行
    "hi  StatusLineNC    ctermfg=yellow          ctermbg=black           cterm=BOLD      " 非当前窗口的状态行
    "hi  TabLine         ctermfg=black           ctermbg=black           cterm=BOLD      " 非活动标签页标签
    "hi  TabLineFill     ctermfg=black           ctermbg=lightgrey       cterm=BOLD      " 没有标签的地方
    "hi  TabLineSel      ctermfg=yellow          ctermbg=lightblue       cterm=BOLD      " 活动标签页标签
    "hi  Title           ctermfg=lightmagenta    ctermbg=black           cterm=BOLD      " :set all 等输出的标题
    "hi  Visual          ctermfg=yellow          ctermbg=lightblue       cterm=BOLD      " 可视模式的选择区
    "hi  WarningMsg      ctermfg=lightmagenta    ctermbg=black           cterm=BOLD      " 警告消息
    "hi  WildMenu        ctermfg=lightgreen      ctermbg=lightblue       cterm=BOLD      " wildmenu补全的当前匹配
    " }}}
    "===============================================================================================
    " Console group-name
    "===============================================================================================
    " {{{
    "hi  Comment     ctermfg=yellow      ctermbg=black   cterm=BOLD      " 任何注释
    "-----------------------------------------------------------------------------------------------
    "hi  Constant    ctermfg=brown           ctermbg=black   cterm=BOLD        "任何常数
    "hi  String      ctermfg=lightmagenta    ctermbg=black   cterm=BOLD  " 一个字符串常数:字符串
    "hi  Character   ctermfg=lightmagenta    ctermbg=black   cterm=BOLD  " 一个字符常数: 'c'、'\n'
    "hi  Number      ctermfg=lightgreen      ctermbg=black   cterm=BOLD  " 一个数字常数: 234、0xff
    "hi  Float       ctermfg=lightgreen      ctermbg=black   cterm=BOLD  " 一个浮点常数: 2.3e10
    "hi  Boolean     ctermfg=lightmagenta    ctermbg=black   cterm=BOLD  " 一个布尔型常数: TRUE、false
    "-----------------------------------------------------------------------------------------------
    "hi  Identifier  ctermfg=lightcyan   ctermbg=black   cterm=BOLD  " 任何变量名
    "hi  Function    ctermfg=lightcyan   ctermbg=black   cterm=BOLD  " 函数名 (也包括: 类的方法名)
    "-----------------------------------------------------------------------------------------------
    "hi  Statement   ctermfg=yellow      ctermbg=black   cterm=BOLD  " 任何语句
    "hi  Conditional ctermfg=yellow      ctermbg=black   cterm=BOLD  " if、then、else、endif、switch
    "hi  Repeat      ctermfg=yellow      ctermbg=black   cterm=BOLD  " for、do、while 等
    "hi  Label       ctermfg=yellow      ctermbg=black   cterm=BOLD  " case、default 等
    "hi  Operator    ctermfg=yellow      ctermbg=black   cterm=BOLD  " "sizeof"、"+"、"*" 等
    "hi  Keyword     ctermfg=yellow      ctermbg=black   cterm=BOLD  " 任何其它关键字
    "hi  Exception   ctermfg=lightred    ctermbg=black   cterm=BOLD  " try、catch、throw
    "-----------------------------------------------------------------------------------------------
    "hi  PreProc     ctermfg=lightmagenta    ctermbg=black   cterm=BOLD  " 通用预处理命令
    "hi  Include     ctermfg=lightmagenta    ctermbg=black   cterm=BOLD  " 预处理命令 #include
    "hi  Define      ctermfg=lightmagenta    ctermbg=black   cterm=BOLD  " 预处理命令 #define
    "hi  Macro       ctermfg=lightmagenta    ctermbg=black   cterm=BOLD  " 等同于 Define
    "hi  PreCondit   ctermfg=lightred        ctermbg=black   cterm=BOLD  " 预处理命令 #if、#else、#endif
    "-----------------------------------------------------------------------------------------------
    "hi  Type            ctermfg=lightgreen      ctermbg=black   cterm=BOLD  " int、long、char 等
    "hi  StorageClass    ctermfg=lightmagenta    ctermbg=black   cterm=BOLD  " static、register、volatile 等
    "hi  Structure       ctermfg=lightgreen      ctermbg=black   cterm=BOLD  " struct、union、enum 等
    "hi  Typedef         ctermfg=lightcyan       ctermbg=black   cterm=BOLD  " 一个 typedef
    "-----------------------------------------------------------------------------------------------
    "hi  Special         ctermfg=brown       ctermbg=black   cterm=BOLD  " 任何特殊符号
    "hi  SpecialChar     ctermfg=brown       ctermbg=black   cterm=BOLD  " 常数中的特殊字符
    "hi  Tag             ctermfg=lightcyan   ctermbg=black   cterm=BOLD  " 这里可以使用 CTRL-]
    "hi  Delimiter       ctermfg=lightgreen  ctermbg=black   cterm=BOLD  " 需要注意的字符
    "hi  SpecialComment  ctermfg=lightred    ctermbg=black   cterm=BOLD  " 注释里的特殊字符
    "hi  Debug           ctermfg=lightcyan   ctermbg=black   cterm=BOLD  " 调试语句
    "-----------------------------------------------------------------------------------------------
    "hi  Underlined  ctermfg=lightcyan   ctermbg=black       cterm=BOLD  " 需要突出的文本，HTML 链接
    "hi  Ignore      ctermfg=darkgrey    ctermbg=black       cterm=NONE  " 留空，被隐藏
    "hi  Error       ctermfg=yellow      ctermbg=lightred    cterm=BOLD  " 任何有错的构造
    "hi  Todo        ctermfg=lightgrey   ctermbg=lightblue   cterm=BOLD  " 任何需要特殊注意的部分
    " }}}
    "===============================================================================================
endif
"===================================================================================================

"===================================================================================================
" 快捷键
"===================================================================================================
" {{{
" :%s/^\s\+//g                             " 删除行首空格
" :%s/\s\+$//g                             " 删除行末空格
" :g/^$/d                                  " 删除没有内容的空行
" :g/^\s*$/d                               " 删除有空格组成的空格
" :%s/
"//g                                       " 删除行末^M的符号
" gf                                       " 在鼠标下打开当前路径的文件
" <c-w>f                                   " open in a new window
" <c-w>gf                                  " open in a new tab
" :n1,n2 co n3                             " copy n1~n2 to under the n3
" :n1,n2 m n3                              " move n1~n2 to under the n3
" :n1,n2 w filename                        " save n1~n2 to filename
" n+   n-                                  " 光标移动多少行
" n$                                       " 光标移至第n行尾
" 0 $                                      " 光标移至当前行首 当前行尾
" H M L                                    " 光标移至 屏幕顶行 中间行 屏幕最后行
" ctrl+u ctrl+d                            " 向文件首(尾) 翻半屏
" ctrl+f ctrl+b                            " 向文件首(尾) 翻一屏
" nz                                       " 将第n行滚至屏幕顶部,不指定n时将当前行滚至屏幕顶
" :g/^/exe ":s/^/".line(".")               " 每行插入行号
" :g/<input|<form/p                        " 显示含<input或<form的行
" :bufdo /searchstr                        " 在多个buff中搜索
" :argdo /searchstr
" xp   ddp                                 " 交换前后两个字符的位置 上下两行的位置交换
" `,<C-O> <C-I>                            " 跳转足迹 回跳(从最近的一次开始) 向前跳
" :gg=G                                    " 格式化, ggVG =
"reg                                       " /d      digit                   [0-9]
"reg                                       " /D      non-digit               [^0-9]
"reg                                       " /x      hex digit               [0-9a-fA-F]
"reg                                       " /X      non-hex digit           [^0-9a-fA-F]
"reg                                       " /s      white space             [       ]     (<Tab> and <Space>)
"reg                                       " /S      non-white characters    [^      ]     (not <Tab> and <Space>)
"reg                                       " /l      lowercase alpha         [a-z]
"reg                                       " /L      non-lowercase alpha     [^a-z]
"reg                                       " /u      uppercase alpha         [A-Z]
"reg                                       " /U      non-uppercase alpha     [^A-Z]"}}
" m a   (MARK)                             " 把这个地方标示成a    a can replace from (a~z)
" 'a    (quote character)                  " jump to aaa
" ''    (press ' twice)                    " 移动光标到上一个标记
" {                                        " jump to  跳到上一段的开头
" }                                        " jump to  跳到下一段的的开头.
" (                                        " 移到这个句子的开头
" )                                        " 移到下一个句子的开头
" [[                                       " 跳往上一个函式
" ]]                                       " 跳往下一个函式
" `.                                       " 移动光标到上一次的修改点
" '.                                       " 移动光标到上一次的修改行
" <shift-c>                                " 删除到行末并直接进入插入模式
" %                                        " 跳到匹配的左/右括号上
" zz                                       " 移动当前行到屏幕中央
" zt                                       " 移动当前行到屏幕顶部
" zb                                       " 移动当前行到屏幕底部
" *                                        " 读取光标处的字符串,并且移动光标到它再次出现的地方
" #                                        " 和上面的类似,但是是往反方向寻找
" guu                                      " 行小写
" gUU                                      " 行大写
" g~~                                      " 行翻转(大小写)
" guw gUw g~w                              " 字*写
" \'.                                      " 跳到最后修改的那一行
" `.                                       " 跳到最后修改的那一行，定位到修改点
" :ju(mps)                                 " 列出跳转足迹
" !!date                                   " 读取date的输出 (但是会替换当前行的内容)
" :bn                                      " 跳转到下一个buffer
" :bp                                      " 跳转到上一个buffer
" :wn                                      " 存盘当前文件并跳转到下一个
" :wp                                      " 存盘当前文件并跳转到上一个
" :bd                                      " 把这个文件从buffer列表中做掉
" :b 3                                     " 跳到第3个buffer
" :b main                                  " 跳到一个名字中包含main的buffer,例如main.c
" :sav php.html                            " 把当前文件存为php.html并打开php.html
" :sav! %<.bak                             " 换一个后缀保存
" :e!                                      " 返回到修改之前的文件(修改之后没有存盘)
" :w /path/%                               " 把文件存到一个地儿
" :rew                                     " 回到第一个可编辑的文件
" :brew                                    " 回到第一个buffer
" gvim -o file1 file2                      " 以分割窗口打开两个文件\r\n# 指出打开之后执行的命令
" gvim -d file1 file2                      " vimdiff (比较不同)
" dp                                       " 把光标处的不同放到另一个文件
" do                                       " 在光标处从另一个文件取得不同
" diw                                      " 删除光标上的单词 (不包括空白字符)
" daw                                      " 删除光标上的单词 (包括空白字符)
" dl                                       " delete character (alias: x)
" diw                                      " delete inner word
" daw                                      " delete a word
" diW                                      " delete inner WORD (see |WORD|)
" daW                                      " delete a WORD (see |WORD|)
" dd                                       " delete one line
" dis                                      " delete inner sentence
" das                                      " delete a sentence
" dib                                      " delete inner '(' ')'
" dab                                      " delete a '(' ')'
" dip                                      " delete inner paragraph
" dap                                      " delete a paragraph
" diB                                      " delete inner '{' '}'
" daB                                      " delete a '{' '}'
" :1,20s/^/#/g                             " 添加注释  :1,20s/^/\/\//g
" 0                                        " 至本行第一个字符=<Home>
" ^                                        " 至本行第一个非空白字符
" N $                                      " 至本行最后一个字符
" gm                                       " 至屏幕行中点(当前行中点)
" N |                                      " 至第 N 列 (缺省: 1)
" N  f{char}                               " 至右边第 N 次出现 {char} 之处 (find)
" N  F{char}                               " 至左边第 N 次出现 {char} 之处 (Find)
" N  t{char}                               " 至右边第 N 次出现 {char} 之前 (till)
" N  T{char}                               " 至左边第 N 次出现 {char} 之前 (Till)
" N  ;                                     " 重复上次 f、F、t 或 T 命令 N 次
" N  ,                                     " 以相反方向重复上次 f、F、T 或 t 命令 N
" N  -                                     " 上移 N 行，至第一个非空白字符
" N  +                                     " 下移 N 行，至第一个非空白字符 (亦: CTRL-M 和 <CR>)
" N  _                                     " 下移 N - 1 行，至第一个非空白字符
" N  G                                     " 至第 N 行 (缺省: 末行) 第一个非空白字符
" N  gg                                    " 至第 N 行 (缺省: 首行) 第一个非空白字符
" N  %                                     " 至全文件行数百分之 N 处；必须给出 N，否则是 |%| 命令
" N  gk                                    " 上移 N 屏幕行 (回绕行时不同于 k)
" N  gj                                    " 下移 N 屏幕行 (回绕行时不同于 j)
" N  w                                     " 向前 (正向，下同) N 个单词(word)
" N  W                                     " 向前 N 个空白隔开的字串 |WORD|            (WORD)
" N  e                                     " 向前至第 N 个单词词尾                     (end)
" N  E                                     " 向前至第 N 个空白隔开的字串 |WORD| 的词尾 (End)
" N  b                                     " 向后 (反向，下同) N 个单词                (backward)
" N  B                                     " 向后至第 N 个空白隔开的字串 |WORD| 的词尾 (Backward)
" N  ge                                    " 向后至第 N 个单词词尾
" N  gE                                    " 向后至第 N 个空白隔开的字串 |WORD| 的词尾
" N  )                                     " 向前 N 个句子
" N  (                                     " 向后 N 个句子
" N  }                                     " 向前 N 个段落
" N  {                                     " 向后 N 个段落
" N  ]]                                    " 向前 N 个小节，置于小节的开始
" N  [[                                    " 向后 N 个小节，置于小节的开始
" N  ][                                    " 向前 N 个小节，置于小节的末尾
" N  []                                    " 向后 N 个小节，置于小节的末尾
" N  [(                                    " 向后至第 N 个未闭合的 '('
" N  [{                                    " 向后至第 N 个未闭合的 '{'
" N  [m                                    " 向后至第 N 个方法 (method) 的开始 (用于 Java)
" N  [M                                    " 向后至第 N 个方法的结束 (Method)  (用于 Java)
" N  ])                                    " 向前至第 N 个未闭合的 ')'
" N  ]}                                    " 向前至第 N 个未闭合的 '}'
" N  ]m                                    " 向前至第 N 个方法 (method) 的开始 (用于 Java)
" N  ]M                                    " 向前至第 N 个方法的结束 (Method)  (用于 Java)
" N  [#                                    " 向后至第 N 个未闭合的 #if 或 #else
" N  ]#                                    " 向前至第 N 个未闭合的 #else 或 #endif
" N  [*                                    " 向后至第 N 个注释的开始 /*
" N  ]*                                    " 向前至第 N 个注释的结束 */
" a
" N  ]*                                    " 向前至第 N 个注释的结束 */
" .                                        " 匹配任意单个字符
" ^                                        " 匹配行首
" $                                        " 匹配<EOL>
" \<                                       " 匹配单词开始
" \>                                       " 匹配单词结束
" [a-z]  \[a-z]                            " 匹配单个设定范围的字符
" [^a-z] \[^a-z]                           " 同上..不匹配
" \s                                       " 匹配一个空白字符
" \S                                       " 匹配一个非空字符
" \e                                       " 匹配<Esc>
" \t                                       " 匹配<Tab>
" \r                                       " 匹配<CR>
" \b                                       " 匹配<BS> backspace
" * \*                                     " 匹配0或者多个前面的匹配原
" \+                                       " 匹配1或者多个前面的匹配原
" \=                                       " 匹配0或者1个前面的匹配原
" \{2,5}                                   " 匹配2至5个前面的匹配原
" \|                                       " 隔开两种可替换的匹配
" \(\)                                     " 组合模式为当匹配原
" ;{search-command}                        " 接着执行 {search-command} 查找命令
" m{a-zA-Z}                                " 用标记 {a-zA-Z} 记录当前位置
" `{a-z}                                   " 至当前文件中的标记 {a-z}
" `{A-Z}                                   " 至任何文件中的标记 {A-Z}
" `{0-9}                                   " 至 Vim 上次退出的位置
" ``                                       " 至上次跳转之前的位置
" `"                                       " 至上次编辑此文件的位置
" `[                                       " 至上次被操作或放置的文本的开始
" `]                                       " 至上次被操作或放置的文本的结尾
" `<                                       " 至 (前次) 可视区域的开始
" `>                                       " 至 (前次) 可视区域的结尾
" `.                                       " 至当前文件最后被改动的位置
" '{a-zA-Z0-9[]'"<>.}                      " 同 `，但同时移动至该行的第一个非空白字符
" :marks                                   " 列出活动的标记
" N  ctrl+O                                " 跳转到跳转表中第 N 个较早的位置
" N  ctrl+I                                " 跳转到跳转表中第 N 个较晚的位置
" :ju[mps]                                 " 列出跳转表
" i ctrl+E                                 " 插入光标下方的字符
" i ctrl+Y                                 " 插入光标上方的字符
" i ctrl+A                                 " 插入上次插入的文本
" i ctrl+@                                 " 插入上次插入的文本并结束插入模式
" i ctrl+R {0-9a-z%#:.-="}                 " 插入寄存器的内容
" i ctrl+N                                 " 将下一个匹配的标识符插入光标前
" i ctrl+P                                 " 将上一个匹配的标识符插入光标前
" i ctrl+H                                 " 删除光标前的一个字符 = <BS>
" i <Del>                                  " 删除光标下的一个字符
" i ctrl+W                                 " 删除光标前的一个单词
" i ctrl+U                                 " 删除当前行的所有字符
" i ctrl+T                                 " 在当前行首插入一个移位宽度的缩进
" i ctrl+D                                 " 在当前行首删除一个移位宽度的缩进
" i 0 ctrl+D                               " 删除当前行的所有缩进
" i ^ ctrl+D                               " 删除当前行的所有缩进,恢复下一行的缩进
" :dig                                     " 显示当前二合字母列表
" i ctrl+k {char1} {char2}                 " 键入二合字母
" N D                                      " 删除至行尾
" N J                                      " 连接N-1行
" N gJ                                     " 同J,但不插入空格
" N ~                                      " 翻转N个字符的大小写并前进光标
" N ctrk+A                                 " 将光标之上或之后的数值增加 N
" N ctrl+X                                 " 将光标之上或之后的数值减少 N
" v o                                      " 交换高亮区域(可视)的开始处的光标位置
" N  aw                                    " 选择 一个单词
" N  iw                                    " 选择 内含单词
" N  aW                                    " 选择 一个字串
" N  iW                                    " 选择 内含字串
" N  as                                    " 选择 一个句子
" N  is                                    " 选择 内含句子
" N  ap                                    " 选择 一个段落
" N  ip                                    " 选择 内含段落
" N  ab                                    " 选择 一个块 (从 [( 至 ]))
" N  ib                                    " 选择 内含块 (从 [( 到 ]))
" N  aB                                    " 选择 一个大块 (从 [{ 到 ]})
" N  iB                                    " 选择 内含大块 (从 [{ 到 ]})
" N  a>                                    " 选择 一个 <> 块
" N  i>                                    " 选择 内含 <> 块
" N  at                                    " 选择 一个标签块 (从 <aaa> 到 </aaa>)
" N  it                                    " 选择 内含标签块 (从 <aaa> 到 </aaa>)
" N  a'                                    " 选择 一个单引号字符串
" N  i'                                    " 选择 内含单引号字符串
" N  a"                                    " 选择 一个双引号字符串
" N  i"                                    " 选择 内含双引号字符串
" N  a`                                    " 选择 一个反引号字符串
" N  i`                                    " 选择 内含反引号字符串
" N .                                      " 重复最近一次改动
" q{a-z}                                   " 记录键入的字符,存入寄存器{a-z}
" q{A-Z}                                   " 记录键入的字符,添加进寄存器{a-z}
" q                                        " 终止记录
" N @{a-z}                                 " 执行寄存器{a-z}的内容N次
" N @@                                     " 重复上次的@{a-z}的操作N次
" N gs                                     " 睡N秒
" sl[eep][sec]                             " 在[sec]秒任何事都不做
" :%!xxd                                   " 转换成十六进制
" :%!xxd -r                                " 转回来
" ga                                       " 以十进制,十六进制,八进制显示当前光标下的字符的ASCII值
" g8                                       " 对 utf-8 编码: 显示光标所在字符的十六进制字节序列
" g CTRL-G                                 " 显示当前光标的列、行、以及字符位置
" :ve[rsion]                               " 显示版本信息
" vim启动参数
"     -v                                   " vi模式
"     -d                                   " diff模式
"     -b                                   " 二进制模式
"     -l                                   " lisp模式
"     -A                                   " 阿拉伯模式
"     -F                                   " 波斯模式
"     -H                                   " 希伯来模式
" /\Cxxx                                   " 大小写敏感 /\cxxx 搜索xxx不敏感
" vsp                                      " 垂直分割窗口
" sp                                       " 竖向分割窗口
" ctrl w +                                 " 扩大分割窗口
" ctrl w -                                 " 缩小分割窗口
" res no                                   " 让分割的窗口只显示多少行
" }}}
"===================================================================================================

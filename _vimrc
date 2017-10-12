"===================================================
"开启pathogen插件
"----------------------------------
call pathogen#infect()

set nocompatible 
filetype plugin  on 

"=====================================================
"vim默认配置
"-----------------------------------------------------
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"=========================================================
"显示行号，并使用了desert配色方案，而且打开了语法高亮功能
"--------------------------------------------------------
set nu!
syntax enable
set background=dark

"if has('gui_running')
"    set background=light
"else
"    set background=dark
"endif
"set t_Co=256
colorscheme solarized
syntax on
"设置状态栏主题风格
"let g:Powerline_colorscheme='solarized256'
"
"以下为设置透明度和最大化
if has('gui_running') && has('gui_win32') && has('libcall')
    let g:MyVimLib = 'gvimfullscreen.dll'
    function! ToggleFullScreen()
        call libcall(g:MyVimLib, 'ToggleFullScreen', 1)
    endfunction

    let g:VimAlpha = 245
    function! SetAlpha(alpha)
        let g:VimAlpha = g:VimAlpha + a:alpha
        if g:VimAlpha < 180
            let g:VimAlpha = 180
        endif
        if g:VimAlpha > 255
            let g:VimAlpha = 255
        endif
        call libcall(g:MyVimLib, 'SetAlpha', g:VimAlpha)
    endfunction

    let g:VimTopMost = 0
    function! SwitchVimTopMostMode()
        if g:VimTopMost == 0
            let g:VimTopMost = 1
        else
            let g:VimTopMost = 0
        endif
        call libcall(g:MyVimLib, 'EnableTopMost', g:VimTopMost)
    endfunction
    "映射 Alt+Enter 切换全屏vim
    noremap <a-enter> :call ToggleFullScreen()<cr>
    "切换Vim是否在最前面显示
    "nmap <s-r> :call SwitchVimTopMostMode()<cr>
    "增加Vim窗体的不透明度
    nmap <s-t> :call SetAlpha(10)<cr>
    "增加Vim窗体的透明度
    nmap <s-y> :call SetAlpha(-10)<cr>
    " 默认设置透明
    "autocmd GUIEnter * call libcallnr(g:MyVimLib, 'SetAlpha', g:VimAlpha)
endif

" ============================================================
"  < 判断是终端还是 Gvim >
" ------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif


" ============================================================
"  < 判断操作系统是否是 Windows 还是 Linux >
" ------------------------------------------------------------
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

"==============================================================
" 显示/隐藏菜单栏、工具栏、滚动条，可用 Ctrl + F11 切换
"--------------------------------------------------------------
if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    map <silent> <c-F12> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif

"============================================================
" 设置Gvim的对齐线样式
"-----------------------------------------------------------
if g:isGUI
    let g:indentLine_char = "┊"
    let g:indentLine_first_char = "┊"
endif

" 设置终端对齐线颜色，如果不喜欢可以将其注释掉采用默认颜色
let g:indentLine_color_term = 239

" 设置 GUI 对齐线颜色，如果不喜欢可以将其注释掉采用默认颜色
" let g:indentLine_color_gui = '#A4E57E'

" ============================================================
"  < nerdcommenter 插件配置 >
" ------------------------------------------------------------

" 我主要用于C/C++代码注释(其它的也行)
" 以下为插件默认快捷键，其中的说明是以C/C++为例的，其它语言类似
" <Leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行)，再输入则取消注释
" <Leader>cm 以一个 /* */ 注释选中行(选中区域所在行)，再输入则称重复注释
" <Leader>cc 以每行一个 /* */ 注释选中行或区域，再输入则称重复注释
" <Leader>cu 取消选中区域(行)的注释，选中区域(行)内至少有一个 /* */
" <Leader>ca 在/*...*/与//这两种注释方式中切换（其它语言可能不一样了）
" <Leader>cA 行尾注释
let NERDSpaceDelims = 1          "在左注释符之后，右注释符之前留有空格

"=========================================================
"解决中文显示乱码问题
"--------------------------------------------------------
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1

if has("win32")
    set fileencoding=chinese
else
    set fileencoding=utf-8
endif

"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"解决consle输出乱码
language messages zh_CN.utf-8
let &termencoding=&encoding
let g:fencview_autodetect = 1
" 编译器信息转码
    function! QfMakeConv()
       let qflist = getqflist()
       for i in qflist
          let i.text = iconv(i.text, "cp936", "utf-8")
       endfor
       call setqflist(qflist)
    endfunction
    au QuickfixCmdPost make call QfMakeConv()

"===================================================
"启用ctag插件实现程序中跳转
"---------------------------------------------------
"按下"ctrl+]"，光标会自动跳转到定义处
"按下"ctrl+T"会跳回到原来的位置
"当你的源文件有更新时，只能重新运行ctags -R命令，来更新tags文件。
set tags+=tags;

"set tags+=~/vimfiles/tags/libc.tags
"set tags+=~/vimfiles/tags/susv2.tags
"set tags+=~/vimfiles/tags/glib.tags
"set tags+=~/vimfiles/tags/cpp.tags

set autochdir


"let Tlist_Sort_Type = "name"		" 按照名称排序
let Tlist_Sort_Type="order"
let Tlist_Compact_Format=1

"let Tlist_Use_Right_Window = 1		" 在右侧显示窗口
					" 压缩方式 Remove extra information and blank lines from the taglist window.
let Tlist_Compact_Format = 1		" 如果只有一个buffer，kill窗口也kill掉buffer
let Tlist_Exit_OnlyWindow = 1
"let Tlist_Auto_Open = 1		"auto open Tlist when vim open
let Tlist_Enable_Fold_Column = 0	" 不要显示折叠树
let Tlist_WinWidth = 22			" taglist 窗口宽度
let Tlist_Inc_Winwidth = 1		" no inc the width of the windows
"let Tlist_File_Fold_Auto_Close = 1	" Close tag folds for inactive buffers.
let Tlist_Process_File_Always = 1	"To process files even when the taglist window is not open.
let Tlist_Show_One_File = 1		"display the tags defined only in the current buffer
let Tlist_Show_Menu=1
let Tlist_Ctags_Cmd = 'ctags'
let Tlist_Use_SingleClick=1 		"设置单击tag就跳到tag定义的位置，就在文件中加入这句话：

"==============================================
"启用tasklist支持任务列表
"---------------------------------------------

map tl :TaskList<CR>

"=============================================
"vim-autoformat插件
"---------------------------------------------
"现在可以c/c++/c#/java源代码格式化
"需要其他源代码格式化的，还要根据其帮助文件下载所需软件
noremap <F3> :Autoformat<CR>

"=============================================
" BufExplorer
"----------------------------------------------
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=1       " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 30  " Split width
let g:bufExplorerUseCurrentWindow=0  " Open in new window.
let g:bufExplorerSplitBelow=1
autocmd BufWinEnter \[Buf\ List\] setl nonumber 
nmap bv :BufExplorerVerticalSplit<CR>
nmap bh :BufExplorerHorizontalSplit<CR>

"============================================================
"Tagbar
"------------------------------------------------------------
 nmap tb :TagbarToggle<CR>

"============================================================
"启用winmanager插件进行窗口管理
"------------------------------------------------------------

"normal状态下输入命令"wm",Tlist，TagList窗口即出现在左侧
"其中左上是netrw窗口（浏览文件），左下是TagList窗口，
"再次输入"wm"时这两个窗口会关闭
"nmap wm :if IsWinManagerVisible() <BAR> WMToggle<CR> <BAR> else <BAR> WMToggle<CR>:q<CR> endif <CR>
"let g:winManagerWindowLayout='TagList|NERDTree'
let g:bufExplorerMaxHeight=20
let g:miniBufExplorerMoreThanOne=0
let g:winManagerWindowLayout='NERDTree|TagList|BufExplorer'
nmap wm :WMToggle<cr>
"let g:winManagerWidth=25
let g:AutoOpenWinManager = 0 "这里要配合修改winmanager.vim文件，见下方说明"
let g:defaultExplorer = 0

"===================================================
"启用minibufexpl.vim多文件编辑
"---------------------------------------------------

"当用gvim打开两个或两个以上的文件时，会自动弹出MiniBufExplorer窗
"ctrl+Tab，切换到前一个buffer，并在当前窗口打开文件；
"ctrl+shift+Tab，切换到后一个buffer，并在当前窗口打开文件；
"ctrl+箭头键，可以切换到上下左右窗口中；
"ctrl+h,j,k,l，切换到上下左右的窗口中。

let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplMapWindowNavVim = 1

"==============================================
"启用supertab插件
"----------------------------------------------

"当你准备按"Ctrl+X Ctrl+O"的时候直接按<Tab>就好了
""自动补全代码的功能, 按下"Ctrl+X Ctrl+O"就搞定了
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-O>"

"============================================
" 设置NerdTree
"--------------------------------------------
let g:NERDTree_title="[NERDTree]"  
function! NERDTree_Start()      	
	exec 'NERDTree'  
endfunction    
function! NERDTree_IsValid()  
    return 1  
endfunction  

"map <F3> :NERDTreeToggle<CR>
"=============================================
"修改界面语言
"---------------------------------------------
"英文为en_US,中文为
set langmenu=zh_CN
let $LANG='zh_CN'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

if has("win32")
 au GUIEnter * simalt ~x
endif  			    				"vim启动最大化

set ignorecase		     			"忽略大小写，对于搜索和自动补全很方便

set ambiwidth=double                "防止特殊符号无法正常显示
set go=			    				"去掉图形界面和菜单
set cmdheight=2     	    		"设置命令行的高度为2，默认为1
set cursorline       	    		"突出显示当前行
set shortmess=atI    	    		"去掉欢迎界面
set gcr=a:block-blinkon0    		"禁止光标闪烁
set writebackup             		"保存文件前建立备份，保存成功后删除该备份
set nobackup                		"设置无备份文件
" set noswapfile            		"设置无临时文件
set vb t_vb=              			"关闭提示音
set laststatus=2            		"启用状态栏信息
set tabstop=4						"设置tab分隔符为4个空格
"set ai    							"设置自动缩进
"set cindent 						"设置使用C/C++自动缩进方式
"===============================================
"vmb,vba文件的安装
"-----------------------------------------------
"" 1）用Vim打开.vba安装包文件。

"" 2）在Vim命令行下运行命令“UseVimball+vim的安装目录”。
""此命令将安装包解压缩到~/.vim目录。
""VImball安装方式的便利之处在于你可以在任何目录打开.vba包安装，
""而不用切换到安装目的地目录。而且不用运行helptags命令安装帮助文档。

"================================================
"设置代码折叠
"-----------------------------------------------
"set foldmethod=indent

set foldenable 														" 开始折叠
set foldmethod=syntax 												" 设置语法折叠
"set foldmethod=indent 												" 根据缩进折叠

set foldcolumn=0 													" 设置折叠区域的宽度
setlocal foldlevel=1 												" 设置折叠层数为1
set foldclose=all 													" 设置为自动关闭折叠 
set foldlevelstart=99												"打开文件是默认不折叠代码
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>	"用空格键来开关折叠
" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"================================================
"cscope
"------------------------------------------------
"cscope主要用来协助浏览C/C++语言，他的功能要强大于ctags，不仅支持变量/函数的定义查询，
"还记录了函数的调用处查询等功能，所以也有说法称cscope的诞生就是为了取代ctags。无论这个说法是否有据可依，
"对使用方来说，当然是希望功能越强大方便越好啦，
function Do_CsTag()
    if(executable("cscope") && has("cscope") )
	"silent! execute "cs kill"
        if(has('win32'))
            silent! execute "!dir /b *.c,*.cpp,*.h,*.java,*.cs > cscope.files"
        else
            silent! execute "!find . -name "*.h" -o -name "*.c" -o -name "*.cpp" -o -name "*.m" -o -name "*.mm" -o -name "*.java" -o -name "*.py" > cscope.files"
        endif
        silent! execute "!cscope -Rbkq && ctags -R"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
    endif
endf

"cscope和ctags的兼容问题
if has("cscope")
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    set csto=0
    set cst
    set csverb
endif

nmap cs :call Do_CsTag()<cr>

"======================================================================
"SourceExplorer plugin
"---------------------------------------------------------------------
"{
" // The switch of the Source Explorer 
nmap se :SrcExplToggle<CR>
" // Set the height of Source Explorer window 
let g:SrcExpl_winHeight = 6 
" // Set 100 ms for refreshing the Source Explorer 
let g:SrcExpl_refreshTime = 100 
" // Set "Enter" key to jump into the exact definition context 
let g:SrcExpl_jumpKey = "<ENTER>" 
" // Set "Space" key for back from the definition context 
let g:SrcExpl_gobackKey = "<SPACE>" 
" // In order to avoid conflicts, the Source Explorer should know what plugins
" // except itself are using buffers. And you need add their buffer names into
" // below listaccording to the command ":buffers!"
let g:SrcExpl_pluginList = [ 
        \ "__Tag_List__", 
        \ "_NERD_tree_" 
    \ ] 

" // Enable/Disable the local definition searching, and note that this is not 
" // guaranteed to work, the Source Explorer doesn't check the syntax for now. 
" // It only searches for a match with the keyword according to command 'gd' 
let g:SrcExpl_searchLocalDef = 1 
" // Do not let the Source Explorer update the tags file when opening 
let g:SrcExpl_isUpdateTags = 0 
" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to 
" // create/update the tags file 
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ." 
" // Set "<F12>" key for updating the tags file artificially 
let g:SrcExpl_updateTagsKey = "<c-F9>" 
" // Set "<F10>" key for displaying the previous definition in the jump list 
let g:SrcExpl_prevDefKey = "<c-F10>" 

" // Set "<F11>" key for displaying the next definition in the jump list 
let g:SrcExpl_nextDefKey = "<c-F11>" 
"}
"=================================================
"设置wmgraphviz.vim
let g:WMGraphviz_output="png"
"nmap <LocalLeader>lv :!start cmd \c mspaint %<.png
"====================================================================
"conque用于在vim中运行终端
"-------------------------------------------------------------------
:nmap cqb :ConqueTermSplit bash<CR><CR> export LANG=C.UTF-8<CR>
:nmap cqc :ConqueTermSplit cmd<CR>
:nmap cqvb :ConqueTermVSplit bash<CR><CR> export LANG=C.UTF-8<CR>
:nmap cqvc :ConqueTermVSplit cmd<CR>
			" 一共四个命令： 
			 " ConqueTerm         <command>   :  在当前的窗口打开<command> 
			 " ConqueTermSplit    <command>   :  横向分割一个窗口之后打开<command> 
 			 " ConqueTermVSplit   <command>   :  竖向分割一个窗口之后打开<command> 
			 " ConqueTermTab      <command>   :  先建一个tab页之后打开<command>

"==========================================================
"设置gundo插件
"----------------------------------------------------------

map <leader>g :GundoToggle<CR><CR>
let g:gundo_width = 30
let g:gundo_preview_height = 20
let g:gundo_right = 1

"========================================================================

"powerline

 set guifont=PowerlineSymbols\ for\ Powerline
 set guifont=DejaVu_Sans_Mono:h12	"设置字体和大小
 set nocompatible
 set t_Co=256
 let g:Powerline_symbols = 'fancy'

 "==========================================================
 "编辑状态下映射方向键
 "----------------------------------------------------------
 
inoremap <A-h> <Left>
inoremap <A-j> <Down>
inoremap <A-k> <Up>
inoremap <A-l> <Right>

"============================================================
"编程相关设置
"------------------------------------------------------------
:imap   <C-S>   <ESC>:call Write()<CR>
:map    <C-S>   :call Write()<CR>
function! Write()
  if(&filetype == "markdown" || &filetype =="plantuml" || &filetype =="dot" || &filetype == "jsp" || &filetype == "javascript")
    :set fenc=utf-8
    :w!
  else 
    :w!
  endif 
endfunction

set formatoptions=tcqro				        "使得注释换行时自动加上前导的空格和星号
set completeopt=longest,menu			    "关掉智能补全时的预览窗口
set scrolloff=3    						    " 光标移动到buffer的顶部和底部时保持3行距离
set nowrap                                 	"不自动折行"
set shiftwidth=2 							"蛇者自动缩进2个空格
set expandtab 								"在输入tab后vim用恰当的空格填充"
"set fillchars=vert:\ ,stl:\ ,stlnc:\		"在被分割的窗口间显示空白，便于阅读

"-----------------------------------------------------------

"Quickfix窗口使用
"设置编译拍错快捷键
inoremap <A-=> <ESC>:cn<CR>     "下一条错误 
inoremap <A--> <ESC>:cp<CR>     "上一条错误
nmap <A-=> :cn<CR>
nmap <A--> :cp<CR>
"-------------------------------------------------------------
"在vim窗口中输出程序运行结果


nmap <M-s>  :Sys<space>
command! -nargs=1 Sys call System(<f-args>)
function! System(cmd)
    if has('win32') || has('win64')
      "if(&filetype == "c" || &filetype == "cpp" || &filetype == "h")
      if &fileencoding == "UTF-8"
        echo system(a:cmd)
      else
        echo iconv(system(a:cmd), "cp936", &enc)
      endif
    endif
endfunction


"-----------------------------------------------------------

func! CompileGcc()							"快速编译运行
     "[注意]本函数中被注释掉的代码都是在cmd中编译时需要的
    "除了加 : 的都是Quickfix的代码
    "let compilecmd="!gcc "
    "let compileflag="-o %< "
    :set makeprg=gcc\ -std=c11\ -ggdb3\ -Wall\ -o\ %<\ %
    if search("mpi\.h") != 0
        "let compilecmd = "!mpicc "
        :set makeprg=mpicc\ -ggdb3\ -Wall\ -o\ %<\ %  "在quickfix窗口中编译
      endif
    if search("glut\.h") != 0
        "let compileflag .= " -lglut -lGLU -lGL "
        :set makeprg=gcc\ %\ -lglut\ -lGLU\ -lGL
    endif
    if search("cv\.h") != 0
        "let compileflag .= " -lcv -lhighgui -lcvaux "
        :set makeprg=gcc\ %\ -lcv\ -lhighgui\ -lcvaux
    endif
    if search("omp\.h") != 0
       " let compileflag .= " -fopenmp "
        :set makeprg=gcc\ %\ -fopenmp
    endif
    if search("math\.h") != 0
        "let compileflag .= " -lm "
        :set makeprg=gcc\ %\ -lm
    endif
    "exec compilecmd." % ".compileflag
    :make
    :cwindow
endfunc

func! CompileGpp()
    "[注意]本函数中被注释掉的代码都是在cmd中编译时需要的
    "除了加 : 的都是Quickfix的代码
    "let compilecmd="!g++ "
    "let compileflag="-o %< "
    :set makeprg=g++\ -std=c++11\ -ggdb3\ -Wall\ -o\ %<\ %
    if search("mpi\.h") != 0
       " let compilecmd = "!mpic++ "  
        :set makeprg=mpic++\ -ggdb3\ -Wall\ -o\ %<\ %  "在quickfix窗口中编译
      endif
    if search("glut\.h") != 0
        "let compileflag .= " -lglut -lGLU -lGL "
        :set makeprg=g++\ %\ -std=c++11\ -lglut\ -lGLU\ -lGL
    endif
    if search("cv\.h") != 0
        "let compileflag .= " -lcv -lhighgui -lcvaux "
        :set makeprg=g++\ %\ -std=c++11\ -lcv\ -lhighgui\ -lcvaux
      endif
    if search("omp\.h") != 0
        "let compileflag .= " -fopenmp "
        :set makeprg=g++\ %\ -std=c++11\ -fopenmp
    endif
    if search("math\.h") != 0
        "let compileflag .= " -lm "
        :set makeprg=g++\ %\ -std=c++11\ -lm
    endif
    "Quickfix窗口输出编译错误信息 
    :make
    if bufname("In\ file\ included\ from\ *.cpp") != ""
        :bw In\ file\ included\ from\ *.cpp
    endif
    :cwindow
    "exec compilecmd." % ".compileflag
    :syntax on
  endfunc

func! CompileVC()
  :set makeprg=vc.bat\ %
  if(&filetype == "c" || &filetype == "cpp" || &filetype == "h")  
     silent! exec"set fenc=gbk"
     silent! exec "w!"
     :make
        if bufname("In\ file\ included\ from") != ""
           :bw In\ file\ included\ from\ *.cpp
        endif
     :cwindow
  endif
endfunc

func! RunPython()
        silent! execute "!start cmd /c python % & pause"
        "exec "!python %"
        :Sys "cmd /c cRun.bat python"
endfunc

func! CompileJava()
    silent! execute '!IF NOT EXIST "..\bin" MD "..\bin"'
    "Quickfix窗口输出编译错误信息 
    ":set makeprg=javac\ %\ -d\ ../bin
    :set makeprg=javacx.bat\ %
    :make
    :cwindow
     " exec "!javac % -d ../bin"        "//cmd窗口中输出编译错误信息，需要退出cmd窗口后才能操作Gvim，很不方便
endfunc

func! CompileCode()
        if(&filetype == "c" || &filetype == "cpp" || &filetype == "h")  
          if(&fileformat == "dos")  
            silent! exec"set fenc=chinese"
          endif
        elseif(&filetype == "tex")
            :%s/(neocomplete_start_auto_complete)//g
            silent! exec"set fenc=utf-8"
        elseif(&filetype == "java")
            silent! exec"set fenc=chinese"
        elseif &filetype  == "plantuml"
          silent! exec "set fenc=UTF-8"
          ":set makeprg=plantuml.bat\ %
          :make
          ":cwindow
          "silent! execute "!start cmd /c plantuml.bat %"
        elseif &filetype == "dot"
          silent! exec "set fenc=UTF-8"
          :set makeprg=dot\ -Tpng\ %\ -o\ %<.png
          :make
          :cwindow
        endif


        silent! exec "w!"
        if &filetype == "cpp"
                exec "call CompileGpp()"
        elseif &filetype == "c"
                exec "call CompileGcc()"
              elseif &filetype == "python"
                exec "call RunPython()"
        elseif &filetype == "java"
                exec "call CompileJava()"
        elseif &filetype == "tex"
                exec "call Tex_RunLaTeX()"
                silent! exec "!del *.aux && del *.log"
        endif
         
endfunc

func! HasInputCompileCode()
        if(&filetype == "c" || &filetype == "cpp" || &filetype == "h" ) 
         if(&fileformat == "dos")   
            silent! exec"set fenc=chinese"
         endif
        elseif(&filetype == "java")
            silent! exec"set fenc=chinese"
        elseif(&filetype == "tex")
            :%s/(neocomplete_start_auto_complete)//g
            silent! exec"set fenc=utf-8"
        endif

        silent! exec "w!"
        if &filetype == "cpp"
                exec "call CompileGpp()"
        elseif &filetype == "c"
                exec "call CompileGcc()"
        elseif &filetype == "python"
                exec "call RunPython()"
        elseif &filetype == "java"
                exec "call CompileJava()"
        elseif &filetype == "tex"
                exec "call Tex_RunLaTeX()"
                silent! exec "!del *.aux && del *.log"
        endif
endfunc

func! RunResult()
        
        "使用System函数使运行结果文本直接在vim的命令行中显示，图形则跳出，但不出现黑框
        
        if search("mpi\.h") != 0
            silent! execute "!echo %< > run.txt "
           " exec "!mpirun -np 4 ./%<"
           :Sys "cmd /c cRun.bat 'mpirun -np 4'"
           silent! execute "!cmd /c del /F /S /Q run.txt"
        elseif &filetype == "cpp"
            "silent! execute "!start cmd /c %< & pause"
            silent! execute "!echo %< > run.txt "
            :Sys "cmd /c cRun.bat"
            silent! execute "!cmd /c del /F /S /Q run.txt"
        elseif &filetype == "c"
            "silent! execute "!start cmd /c %< & pause"
            silent! execute "!echo %< > run.txt "
            :Sys "cmd /c cRun.bat"
            silent! execute "!cmd /c del /F /S /Q run.txt"
        elseif &filetype == "python"
            silent! execute "!echo % > run.txt "
            exec "call RunPython"
            silent! execute "!cmd /c del /F /S /Q run.txt"
        elseif &filetype == "java"
	        "silent! execute "!start cmd /c JavaRun.bat %< & pause" 
            ""exec "!JavaRun.bat %<"
            silent! execute "!echo %< > run.txt"
            ":Sys "cmd /c jRun.bat"
            :Sys "cmd /c javaRunx.bat"
            silent! execute "!cmd /c del /F /S /Q run.txt"
        elseif &filetype == "plantuml"
            :make
            ":cwindow
            "silent! execute "!mspaint %<.png"
        elseif &filetype == "dot"
            silent! execute "!%<.png"
            "silent! execute "!mspaint %<.png"
        elseif &filetype == 'matlab'
            silent! exec "w!"
            exec "call Startmatlab()"
            exec "call Pathmatlab()"
        elseif &filetype == "tex"
            silent! exec "call Tex_ViewLaTeX()"
        endif
        
endfunc

func! HasInputRunResult()
        
        if &filetype == "tex" 
            silent! exec "call Tex_ViewLaTeX()"
        else
            :call HasInputCompileCode() 
        endif
        if search("mpi\.h") != 0
            exec "!mpirun -np 4 ./%<"
        elseif &filetype == "cpp"
            silent! execute "!start cmd /c %< & pause"
        elseif &filetype == "c"
            silent! execute "!start cmd /c %< & pause"
        elseif &filetype == "python"
            exec "call RunPython"
        elseif &filetype == "java"
	        silent! execute "!start cmd /c JavaRunx.bat %< & pause" 
            ":Sys "cmd /c jRun.bat"
        elseif &filetype == 'matlab'
            silent! exec "w!"
            silent! execute '!start cmd /c wmic process where name="matlab.exe" call terminate && matlab -nojvm -nodesktop -nodisplay -r %<'
           
        endif

endfunc

map <F8> :call CompileVC()<CR><CR><CR>
imap <F8> <ESC>:call CompileVC()<CR><CR><CR>
map <F9> :call CompileCode()<CR><CR><CR>
imap <F9> <ESC>:call CompileCode()<CR><CR><CR>
vmap <F9> <ESC>:call CompileCode()<CR><CR><CR>
map <F10> :call RunResult()<CR>
imap <F10> :call RunResult()<CR>
map <F11> :call HasInputRunResult()<CR><CR>
imap <F11> <ESC>:call HasInputRunResult()<CR><CR>


"=============================================================
"For Ycm
"-------------------------------------------------------------

autocmd Filetype java,html,htm,matlab,css let g:ycm_auto_trigger=0      "java时关闭YouCompleteMe

let g:ycm_global_ycm_extra_conf = 'E:/gvim/vimfiles/bundle/YouCompleteMe/python/.ycm_extra_conf.py'
autocmd filetype c let g:ycm_global_ycm_extra_conf = 'E:/gvim/vimfiles/bundle/YouCompleteMe/python/.ycm_extra_conf_c.py'
" 设置转到定义处的快捷键为ALT + G，这个功能非常赞 
" 自动补全配置
set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif	"离开插入模式后自动关闭预览窗口
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	"回车即选中当前项
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

"youcompleteme  默认tab  s-tab 和自动补全冲突
"let g:ycm_key_list_select_completion=['<c-n>']
let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion=['<c-p>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示
"默认ctrl+space进行C语言自动补全

let g:ycm_collect_identifiers_from_tags_files=1	" 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=3	" 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=1	" 0为禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1	" 语法关键字补全
let g:syntastic_always_populate_loc_list = 1 "方便使用syntastic进行语法检查
let g:ycm_seed_identifiers_with_syntax=1 " 开启语法关键字补全
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> " 跳转到定义处


"=============================================================================
"配置Javacomplete
""---------------------------------------------------------------------------
"
filetype plugin indent on           "打开文件配置 
"setlocal omnifunc=javacomplete#Complete 
autocmd Filetype java setlocal omnifunc=javacomplete#Complete
autocmd Filetype java nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
autocmd Filetype java imap <F4> <Plug>(JavaComplete-Imports-AddSmart)
autocmd Filetype java nmap <F5> <Plug>(JavaComplete-Imports-Add)
autocmd Filetype java imap <F5> <Plug>(JavaComplete-Imports-Add)
autocmd Filetype java nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
autocmd Filetype java imap <F6> <Plug>(JavaComplete-Imports-AddMissing)
autocmd Filetype java nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
autocmd Filetype java imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)

"let g:JavaComplete_UsePython3 = 1

setlocal completefunc=javacomplete#CompleteParamsInfo
if has("autocmd")
  autocmd Filetype java,jsp,javascript setlocal omnifunc=javacomplete#Complete
  autocmd FileType java,jsp,javascript set completefunc=javacomplete#CompleteParamsInfo
  autocmd FileType java,jsp,javascript inoremap <expr><CR> pumvisible()?"\<C-Y>":"<CR>"
  autocmd FileType java,jsp,javascript inoremap <buffer> . .<C-X><C-O><C-P>
endif

"autocmd FileType java inoremap <buffer> ..<C-X><C-O><C-P>
"autocmd FileType java inoremap <expr><CR> pumvisible()?"\<C-Y>":"<CR>"

"====================================================================
"配置neocompelet
"--------------------------------------------------------------------
"
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 1
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"=============================================================
"fastfold配置
"-------------------------------------------------------------
"
 nmap zuz <Plug>(FastFoldUpdate)
 let g:fastfold_savehook = 1
 let g:fastfold_fold_command_suffixes = ['x','X','a','A','o','O','c','C','r','R','m','M','i','n','N']
 let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']

"=============================================================
"Emmet.vim 配置
"-------------------------------------------------------------
 let g:user_emmet_settings = {
  \  'indentation' : '  ',
  \  'perl' : {
  \    'aliases' : {
  \      'req' : 'require '
  \    },
  \    'snippets' : {
  \      'use' : "use strict\nuse warnings\n\n",
  \      'warn' : "warn \"|\";",
  \    }
  \  }
  \}

  let g:user_emmet_expandabbr_key = '<c-e>'

  let g:use_emmet_complete_tag = 1
"==============================================================
"述说插入系统时间，适用于Windows
"------------------------------
:nnoremap <F4> "=strftime("%c (%A)")<CR>P
:inoremap <F4> <C-R>=strftime("%c (%A)")<CR>
"==============================================================
" 使grep总是生成文件名
set grepprg=grep\ -nH\ $*
" vim默认把空的tex文件设为plaintex而不是tex，导致latex-suite不被加载
let g:tex_flavor='latex'
set iskeyword+=:
autocmd BufEnter *.tex set sw=2
let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf' 
let g:Tex_CompileRule_pdf = 'xelatex -interaction=nonstopmode $*'
let g:Tex_ViewRule_pdf = 'evince' 

"******************************/etc/vimrc******************************"
"
" OS: CentOS-6.5-x86_64;
"
" Vim: V7.4.629
"
" Version: 0.1
"
" Date: 2016-6-11
"
"**********************************************************************"


"***** Language *****"
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif


"***** General *****"
set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

set nu
set autoindent
set cindent


"***** autocmd *****"
" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif


"***** cscope *****"
if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

set cscopequickfix=s-,c-,d-,i-,t-,e-


"***** syntax highlighting *****"
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif


"***** xterm *****"
if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"


"***** taglist *****"
let Tlist_Ctags_Cmd='/usr/bin/ctags'
let Tlist_Show_One_File=1
let Tlist_OnlyWindow=1
let Tlist_Use_Right_Window=1
let Tlist_Sort_Type='name'
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_Menu=1
let Tlist_Max_Submenu_Items=10
let Tlist_Max_Tag_length=20
let Tlist_Use_SingleClick=0
let Tlist_Auto_Open=0
let Tlist_Close_On_Select=0
let Tlist_File_Fold_Auto_Close=1
let Tlist_GainFocus_On_ToggleOpen=0
let Tlist_Process_File_Always=1
let Tlist_WinHeight=20
let Tlist_WinWidth=18
let Tlist_Use_Horiz_Window=0

set tags=tags;
set autochdir


"***** winmanager *****"
"let g:winManagerWindowLayout='FileExplorer|BufExplorer|TagList'
let g:winManagerWindowLayout='TagList'
let g:persistentBehaviour=0             "只剩一个窗口时, 退出vim.
let g:winManagerWidth=30
let g:defaultExplorer=0
let g:AutoOpenWinManager=1
"nmap <silent> <leader>fir :FirstExplorerWindow<cr>
"nmap <silent> <leader>bot :BottomExplorerWindow<cr>
nmap wm :WMToggle<cr>


"***** cvim *****"
filetype plugin on


"***** quickfix *****"
nmap co :copen<cr>
nmap cc :cclose<cr>


"***** NERDTree *****"
nmap nt :NERDTree<cr>
nmap ntc :NERDTreeClose<cr>
let g:NERDTreeWinSize=20
let g:NERDChristmasTree=1


"***** foldenable *****"
"set foldenable              " 开始折叠
"set foldmethod=syntax       " 设置语法折叠
"set foldcolumn=0            " 设置折叠区域的宽度
"setlocal foldlevel=1        " 设置折叠层数为
"set foldclose=1             " 设置为自动关闭折叠                            
"nmap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>   "用空格键来开关折叠


"***** tags *****"
" configure tags - add additional tags here or comment out not-used ones
set tags+=/home/tags
set tags+=/usr/include/tags
" set tags+=/home/tags/gl
" set tags+=/home/tags/sdl
" set tags+=/home/tags/qt4
" " build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>


"***** OmniCppComplete *****"
set nocp
filetype plugin on

let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview


"***** Calendar *****"
let g:calendar_diary = "/home" " 设置日记的存储路径


"***** Moving cursor in INSERT mode *****"
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>


"***** gcc *****"
nmap <F5> :make<cr>
nmap <F6> :make clean<cr>
nmap <F7> :make run<cr>


"***** airline *****"
set t_Co=256
"set laststatus=2

let g:airline_theme="luna" 

"这个是安装字体后 必须设置此项" 
let g:airline_powerline_fonts = 1   
"
" "打开tabline功能,方便查看Buffer和切换，这个功能比较不错"
"  "我还省去了minibufexpl插件，因为我习惯在1个Tab下用多个buffer"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
"
"     "设置切换Buffer快捷键"
"      nnoremap <C-N> :bn<CR>
"       nnoremap <C-P> :bp<CR>
"
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
let g:airline#extensions#tabline#enabled = 1


"***** stardict *****"
set keywordprg=sdcv

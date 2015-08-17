set nocompatible
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
endfunction
color desert
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim7.1��windows�µı������á�By Huadong.Liu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
if has("win32")
set fileencoding=chinese
else
set fileencoding=utf-8
endif
"����˵�����
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"���consle�������
language messages zh_CN.utf-8
set guifont=courier_new:h10
set nu
"Ĭ������£�ֻ���û��½��˱�ǩҳ�Ż��ڴ����Ϸ���ʾ��ǩ����������ѡ��set showtabline=1�����ġ�
"�������ϣ��������ʾ��ǩ������ô������set showtabline=2���������á�
"�������ϣ����ȫ����ʾ��ǩ������ô����ʹ��set showtabline=0�����á�
set showtabline=2
set nobackup
filetype plugin indent on 
set autoindent
let g:winManagerWindowLayout='FileExplorer|TagList' 
nmap wm :WMToggle<cr>


:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap < <><ESC>i
:inoremap > <c-r>=ClosePair('>')<CR>



" �ÿո���������۵�
set foldenable
set foldmethod=manual
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
 
" ���ص��˵��͹�������
"set guioptions-=m
"set guioptions-=T
"map <silent> <F2> :if &guioptions =~# 'T' <Bar>
"        \set guioptions-=T <Bar>
"        \set guioptions-=m <bar>
"    \else <Bar>
"        \set guioptions+=T <Bar>
"        \set guioptions+=m <Bar>
"    \endif<CR>
 
" ��ǩҳ����
if has("gui_running")
    set showtabline=2
    map! tn tabnew
    nmap <C-c> :tabclose<CR>
endif
 
" ��ǩҳֻ��ʾ�ļ���
function ShortTabLabel ()
    let bufnrlist = tabpagebuflist (v:lnum)
    let label = bufname (bufnrlist[tabpagewinnr (v:lnum) -1])
    let filename = fnamemodify (label, ':t')
    return filename
endfunction
 
set guitablabel=%{ShortTabLabel()}
 
" ʹ�ظ����backspace����������indent, eol, start��
set backspace=eol,start,indent

" ������ʾƥ�������
set showmatch

" ������ʱ������Ĵʾ�����ַ�����������firefox��������
set incsearch

"������֮������ؼ���
set hlsearch

"����= + - * ǰ���Զ��ո�
"����,�����Զ���ӿո�
au FileType python inoremap <buffer>= <c-r>=EqualSign('=')<CR>
au FileType python inoremap <buffer>+ <c-r>=EqualSign('+')<CR>
au FileType python inoremap <buffer>- <c-r>=EqualSign('-')<CR>
au FileType python inoremap <buffer>* <c-r>=EqualSign('*')<CR>
au FileType python inoremap <buffer>/ <c-r>=EqualSign('/')<CR>
au FileType python inoremap <buffer>> <c-r>=EqualSign('>')<CR>
au FileType python inoremap <buffer>< <c-r>=EqualSign('<')<CR>
au FileType python inoremap <buffer>: <c-r>=Swap()<CR>
au FileType python inoremap <buffer>, ,<space>
 
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        �ű��ڲ��õ����Զ��庯��                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"����������ϣ��Ƿ�ֹvimrc�ļ���������ʱ����
"ʵ�ֹ��λ���Զ�����:) -->  ):
function! Swap()
    if getline('.')[col('.') - 1] =~ ")"
        return "\<ESC>la:"
    else
        return ":"
    endif
endf
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"ʵ��+-*/ǰ���Զ���ӿո񣬶��ź����Զ���ӿո�����python
"֧��+= -+ *= /+��ʽ
 
function! EqualSign(char)
    if a:char  =~ '='  && getline('.') =~ ".*("
        return a:char
    endif
    let ex1 = getline('.')[col('.') - 3]
    let ex2 = getline('.')[col('.') - 2]
 
    if ex1 =~ "[-=+><>\/\*]"
        if ex2 !~ "\s"
            return "\<ESC>i".a:char."\<SPACE>"
        else
            return "\<ESC>xa".a:char."\<SPACE>"
        endif
    else
        if ex2 !~ "\s"
            return "\<SPACE>".a:char."\<SPACE>\<ESC>a"
        else
            return a:char."\<SPACE>\<ESC>a"
        endif
    endif
endf
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"ʵ�����ŵ��Զ���Ժ��ֹ�ظ����룩������python
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

"��װctags ��ס��CTRL�����������Ӧ�ĺ�������CTRL+]�������Զ���ת�������Ķ��岿�֣���CTRL+T���򷵻أ�
set tags=tags; 
set autochdir



set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

Bundle 'scrooloose/nerdtree'
Bundle 'snipMate'
Bundle 'winmanager'
Bundle 'emmet'


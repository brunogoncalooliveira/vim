" still working
"
" identar xml
"    set equalprg=xmllint\ --format\ -
" depois, em normal mode, é só carregar em = para identar


" ATALHOS
"
"set list -> ver newlines e tabs
"set nolist --> desligar a opção acima
"
"


"
" Windows
"
" no ficheiro c:\Program Files (x86)\Vim\_vimrc acrescentar:
" 	source C:/Users/USER/Desktop/vim/_vimrc
" 	let $HOME="c:\Users\USER\Desktop\vim"
"
"
" comentar o vimrc_example.vim
" source $VIMRUNTIME/vimrc_example.vim
" 


" alguns comandos
"
" :set runtimepath? --> permite ver o runtime path

"if has('win32') || has ('win64')
"	let $VIMHOME = $VIM."/vimfiles"
"else
"	let $VIMHOME = $HOME."/.vim"
"endif


filetype plugin indent on
syntax on
set encoding=utf-8
set wrap " Always wrap long lines:
set hlsearch

" press return to temporarily get out of the highlighted search.
:nnoremap <CR> :nohlsearch<CR><CR>

if has('gui_running')
    " para escolher a fonte:
    "    1º set guifont=*
    "       com isto, é aberta uma dialog box para se escolher a fonte
    "    2º para ver qual a fonte escolhida, executar o seguinte comando:
    "       set guifont=?
    set guifont:Consolas:h9:cANSI:qDRAFT

    " toolbar and scrollbars
    set guioptions-=T       " remove toolbar
    set guioptions-=m       " remove menubar
    "set guioptions+=L       " left scroll bar
    "set guioptions+=r       " right scroll bar
    "set guioptions+=b      " bottom scroll bar
    "set guioptions-=h      " only calculate bottom scroll size of current line
    "set shortmess=atI           
       " Don't show the intro message at start and
       "   truncate msgs (avoid press ENTER msgs).
endif

set backspace=2 " make backspace work like most other programs
set tabstop=4
set shiftwidth=4 expandtab

vnoremap > >gv
vnoremap < <gv

"behave mswin


" instalar xmllint no windows
" https://stackoverflow.com/questions/19546854/installing-xmllint

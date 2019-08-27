"
" Windows
"
" no ficheiro c:\Program Files (x86)\Vim\_vimrc acrescentar:
" 	source C:/Users/USER/Desktop/vim/_vimrc
" 	let $HOME="c:\Users\USER\Desktop\vim"
"
" comentar o vimrc_example.vim
" source $VIMRUNTIME/vimrc_example.vim
" 



if has('win32') || has ('win64')
    " this is because in my workplace, HOME is defined as H:
    let $HOME="c:/Users/xxx/Desktop/vim"
    let $PLUG_FOLDER="$HOME/plugged"
else
    if has('macunix')
        " mapeia o Control-C em Visual Mode para copiar para o clipboard
        vmap <C-c> "*y<CR>
        " mapeia o Control-C em Normal Mode para fazer paste a partir do clipboard
    	  nmap <C-v> "*p<CR>
    else
        let $PLUG_FOLDER = $HOME."/.vim/plugged"
    endif
endif




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



" alguns comandos
"
" :set runtimepath? --> permite ver o runtime path




"
"
" PLUGINS
"
"

filetype off

call plug#begin($PLUG_FOLDER)
   Plug 'itchyny/lightline.vim'
   Plug 'ctrlpvim/ctrlp.vim'
call plug#end()
"   Plug 'dense-analysis/ale'
"   Plug 'maximbaz/lightline-ale'

" comandos para ativar plugins


filetype plugin indent on
syntax on



" Enable folding with the spacebar
nnoremap <space> za



"
"
" CONFIGURAÇÕES PARA PYTHON

"
"



"au BufNewFile,BufRead *.py
"    \ set tabstop=4 |
"    \ set softtabstop=4 |
"    \ set shiftwidth=4 |
"    \ set textwidth=79 |
"    \ set expandtab |
"    \ set autoindent |
"    \ set fileformat=unix |
"    \ set foldmethod=indent | " Enable folding
"    \ set foldlevel=4  | " Enable folding
"    \ set foldlevelstart=4  " Enable folding

" Enable folding --> mas apenas a partir do 4° nível
set foldmethod=indent " Enable folding
set foldlevel=4  " Enable folding
set foldlevelstart=4  " Enable folding --> #set# global

set encoding=utf-8

set laststatus=2 " para ativar o plugin lightline

autocmd Syntax xml,html,xhtml,json setlocal foldlevel=99


"
"
" PLUGINS
"
"


"set foldmethod=indent
"set foldlevel=4
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

" Bind F5 to save file if modified and execute python script in a buffer.
nnoremap <silent> <F5> :call SaveAndExecutePython()<CR>
vnoremap <silent> <F5> :<C-u>call SaveAndExecutePython()<CR>

function! SaveAndExecutePython()
    " SOURCE [reusable window]: https://github.com/fatih/vim-go/blob/master/autoload/go/ui.vim

    " save and reload current file
    silent execute "update | edit"

    " get file path of current file
    let s:current_buffer_file_path = expand("%")

    let s:output_buffer_name = "Python"
    let s:output_buffer_filetype = "output"

    " reuse existing buffer window if it exists otherwise create a new one
    if !exists("s:buf_nr") || !bufexists(s:buf_nr)
        silent execute 'botright new ' . s:output_buffer_name
        let s:buf_nr = bufnr('%')
    elseif bufwinnr(s:buf_nr) == -1
        silent execute 'botright new'
        silent execute s:buf_nr . 'buffer'
    elseif bufwinnr(s:buf_nr) != bufwinnr('%')
        silent execute bufwinnr(s:buf_nr) . 'wincmd w'
    endif

    silent execute "setlocal filetype=" . s:output_buffer_filetype
    setlocal bufhidden=delete
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nobuflisted
    setlocal winfixheight
    setlocal cursorline " make it easy to distinguish
    setlocal nonumber
    setlocal norelativenumber
    setlocal showbreak=""

    " clear the buffer
    setlocal noreadonly
    setlocal modifiable
    %delete _

    " add the console output
    silent execute ".!python " . shellescape(s:current_buffer_file_path, 1)

    " resize window to content length
    " Note: This is annoying because if you print a lot of lines then your code buffer is forced to a height of one line every time you run this function.
    "       However without this line the buffer starts off as a default size and if you resize the buffer then it keeps that custom size after repeated runs of this function.
    "       But if you close the output buffer then it returns to using the default size when its recreated
    "execute 'resize' . line('$')

    " make the buffer non modifiable
    setlocal readonly
    setlocal nomodifiable
endfunction

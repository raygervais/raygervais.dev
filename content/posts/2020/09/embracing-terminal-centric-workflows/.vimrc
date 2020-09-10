"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"   RayGervais
" VimRC Version:
"   2.0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible    "be iMproved, required
filetype off        "required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'fatih/vim-go'
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

call vundle#end()            " required
filetype plugin indent on    " required

"UI"
set number          "Show line numbers
set showcmd         "Show command bar
set wildmenu        "Visual autocomplete for command menu
set history=500     "How many lines of history to remember
set autoread        "Autoread changes to an open file
set laststatus=2    "Always show statusbar
set cursorline      "Highlight cursor line

"Color"
set termguicolors   "Enable 24bit True Color
colorscheme dracula "Dracula Color Theme
set t_Co=256        "Enable
set background=dark "Dark Background
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE

"General"
set showmatch       "Highlight matching braces
set autoread        "Autoreload changed files
set ffs=unix,dos,mac "Unix is standard filetype
set encoding=utf8   "Set standard text encoding
set nofoldenable    "Disable section folding

"Editor"
set autoindent      "Auto-indent new lines
set shiftwidth=4    "Number of auto indent width
set expandtab       "Enable Tab-key converts to 4 spaces
set smarttab        "Smart Tab
set softtabstop=4   "Soft Tab Amount
set tabstop=4       "Standard Tab Amount
set clipboard=unnamedplus "Integrate with standard clipboard
syntax enable       "Enable Syntax Highlighting
set nowrap          "Disable line breaks

"Searching"
set incsearch       "Search as characters are entered
set hlsearch        "Highlight search matches
set ignorecase      "Ignore cases when searching
set smartcase       "Attempt smart case search where possible

"Custom Functions"
"Highlights text that goes beyond the 90th column
"highlight OverLength ctermbg=darkgrey ctermfg=white guibg=#FFD9D9
"match OverLength /\%>90v.\+/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

let t:is_transparent = 0
function! Toggle_transparent()
    if t:is_transparent == 0
        hi Normal guibg=NONE ctermbg=NONE
        let t:is_transparent = 1
    else
        set background=dark
        let t:is_tranparent = 0
    endif
endfunction
nnoremap <C-t> : call Toggle_transparent()<CR>

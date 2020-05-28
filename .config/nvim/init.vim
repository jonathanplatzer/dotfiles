" vim.plug Autoinstall
" -------------------------------------

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim.plug Plugins
" -------------------------------------
call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bronson/vim-trailing-whitespace'
Plug 'dylanaraps/wal.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'ziglang/zig.vim'

call plug#end()

" This is needed to overwrite the complete option
runtime plugin/sensible.vim

" Personal configuration
" -------------------------------------
set list listchars=tab:»·,trail:·,extends:>,precedes:<,nbsp:·
set expandtab
set shiftwidth=4
set softtabstop=4
colorscheme wal
set t_Co=16
set complete+=i
set number relativenumber

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = -32
let g:netrw_list_hide = ".*\.swp$,.git"

" vim-easytags configuration
let g:easytags_file = '~/.vim/tags'
set tags=./tags;
let g:easytags_dynamic_files = 1
let g:easytags_async = 0
let g:easytags_always_enabled = 1

" vim-airline configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16color'

" shortcuts
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>

" FixWhitespace on writing a file
autocmd BufWritePre,FileWritePre * FixWhitespace

" Braindump Mode
" -------------------------------------
function! BraindumpToggle()
    if (@% == "BRAINDUMP.md")
        Goyo
        call BraindumpUpdateTimestamp()
        write
        buffer #
        bdelete BRAINDUMP.md
    elseif(filereadable("BRAINDUMP.md"))
        edit BRAINDUMP.md
        Goyo
    endif
endfunction

function! BraindumpUpdateTimestamp()
    1,3s/\(updated\) \(\d\{4}-\d\{2}-\d\{2}\ \d\{2}:\d\{2}\)/\=submatch(1).' '.strftime("%Y-%m-%d %H:%M")/g
endfunction

" TODO(jonathanplatzer): rework this... better braindump code...
function! s:GoyoLeave()
    " Quit Vim if this is the only remaining buffer
    Limelight!
    if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        qa
    endif
endfunction

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave call s:GoyoLeave()
autocmd! VimEnter *.md Goyo

" TODO Insertion
" -------------------------------------

function! InsertTodo()
    return "TODO(" . $USER . "):"
endfunction

iab TODO <C-R>=InsertTodo()<CR>

" Header Template Insertion
" -------------------------------------

let g:author_name = "Jonathan Platzer"
let g:author_mail = "jonathan@throughothereyes.net"

function! InsertHeader()
    exe "normal! O// Copyright (C) THROUGHOTHEREYES"
    exe "normal! oAuthor: " . g:author_name . "<" . g:author_mail . ">"
    exe "normal! o\<BS>\<BS>\<BS>\<ESC>j"
endfunction

" Force saving files that require root permission
cnoremap w!! w !sudo tee > /dev/null %

" Sessions (wrapper for vim-obsession)
" -------------------------------------
let g:session_file = '.vimsession'

function! s:SessionInit()
    silent execute 'Obsession' g:session_file
    echo "Initialized Session"
endfunction

function! s:SessionDestroy()
    silent execute 'Obsession!'
    echo "Destroyed Session"
endfunction

function! s:SessionLoad()
    if @% == '' && filereadable(g:session_file)
        silent execute 'source ' g:session_file
    endif
endfunction

command! Session call s:SessionInit()
command! SessionInit call s:SessionInit()
command! SessionDestroy call s:SessionDestroy()

autocmd VimEnter * nested call s:SessionLoad()

" Autocommands
" -------------------------------------
autocmd BufNewFile *.{c,cpp,h,hpp} call InsertHeader()
autocmd FileType {c,cpp,h,hpp} setlocal commentstring=\/\/\ %s

" Toggle between relative and non relative numbers
"augroup numbertoggle
"  autocmd!
"  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
"  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
"augroup END

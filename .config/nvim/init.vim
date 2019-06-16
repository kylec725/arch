"-----------------------------"
"Plugin Management - plug.vim "
"-----------------------------"
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
" Airline to replace status line
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomtom/tcomment_vim'
Plug 'Yggdroot/indentLine'
Plug 'gregsexton/MatchTag'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-repeat'
Plug 'octol/vim-cpp-enhanced-highlight'
" Intellisense engine
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
Plug 'w0rp/ale'
" Show git status in gutter
Plug 'airblade/vim-gitgutter'
" Git wrapper
Plug 'tpope/vim-fugitive'
" Language pack support
Plug 'sheerun/vim-polyglot'
" Documentation integration
Plug 'KabbAmine/zeavim.vim'
" Position indicator
Plug 'gcavallanti/vim-noscrollbar'
" Nord colorscheme (only used for airline)
Plug 'arcticicestudio/nord-vim'
Plug 'vimlab/split-term.vim'
" fzf
Plug 'junegunn/fzf.vim'
" Highlight current line
Plug 'miyakogi/conoline.vim'
call plug#end()

"----------------------"
" General Vim Settings "
"----------------------"

" Change clipboard register for vim
set clipboard=unnamedplus

" Important settings
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
set hidden

" enable .h files to be set to filetype c
augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

" Mode switch delay
set timeoutlen=1000 ttimeoutlen=0

" Update time for gitgutter
set updatetime=200

" Preview search and replace
set inccommand=split

" Line numbers
set number relativenumber
" Current line number color
hi LineNr ctermfg=12
hi CursorLineNR ctermfg=11

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Enable spell check functionality
set spelllang=en

" case insensitive search unless upper case is used
set ignorecase
set smartcase

" Set folding to indent
set foldmethod=indent
set foldlevelstart=99

" Visual Wrapping
set nowrap

" Clear SignColumn/Gutter color
hi clear SignColumn

" Cursor blinking
set guicursor=a:blinkon100

" Change window pane separator to a single line
set fillchars+=vert:│
hi VertSplit cterm=NONE ctermfg=12

" remove latex concealment
let g:tex_conceal = ""

" highlight characters after column 80
highlight OverLength ctermbg=darkgray ctermfg=black
" match OverLength /\%81v.\+/

" indent settings
set tabstop=8
set expandtab
set softtabstop=-1
" auto indent command
command Indent :normal! MmQgg=G'Qzz
" filetype indent settings
autocmd FileType html setlocal shiftwidth=2 | match OverLength /\%81v.\+/
autocmd FileType css setlocal shiftwidth=2 | match OverLength /\%81v.\+/
autocmd FileType json setlocal shiftwidth=2
autocmd FileType ruby setlocal shiftwidth=2 | match OverLength /\%81v.\+/
autocmd FileType tex setlocal shiftwidth=2 spell
autocmd FileType markdown setlocal spell
autocmd FileType ocaml setlocal shiftwidth=2 | match OverLength /\%81v.\+/
autocmd FileType c setlocal shiftwidth=4 cindent | match OverLength /\%81v.\+/
autocmd FileType cpp setlocal shiftwidth=4 cindent cinoptions=g0+N-sw | match OverLength /\%81v.\+/
autocmd FileType java setlocal shiftwidth=4 | match OverLength /\%81v.\+/
autocmd FileType javascript setlocal shiftwidth=4 | match OverLength /\%81v.\+/
autocmd FileType python setlocal shiftwidth=4 | match OverLength /\%81v.\+/
autocmd FileType vim setlocal shiftwidth=4
autocmd FileType lua setlocal shiftwidth=4
autocmd FileType fish setlocal shiftwidth=4 | ALEDisable
autocmd FileType sh setlocal shiftwidth=8 | match OverLength /\%81v.\+/

"-------------------------"
" General Vim Keybindings "
"-------------------------"

" map the leader key
let mapleader=','
" remove leader timeout
set notimeout
set ttimeout
nnoremap <leader>, jk

" map :w and :q
noremap <leader>w :w<CR>
noremap <leader>q :q<CR>

" map buffer navigation keys
noremap <silent> - :bprevious<CR>
noremap <silent> = :bnext<CR>
" nnoremap <silent> <C-h> :bprevious<CR>
" nnoremap <silent> <C-l> :bnext<CR>
nnoremap <silent> <leader>bd :bd<CR>

" map shift + hjkl
noremap <S-h> ^
noremap <S-j> L
noremap <S-k> H
noremap <S-L> g_

" window navigation keys
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" window resize keys
" noremap <silent> <C-y> :vertical resize -5<CR>
" noremap <silent> <C-u> :resize -5<CR>
" noremap <silent> <C-i> :resize +5<CR>
" noremap <silent> <C-o> :vertical resize +5<CR>

" make Y behave like C and D
nnoremap Y y$

" <S-e> to backwards end of word
noremap <S-e> ge

" replace the word under cursor
nnoremap <leader>sr :%s/\<<c-r><c-w>\>//gI<left><left><left>
nnoremap <leader>sc :%s/\<<c-r><c-w>\>//gIc<left><left><left><left>
" replace visual selection
vnoremap <leader>sr y:%s/\<<c-r>"\>//gI<left><left><left>
vnoremap <leader>sc y:%s/\<<c-r>"\>//gIc<left><left><left><left>

" auto indent command
nnoremap <leader>i :Indent<CR>

" remove search highlighting
nnoremap <Esc> :noh<CR>

"-----------------"
" Plugin Settings "
"-----------------"

" Airline !!!!!

let g:airline_extensions = ["tabline", "branch", "ale", "hunks"]
set laststatus=2
" let g:airline_theme='term'
let g:airline_theme='nord'
let g:airline_detect_paste=1
set encoding=utf-8
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
" let g:airline#parts#ffenc#skip_expected_string='utf-8[dos]'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#ale#enabled = 1

" replace powerline fonts if they are missing
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" powerline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.dirty='⚡'
let g:airline_symbols.dirty=''
let g:airline_symbols.notexists = ''
"let g:airline_symbols.space = "\ua0"

" Nerdtree !!!!!

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:nerd_win = 0
" nerdtree mappings
nnoremap <silent> <leader>n :NERDTreeToggle<CR>

" Goyo !!!!!

function! s:goyo_enter()
    set wrap
endfunction

function! s:goyo_leave()
    set nowrap
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
nnoremap <C-g> :Goyo<CR>

" Coc !!!!!

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" assign tab and s-tab to cycle through suggestions
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Ale !!!!!

nnoremap <LEADER>ad :ALEDetail<CR>
nmap <leader>aj <Plug>(ale_next_wrap)
nmap <leader>ak <Plug>(ale_previous_wrap)
" lint after exiting insert mode
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

" Noscrollbar !!!!!

function! Noscrollbar(...)
    let w:airline_section_z = '%{noscrollbar#statusline()} :%2c'
endfunction
call airline#add_statusline_func('Noscrollbar')

" Git Commands - Fugitive and Gitgutter !!!!!

nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gc :Gcommit<CR>
nmap <leader>gj <Plug>GitGutterNextHunk
nmap <leader>gk <Plug>GitGutterPrevHunk
" nnoremap <leader>gu :Gpush<CR>
" nnoremap <leader>gd :Gpull<CR>

" Terminal settings !!!!!

" split-term.vim settings
set splitright
let g:term_size = 50

" terminal function (from /u/andreyorst) was modified
let g:term_buf = -1
let g:term_win = 0
function! TermToggle()
    if win_gotoid(g:term_win) || g:term_buf == bufnr("")
        hide
    else
        if bufexists(g:term_buf) == 1
            exec g:term_size "vsplit | buffer " g:term_buf
            let g:term_win = win_getid()
        else
            exec g:term_size "VTerm"
            set nonumber
            set norelativenumber
            set signcolumn=no
            " hides the buffer from airline's tabline
            setlocal nobuflisted
            let g:term_buf = bufnr("")
            let g:term_win = win_getid()
        endif
        startinsert!
    endif
endfunction
" switch to terminal window function (from me)
function! TermSwitch()
    if g:term_win == win_getid()
        exec "vertical resize " g:term_size
        exec "wincmd h"
    else
        if win_gotoid(g:term_win)
            exec "vertical resize " g:term_size
            startinsert!
        endif
    endif
endfunction

" exit terminal window if it is the last window
autocmd bufenter * if winnr("$") == 1 && win_getid() == g:term_win | q | endif

" terminal bindings
nnoremap <silent> <leader>tt :call TermToggle()<CR>
tnoremap <silent> <leader>tt <C-\><C-n>:call TermToggle()<CR>
nnoremap <silent> <leader>ts :call TermSwitch()<CR>
tnoremap <silent> <leader>ts <C-\><C-n>:call TermSwitch()<CR>

" fzf settings !!!!!
let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" hide the statusline when searching
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

nnoremap <leader>f :Files<CR>
nnoremap <leader>l :Lines<CR>

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" indent line
let g:indentLine_char = '▏'

" Conoline settings !!!!!
let g:conoline_auto_enable = 0
let g:conoline_color_normal_dark = 'ctermbg=black'
let g:conoline_color_normal_nr_dark = 'ctermfg=11'
let g:conoline_color_insert_dark = 'ctermbg=black'
let g:conoline_color_insert_nr_dark = 'ctermfg=11'
nnoremap <silent> <leader>c :ConoLineToggle<CR>

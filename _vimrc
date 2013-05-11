"_vimrc
"Frank Fralick
"
"==============================================================================
"General settings and other cargo-culted configurations
"==============================================================================

set nocompatible

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

"Load plugins with pathogen.
execute pathogen#infect()
execute pathogen#helptags()
"Setup custom font."
"Download site for Anonymous Pro:
"http://www.marksimonson.com/fonts/view/anonymous-pro
set guifont=Anonymous\ Pro\ for\ Powerline:h12
set encoding=utf-8

"Powerline setup.
set laststatus=2
let g:Powerline_symbols = 'fancy'

"Turn of all the gui elements.  This is Vim.
set go-=m go-=T go-=r

"Syntax is good.
syntax on
"Set autoindent
set smartindent
"Filetype plugins.
filetype plugin on
filetype plugin indent on

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

"Turn the fucking error bells off.
set noerrorbells
set visualbell
set t_vb=

"Keep the cursor at least five lines off the bottom or top.
set so=5

"Remap jj to escape in insert mode.  You will never type jj anyways.
inoremap jj <Esc>

"Copy and paste enhancement.  This helps with moving large blocks of code.
set pastetoggle=<F2>
set clipboard=unnamed

"Set mouse to be able to behave as expected.
set mouse=a
"Set backspace to work right.
set bs=2

"Map ctrl-n to clear searches.
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

" Quicksave command
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>

"Movement commands.
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

"Toggle tabs.
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

"Indentation enhancement in visual mode.
"vnoremap < <gv " better indentation
"vnoremap > >gv " better indentation

"Show trailing whitespace.
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

"Set the color scheme to something fruity.
set t_Co=256
color mango
au WinLeave * set nocursorline
au WinEnter * set cursorline
set cursorline

highlight CursorLine ctermbg=233
"set colorcolumn=80
highlight ColorColumn ctermbg=233

" Showing line numbers and length
set number
set tw=79
set nowrap
set fo-=t

" Useful settings
set history=700
set undolevels=700

" Tabs are stupid.
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

"Don't bother getting search case right.
set hlsearch
set incsearch
set ignorecase
set smartcase

"Disable backup files.
set nobackup
set nowritebackup
set noswapfile

"Set up taglist.
autocmd VimEnter * TlistToggle

"Set up NERDTree
autocmd VimEnter * NERDTree

" Set up code completion
"if v:version >= 700
"  set omnifunc=syntaxcomplete#Complete " override built-in C omnicomplete with C++ OmniCppComplete plugin
"  let OmniCpp_GlobalScopeSearch   = 1
"  let OmniCpp_DisplayMode         = 1
"  let OmniCpp_ShowScopeInAbbr     = 0 "do not show namespace in pop-up
"  let OmniCpp_ShowPrototypeInAbbr = 1 "show prototype in pop-up
"  let OmniCpp_ShowAccess          = 1 "show access in pop-up
"  let OmniCpp_SelectFirstItem     = 1 "select first item in pop-up
"  set completeopt=menuone,menu,longest
"endif

if version >= 700
  let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
endif

function! UpdateTags()
  execute ":!ctags -R --languages=C++ --c++-kinds=+p --fields=+iaS --extra=+q ./"
  echohl StatusLine | echo "C/C++ tag updated" | echohl None
endfunction
nnoremap <F4> :call UpdateTags()

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
function! OmniPopup(action)
if pumvisible()
if a:action == 'j'
return "\<C-N>"
elseif a:action == 'k'
return "\<C-P>"
endif
endif
return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

"==============================================================================
"Javascript
"==============================================================================

"Setup javascript completion
autocmd Filetype javascript
            \set omnifunc=nodejscomplete#CompleteJS

"Setup for nodejs-complete
let g:node_usejscomplete = 1

"==============================================================================
"Python
"==============================================================================

" Set up Pydiction
let g:pydiction_location = 'C:\Vim\vimfiles\Pydiction\complete-dict'
let g:pydiction_menu_height = 20

" Settings for python-mode
" cd ~/.vim/bundle
" git clone https://github.com/klen/python-mode
map <Leader>g :call RopeGotoDefinition()<CR>
let ropevim_enable_shortcuts = 1
let g:pymode_rope_goto_def_newwin = "vnew"
let g:pymode_rope_extended_complete = 1
let g:pymode_breakpoint = 0
let g:pymode_syntax = 1
let g:pymode_syntax_builtin_objs = 0
let g:pymode_syntax_builtin_funcs = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" Python folding
set nofoldenable

" Python syntax highlighing enhancement
" TODO fix this
"autocmd FileType python set complete+=k~/.vim/syntax/python3.0.vim isk+=.,(

"==============================================================================
"C#
"==============================================================================

autocmd BufNewFile,BufRead *.cs set ft=csharp

"OmniSharp setup.
let g:OmniSharp_typeLookupInPreview = 1
nmap <F12> :call OmniSharp#GotoDefinition()<cr>
nmap fi :call OmniSharp#FindImplementations()<cr>
nmap fu :call OmniSharp#FindUsages()<cr>
nmap <leader>lt :call OmniSharp#TypeLookup()<cr>
nmap <space> :call OmniSharp#GetCodeActions()<cr>

"This has to be set for "Goto Definition" to work.
set hidden

"Extract method.  This needs work.
vmap <leader>em :call ExtractMethod()<CR>
function! ExtractMethod() range
  let name = inputdialog("Name of new method:")
  '<
  exe "normal! O\<BS>private " . name ."()\<CR>{\<Esc>"
  '>
  exe "normal! oreturn ;\<CR>}\<Esc>k"
  s/return/\/\/ return/ge
  normal! j%
  normal! kf(
  exe "normal! yyPi// = \<Esc>wdwA;\<Esc>"
  normal! ==
  normal! j0w
endfunction

"VB.NET syntax highlighting. gag.
autocmd BufNewFile,BufRead *.vb set ft=vbnet

"==============================================================================
"Registers and leaders
"==============================================================================

"Create new braces below the current line and enter insert mode.
map <@>t :o{}O
"Delete a word from when the cursor is at the beginning of a work and enter
"insert mode.
map <@>w :dei
"Create get/set methods below a property, insert mode in get.
map <@>p :o{}Oget{;}oset{;}kjkhireturn jhi= valuekli

"==============================================================================
"Text Files
"==============================================================================

"Autoformat .txt files to have a line break.
au BufEnter *.txt setl tx ts=4 sw=4 fo+=n2a 
:autocmd BufNewFile,BufRead *.txt set wrap

func! WordProcessorMode() 
  setlocal formatoptions=1 
  setlocal noexpandtab 
  map j gj 
  map k gk
  setlocal spell spelllang=en_us 
  "set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
  set dictionary=C:\Vim\vimfiles\dict\wordsEn
  set complete+=k
  set formatprg=par
  setlocal wrap 
  "call DoWordComplete()
  "setlocal omnifunc=WordComplete
  setlocal omnifunc=DoWordComplete
  call SuperTabSetDefaultCompletionType("<c-x><c-n>")"
  "setlocal completefunc=WordComplete
  "setlocal linebreak 
endfu 
com! WP call WordProcessorMode()


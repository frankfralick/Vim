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

"if version >= 700
"  let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
"endif

if version >= 700
    let g:SuperTabDefaultCompletionType = "context"
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

"Set up pymode refactoring through rope

" Load rope plugin
let g:pymode_rope = 1

" Use rope's completion.
let g:pymode_rope_vim_completion = 0
" Map keys for autocompletion
let g:pymode_rope_autocomplete_map = '<C-Space>'

" Auto create and open ropeproject
let g:pymode_rope_auto_project = 1

" Enable autoimport
let g:pymode_rope_enable_autoimport = 1

" Auto generate global cache
let g:pymode_rope_autoimport_generate = 1

let g:pymode_rope_autoimport_underlineds = 0

let g:pymode_rope_codeassist_maxfixes = 10

let g:pymode_rope_sorted_completions = 1

let g:pymode_rope_extended_complete = 1

let g:pymode_rope_autoimport_modules = ["os","shutil","datetime"]

let g:pymode_rope_confirm_saving = 1

let g:pymode_rope_global_prefix = "<C-x>p"

let g:pymode_rope_local_prefix = "<C-c>r"

let g:pymode_rope_vim_completion = 1

let g:pymode_rope_guess_project = 1

let g:pymode_rope_goto_def_newwin = ""

let g:pymode_rope_always_show_complete_menu = 1

" Additional python paths
let g:pymode_paths = ["C:\\Users\\frankfralick\\AppData\\Roaming\\McNeel\\Rhinoceros\\5.0\\Plug-ins\\IronPython (814d908a-e25c-493d-97e9-ee3861957f49)\\settings\\lib"]

" Load breakpoints plugin
let g:pymode_breakpoint = 1

" Key for set/unset breakpoint
let g:pymode_breakpoint_key = '<leader>b'

" Autoremove unused whitespaces
let g:pymode_utils_whitespaces = 1

" Enable pymode indentation
let g:pymode_indent = 1

" Set default pymode python options
let g:pymode_options = 1


" Enable pymode's custom syntax highlighting
let g:pymode_syntax = 1

" Enable all python highlightings
let g:pymode_syntax_all = 1

" Highlight "print" as function
let g:pymode_syntax_print_as_function = 0

" Highlight indentation errors
let g:pymode_syntax_indent_errors = g:pymode_syntax_all

" Highlight trailing spaces
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Highlight string formatting
let g:pymode_syntax_string_formatting = g:pymode_syntax_all

" Highlight str.format syntax
let g:pymode_syntax_string_format = g:pymode_syntax_all

" Highlight string.Template syntax
let g:pymode_syntax_string_templates = g:pymode_syntax_all

" Highlight doc-tests
let g:pymode_syntax_doctests = g:pymode_syntax_all

" Highlight builtin objects (__doc__, self, etc)
let g:pymode_syntax_builtin_objs = g:pymode_syntax_all

" Highlight builtin functions
let g:pymode_syntax_builtin_funcs = g:pymode_syntax_all

" Highlight exceptions
let g:pymode_syntax_highlight_exceptions = g:pymode_syntax_all

" Highlight equal operator
let g:pymode_syntax_highlight_equal_operator = g:pymode_syntax_all

" Highlight stars operator
let g:pymode_syntax_highlight_stars_operator = g:pymode_syntax_all

" Highlight `self`
let g:pymode_syntax_highlight_self = g:pymode_syntax_all

" For fast machines
let g:pymode_syntax_slow_sync = 0


" Set up Pydiction
"let g:pydiction_location = 'C:\Vim\vimfiles\Pydiction\complete-dict'
"let g:pydiction_menu_height = 20

" Settings for python-mode
" cd ~/.vim/bundle
" git clone https://github.com/klen/python-mode
"map <Leader>g :call RopeGotoDefinition()<CR>
"let ropevim_enable_shortcuts = 1
"let g:pymode_rope_goto_def_newwin = "vnew"
"let g:pymode_rope_extended_complete = 1
"let g:pymode_breakpoint = 0
"let g:pymode_syntax = 1
"let g:pymode_syntax_builtin_objs = 0
"let g:pymode_syntax_builtin_funcs = 0
"map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>


"function! LoadPythonPath()
py <<EOF
    # load PYTHONPATH into vim, this lets you hover over a module name
    # and type 'gf' (for goto file) and open that file in vim. Useful
    # and easier than rope for simple asks
#import os.path
#import sys
#import vim
#for p in sys.path:
#    if os.path.isdir(p):
#vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

"endfunction


" Python folding
set nofoldenable

" Python syntax highlighing enhancement
" TODO fix this
"autocmd FileType python set complete+=k~/.vim/syntax/python3.0.vim isk+=.,(

"==============================================================================
"C#
"==============================================================================

autocmd BufNewFile,BufRead *.cs set ft=csharp

"This is the default value, setting it isn't actually necessary
let g:OmniSharp_host = "http://localhost:2000"

"Set the type lookup function to use the preview window instead of the status line
let g:OmniSharp_typeLookupInPreview = 1

"Showmatch significantly slows down omnicomplete
"when the first match contains parentheses.
set noshowmatch
"Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

"Super tab settings
"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
"let g:SuperTabClosePreviewOnPopupClose = 1

"don't autoselect first item in omnicomplete, show if only one item (for preview)
set completeopt=longest,menuone,preview
"move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
set splitbelow

nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
" Builds can run asynchronously with vim-dispatch installed
"nnoremap <F5> :wa!<cr>:OmniSharpBuildAsync<cr>

"The following commands are contextual, based on the current cursor position.

nnoremap <F12> :OmniSharpGotoDefinition<cr>
"nnoremap gd :OmniSharpGotoDefinition<cr>
nnoremap <leader>fi :OmniSharpFindImplementations<cr>
nnoremap <leader>ft :OmniSharpFindType<cr>
nnoremap <leader>fs :OmniSharpFindSymbol<cr>
nnoremap <leader>fu :OmniSharpFindUsages<cr>
nnoremap <leader>fm :OmniSharpFindMembersInBuffer<cr>
nnoremap <leader>tt :OmniSharpTypeLookup<cr>
"I find contextual code actions so useful that I have it mapped to the spacebar
nnoremap <space> :OmniSharpGetCodeActions<cr>

" rename with dialog
nnoremap <leader>nm :OmniSharpRename<cr>
nnoremap <F2> :OmniSharpRename<cr>
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
nnoremap <leader>tp :OmniSharpAddToProject<cr>
" Automatically add new cs files to the nearest project on save
autocmd BufWritePost *.cs call OmniSharp#AddToProject()
" (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
nnoremap <leader>ss :OmniSharpStartServer<cr>
nnoremap <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
nnoremap <leader>th :OmniSharpHighlightTypes<cr>
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden


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


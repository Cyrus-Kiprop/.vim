scriptencoding utf-8
set encoding=utf-8
set termencoding=utf-8

" Use Vim settings, rather then Vi settings (much better!).
set nocompatible

execute pathogen#infect()

" Plugins
silent! runtime bundles.vim

" Remap escape to the ii button
imap ii <Esc>

" General
" ---------------------------------------------------------------------------

filetype plugin indent on
let mapleader = ","
let g:mapleader = ","
syntax enable
set autoread
set timeoutlen=500 ttimeoutlen=0 " Avoid delays

" do not create backup, swap file, use git for version management
set nobackup
set nowritebackup
set noswapfile

" This means that you can have unwritten changes to a file and open a new file
" using :e, without being forced to write or undo your changes first.
set hidden

set history=1000  "store lots of :cmdline history

" Add '-' as recognized word symbol. e.g dw delete all 'foo-bar' instead just 'foo'
set iskeyword+=-

" Show matching brackets
set showmatch
set matchpairs+=<:> " Make < and > to match

" Use 256 colors in vim
set t_Co=256

" Spell
autocmd FileType gitcommit setlocal spell
autocmd FileType markdown setlocal spell
set complete+=kspell

" Copy to osx clipboard
vnoremap <C-c> "*y<CR><Paste>
vnoremap <C-c> "*y<CR>
vnoremap y "*y<CR>
nnoremap Y "*Y<CR>

" ---------------------------------------------------------------------------
" UI
" ---------------------------------------------------------------------------

set title        " make your xterm inherit the title from Vim
set autoindent
set smartindent
set showmode     " show current mode down the bottom
set showcmd      " show incomplete cmds down the bottom
set hidden       " hides buffers instead of closing them
set wildmenu
set wildmode=list:longest
set wildcharm=<TAB> " Autocmpletion hotkey
set visualbell t_vb=
set cursorline   " highlight current line
set ttyfast
set backspace=indent,eol,start  "allow backspacing over everything in insert mode
set laststatus=2 " display the status line always
set nonumber
set relativenumber number " show relative numbers
set splitbelow
set splitright
set completeopt=longest,menuone
set list
set listchars=eol:⏎,trail:•

" some stuff to get the mouse going in term
" set mouse=" a
" if !has('nvim')
  " set ttymouse=xterm2
" endif

" ---------------------------------------------------------------------------
" Text Formatting
" ---------------------------------------------------------------------------

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab!

set wrap
set textwidth=79
set formatoptions=n

" ---------------------------------------------------------------------------
" Mappings
" ---------------------------------------------------------------------------

" Remap ; to :
nnoremap ; :

" Open new tab
nmap <silent><leader>t :tabnew<CR>

" Replace
nmap <leader>s :%s//<left>
vmap <leader>s :s//<left>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>rv :so $MYVIMRC<CR>

nmap :E :e
nmap :W :w

if exists(':tnoremap')
  tnoremap <C-H> <C-\><C-N><C-W>h
  tnoremap <C-J> <C-\><C-N><C-W>j
  tnoremap <C-K> <C-\><C-N><C-W>k
  tnoremap <C-L> <C-\><C-N><C-W>l

  " Use Esc to enter normal mode in term
  tnoremap <Esc> <C-\><C-n>
endif

" Workaround for Neovim
if has('nvim')
  nmap <BS> <C-W>h
endif

" bind K to grep word under cursor
nnoremap <silent> K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
vnoremap <silent> K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Show the path of the current file
nnoremap <Leader>e :echo expand('%')<CR>

" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " \a to Silver Searcher
  nnoremap <leader>a :Ag!<space>
endif

if has('nvim')
  let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:8,hl:1,fg+:14,bg+:8,hl+:9 --color=info:7,prompt:7,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse --margin=1,2'


  let g:fzf_layout = { 'window': 'call FloatingFZF()' }

  function! FloatingFZF()
    let buf = nvim_create_buf(v:false, v:true)
    call setbufvar(buf, '&signcolumn', 'no')

    let height = float2nr(20)
    let width = float2nr(80)
    let horizontal = float2nr((&columns - width) / 2)
    let vertical = 1

    let opts = {
          \ 'relative': 'editor',
          \ 'row': vertical,
          \ 'col': horizontal,
          \ 'width': width,
          \ 'height': height,
          \ 'style': 'minimal'
          \ }

    call nvim_open_win(buf, v:true, opts)
  endfunction
endif


" Map t to FZF
nnoremap <silent> t :FZF<cr>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" key mapping for shifting panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Key mapping for textmate-like indentation
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv

" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" Toggle hlsearch with <leader>hs
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" turn search highlight off
nnoremap <leader><space> :noh<cr>

" Format json strings
com! FormatJSON %!python -m json.tool


" ---------------------------------------------------------------------------
" Tabularize
" ---------------------------------------------------------------------------

nmap <Leader>a& :Tabularize /&<CR>
vmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

" ---------------------------------------------------------------------------
" Ruby/Rails
" ---------------------------------------------------------------------------

" Execute current buffer as ruby
map <S-r> :w !ruby<CR>

" View routes or Gemfile in large split
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gg :topleft :split Gemfile<cr>

" Rspec.vim mappings
map <Leader>rt :call RunCurrentSpecFile()<CR>
map <Leader>rs :call RunNearestSpec()<CR>
map <Leader>rl :call RunLastSpec()<CR>

" ---------------------------------------------------------------------------
" Ember
" ---------------------------------------------------------------------------

map <leader>ec :FZF app/components<cr>
map <leader>et :FZF app/templates<cr>
map <leader>em :FZF app/models<cr>
map <leader>eh :FZF app/helpers<cr>
map <leader>eo :FZF app/routes<cr>
map <leader>es :FZF app/services<cr>
map <leader>ep :topleft :split package.json<cr>

" ---------------------------------------------------------------------------
" Golang configs
" ---------------------------------------------------------------------------

" For .go files, use tabs instead of spaces
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=2 shiftwidth=2 nolist

let g:go_fmt_command = "goimports"
let g:go_addtags_transform = "snakecase"
let g:go_def_mapping_enabled = 0

" Enhanced Go syntax highlighting
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_string_spellcheck = 2
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

" ---------------------------------------------------------------------------
" Syntax highlight for unsual filetypes
" ---------------------------------------------------------------------------

au BufRead,BufNewFile nginx.conf if &ft == '' | setfiletype nginx | endif
au BufRead,BufNewFile Dockerfile.dev if &ft == '' | setfiletype Dockerfile | endif

" ---------------------------------------------------------------------------
" Plugins
" ---------------------------------------------------------------------------

" Polyglot
let g:polyglot_disabled = ['handlebars', 'go']

" Auto Pairs
let g:AutoPairsOnlyBeforeClose = 1

"-------------------------
" NERDTree
let NERDTreeShowBookmarks = 0
let NERDChristmasTree = 1
let NERDTreeWinPos = "left"
let NERDTreeHijackNetrw = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 30
let NERDTreeChDirMode = 2
let NERDTreeDirArrows = 1
let NERDTreeMinimalUI=1

silent! nmap <silent> <Leader>m :NERDTreeToggle<CR>
silent! nmap <silent> <leader>f :NERDTreeFind<cr>

"-------------------------
" NERDCommenter

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

if has("gui_macvim") && has("gui_running")
  map <D-/> <plug>NERDCommenterToggle<CR>
  imap <D-/> <Esc><plug>NERDCommenterToggle<CR>
else
  map <leader>/ <plug>NERDCommenterToggle<CR>
endif

"-------------------------
" Tagbar
map <leader>l :TagbarToggle <cr>
let g:tagbar_autofocus=1

let g:tagbar_type_javascript = {
    \ 'ctagstype' : 'JavaScript',
    \ 'kinds'     : [
        \ 'o:objects',
        \ 'f:functions',
        \ 'a:arrays',
        \ 's:strings'
    \ ]
\ }

" Generate ctags for all bundled gems as well
map <leader>rtg :!ctags --extra=+f --languages=-javascript --exclude=.git --exclude=log -R * `rvm gemdir`/gems/* `rvm gemdir`/bundler/gems/*<CR><C-M>

" Use only current file to autocomplete from tags
" set complete=.,t
set complete=.,w,b,u,t,i

"-------------------------
" Airline
set laststatus=2
" let g:airline_theme = 'base16_nord'
let g:airline_powerline_fonts = 1
let g:airline_symbols = { 'linenr': '␤ ', 'branch': '⎇ ' }
let g:airline_inactive_collapse=0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_mode_map = {
      \ 'n' : 'N',
      \ 'i' : 'I',
      \ 'R' : 'REPLACE',
      \ 'v' : 'VISUAL',
      \ 'V' : 'V-LINE',
      \ 'c' : 'CMD   ',
      \ '': 'V-BLCK',
      \ }

" Sparkup
" Enable sparkup in handlebars files
autocmd FileType handlebars runtime! ftplugin/html/sparkup.vim

"-------------------------
" Gitgutter
let g:gitgutter_sign_added = '•'
let g:gitgutter_sign_modified = '›'
let g:gitgutter_sign_removed = '▪'
let g:gitgutter_sign_removed_first_line = g:gitgutter_sign_removed
let g:gitgutter_sign_modified_removed = g:gitgutter_sign_removed

"-------------------------
" Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = [
  \ 'js=javascript',
  \ 'ts=typescript=ts',
  \ 'rb=ruby',
  \ 'hbs=html']

"-------------------------
" ALE Linting
let g:airline#extensions#ale#enabled = 1

let g:ale_sign_column_always = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'

let g:ale_fixers = {
\  'javascript': ['prettier'],
\  'json': ['prettier'],
\  'typescript': ['prettier'],
\  'graphql': ['prettier'],
\  'go': ['goimports', 'gofmt'],
\  'yaml': ['prettier'],
\  'scss': ['prettier'],
\  'css': ['prettier'],
\  'elixir': ['mix_format'],
\  'terraform': ['terraform']
\}

let g:ale_fix_on_save = 1

"-------------------------
" Closetag
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.jsx,*.hbs"

"-------------------------
" vim-multiple-cursors
map <leader>d :call multiple_cursors#quit()<CR>



"-------------------------
" vim-js-pretty-template

" Allow for named template literals to be highlighted
" in a different syntax than the main buffer.
" https://github.com/Quramy/vim-js-pretty-template
function EnableTemplateLiteralColors()
  " list of named template literal tags and their syntax here
  call jspretmpl#register_tag('hbs', 'handlebars')
  call jspretmpl#register_tag('gql', 'graphql')

  autocmd FileType javascript JsPreTmpl
  autocmd FileType typescript JsPreTmpl
endfunction

call EnableTemplateLiteralColors()

" ---------------------------------------------------------------------------
" Strip trailing whitespace
" ---------------------------------------------------------------------------
function! <SID>StripTrailingWhitespaces()
  " Don't try to strip whitespace in non buffers
  if (!empty(&buftype))
    return
  endif

  " Only strip whitespace if isn't a slim, haml or emblem file
  if &filetype =~ 'slim' || &filetype =~ 'haml' || &filetype =~ 'emblem'
    return
  endif
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" ---------------------------------------------------------------------------
" Add support to go to file in JS without file extention
" ---------------------------------------------------------------------------
augroup suffixes
  autocmd!
  let associations = [
    \ ["javascript", ".js,.ts,.json,.jsx,.graphql"],
    \ ["typescript", ".js,.ts,.json,.jsx,.graphql"]]

  for ft in associations
    execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
  endfor
augroup END

" ---------------------------------------------------------------------------
" Autosave
" ---------------------------------------------------------------------------

" Strip trailing whitespaces then save all files on focus lost
autocmd FocusLost * :call <SID>StripTrailingWhitespaces() | silent! wa

" ---------------------------------------------------------------------------
" GUI
" ---------------------------------------------------------------------------
if has("termguicolors") && !($TERM_PROGRAM == "Apple_Terminal")
  set termguicolors
endif

" colorscheme
if !exists("g:gui_oni")
  if has('nvim')
    " color challenger_deep
    " color base16-oceanicnext
    color palenight
  else
    color palenight
    " color onedark
    " color OceanicNext
  endif
endif

if has("gui_running")
  set guioptions-=T " no toolbar set guioptions-=m " no menus
  set guioptions-=r " no scrollbar on the right
  set guioptions-=R " no scrollbar on the right
  set guioptions-=l " no scrollbar on the left
  set guioptions-=b " no scrollbar on the bottom
  set guioptions-=L "no scrollbar on the nerdtree"

  set guitablabel=%M%t

  if has("gui_gnome")
    set term=gnome-256color
    set guifont=Ubuntu\ Mono\ 12
  endif

  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
  endif

  if has("gui_win32") || has("gui_win32s")
    set guifont=Consolas:h12
  endif
else
  set novisualbell " Mute error bell

  if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
  else
    if $TERM == 'xterm'
      set term=xterm-256color
    endif
  endif
endif

" listchars only for slim and haml files
autocmd BufNewFile,BufRead *.slim,*.haml,*.emblem setlocal list listchars=extends:>,precedes:<,eol:¬

" ---------------------------------------------------------------------------
" Column color
" ---------------------------------------------------------------------------

set colorcolumn=80
" highlight ColorColumn guibg=#1e1e1e
highlight clear SignColumn

set fillchars+=vert:⇥

" ---------------------------------------------------------------------------
" SuperTab & Auto Complete
" ---------------------------------------------------------------------------
let g:SuperTabDefaultCompletionType = "<c-n>"

function! s:AcceptAutoCompleteOrReturnNewline()
    if pumvisible()
        return "\<C-y>"
    else
        return "\<C-g>u\<CR>"
    endif
endfunction
inoremap <silent> <CR> <C-r>=<SID>AcceptAutoCompleteOrReturnNewline()<CR>

" ---------------------------------------------------------------------------
" coc.nvim
" https://github.com/neoclide/coc.nvim
" ---------------------------------------------------------------------------

" Default Extensions:
let g:coc_global_extensions = [
      \ "coc-tsserver",
      \ "coc-go",
      \ "coc-json",
      \ "coc-html",
      \ "coc-css",
      \ "coc-highlight",
      \ "coc-snippets",
      \ "coc-emmet",
      \ "coc-yaml",
      \ "coc-pairs",
      \ "coc-tailwindcss",
      \ "coc-ember",
      \ "coc-yank"]

" Use <c-space> for trigger completion.
imap <silent><expr> <c-space> coc#refresh()
" Use <space> + y to show the list of yank
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use sh for show documentation in preview window
nnoremap <silent> sh :call <SID>show_documentation()<CR>

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>F  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'


" ---------------------------------------------------------------------------
" Load custom configs
" ---------------------------------------------------------------------------

if filereadable(expand("$HOME/") . '.vimrc.local')
  source ~/.vimrc.local
endif

" ---------------------------------------------------------------------------
" Load folder specific settings and disable unsafe commands
" ---------------------------------------------------------------------------
set exrc
set secure


" set background=dark
" colorscheme palenight
" let g:lightline = { 'colorscheme': 'palenight' }
let g:airline_theme = "gruvbox"

" if (has("nvim"))
  " "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  " let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" endif

" "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
" "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

let g:gruvbox_italic=1

" " Italics for my favorite color scheme
" let g:palenight_terminal_italics=1
"
"
colorscheme gruvbox
 " let g:airline_theme = "gruvbox"

 let g:gruvbox_invert_tabline = '1'
let g:gruvbox_improved_warnings = '1'
let g:gruvbox_vert_split = "bg1"
let g:gruvbox_contrast_dark = "hard"

set nocompatible              " be iMproved, required
filetype off                  " required

if !exists('g:vscode')
  let mapleader="\<space>"
  " set the runtime path to include Vundle and initialize
  "set rtp+=~/.vim/bundle/Vundle.vim
  "call vundle#begin()
  call plug#begin('~/.vim/plugged')
  Plug 'tpope/vim-fugitive'
    nnoremap <leader>gs :Gstatus<cr>
    nnoremap <leader>gb :Gblame<cr>
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
    nnoremap <leader>lp :Files<cr>
    nnoremap <leader>lb :Buffers<cr>
    nnoremap <leader>bd :bd<cr>
    nnoremap <leader>bb :b#<cr>
    nnoremap <leader>ll :BLines<cr>
  Plug 'fatih/vim-go'
    nnoremap <leader>gr :GoRun<cr>
    nnoremap <leader>gb :GoBuild<cr>
    nnoremap <leader>gta :GoTest<cr>
    nnoremap <leader>gtf :GoTestFunc<cr>
    nnoremap <leader>gml :GoMetaLinter<cr>
    nnoremap <leader>gd :GoDef<cr>
    let g:go_fmt_command = "goimports"
    let g:go_auto_sameids = 1
    let g:go_auto_type_info = 1
  Plug 'altercation/vim-colors-solarized'
  Plug 'cespare/vim-toml'
  Plug 'ervandew/supertab'
  Plug 'equal-l2/vim-base64'
  " <leader>atob to convert a string to base64 string.
  " <leader>btoa to convert a base64 string to original string.
  Plug 'vim-scripts/groovy.vim'
  Plug 'jremmen/vim-ripgrep'
  Plug 'stephpy/vim-yaml'
"  Plug 'scrooloose/nerdtree'
"    nnoremap <leader>nn :NERDTree
"    nnoremap <leader>nr :NERDTreeRefreshRoot
"    nnoremap <leader>nf :NERDTreeFind
  Plug 'mbbill/undotree'
  Plug 'nvim-tree/nvim-tree.lua'
    nnoremap <leader>nn :NvimTreeToggle
    nnoremap <leader>nf :NvimTreeFindFile
  Plug 'junegunn/vim-easy-align'
    vmap <Leader><bar> :EasyAlign*<bar><enter>
  Plug 'tpope/vim-commentary'
  Plug 'rust-lang/rust.vim'
    let g:rustfmt_autosave = 1
  Plug 'psf/black'
    nnoremap <leader>pf :Black<cr>
    let g:black_linelength = 119
  Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh', }
    let g:LanguageClient_serverCommands = {
        \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
        " need to install python-lsp-server archlinux package
        \ 'python': ['/usr/bin/pylsp'],
        \ }
    nnoremap <F5> <Plug>(lcn-menu)
  call plug#end()
endif

filetype plugin indent on    " required
autocmd FileType yaml setl indentkeys-=<:>

set mouse=a background=dark
set ai et sw=2 ts=2 sts=2 rnu nu
syntax on

" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

if !exists('g:vscode')
  " split window below and right
  set splitbelow
  set splitright

  set laststatus=2
  let g:powerline_pycmd="py3"
  set autowrite

  "colorscheme gotham
  set nomodeline
endif

" change cursor position in bepo
" commenting this section since xremap do this quite well, with the alt
" modifier
" noremap C h
" noremap T j
" noremap S k
" noremap R l


" trim whitespace at end of lines
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()
autocmd BufNewFile,BufRead *.sls setfiletype sls
autocmd FileType sls setlocal commentstring=#\ %s
autocmd FileType jinja setlocal commentstring={#\ %s\ #}

set foldlevel=10
if !exists('g:vscode')
  autocmd BufWinLeave *.TODO mkview
  autocmd BufWinEnter *.TODO silent loadview
endif

if !exists('g:vscode')
  " Search for selected text, forwards or backwards.
  vnoremap <silent> * :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
    \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gVzv:call setreg('"', old_reg, old_regtype)<CR>
  vnoremap <silent> # :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
    \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gVzv:call setreg('"', old_reg, old_regtype)<CR>
endif


lua <<EOF
-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
--vim.opt.termguicolors = true

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

require("LanguageClient").setup(
  pylsp = {
    plugins = {
      ruff = {
        enabled = true,  -- Enable the plugin
        formatEnabled = true,  -- Enable formatting using ruffs formatter
        executable = "<path-to-ruff-bin>",  -- Custom path to ruff
        config = "<path_to_custom_ruff_toml>",  -- Custom config for ruff to use
        extendSelect = { "I" },  -- Rules that are additionally used by ruff
        extendIgnore = { "C90" },  -- Rules that are additionally ignored by ruff
        format = { "I" },  -- Rules that are marked as fixable by ruff that should be fixed when running textDocument/formatting
        severities = { ["D212"] = "I" },  -- Optional table of rules where a custom severity is desired
        unsafeFixes = false,  -- Whether or not to offer unsafe fixes as code actions. Ignored with the "Fix All" action

        -- Rules that are ignored when a pyproject.toml or ruff.toml is present:
        lineLength = 119,  -- Line length to pass to ruff checking and formatting
        exclude = { "__about__.py" },  -- Files to be excluded by ruff checking
        select = { "F" },  -- Rules to be enabled by ruff
        ignore = { "D210" },  -- Rules to be ignored by ruff
        perFileIgnores = { ["__init__.py"] = "CPY001" },  -- Rules that should be ignored for specific files
        preview = false,  -- Whether to enable the preview style linting and formatting.
        targetVersion = "py310",  -- The minimum python version to target (applies for both linting and formatting).
      },
    }
  }
)
EOF

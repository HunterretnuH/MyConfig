set ts=4 sts=4 sw=4 et
set autoindent smartindent
set breakindent breakindentopt=min:20,shift:1,sbr showbreak=>\  

set ignorecase smartcase

set number
set cursorline

set clipboard=unnamedplus

set hidden

let mapleader = ","

"Regex to clear whitespaces at the EOL in whole buffer
noremap <leader>w :%s/\s\+$//<CR>:noh<CR>


"NETRW

let g:netrw_banner = 0     " Hide annoying 'help' banner
let g:netrw_liststyle = 3  " Use tree view
let g:netrw_winsize = '30' " Smaller default window size

"VIM-PLUG

" Specify a directory for plugins (:echo stdpath('data') and add folder /plugged)
call plug#begin('~/.local/share/nvim/plugged') 

Plug 'https://github.com/nanotech/jellybeans.vim.git'
Plug 'https://github.com/itchyny/lightline.vim.git'
Plug 'https://github.com/junegunn/fzf.vim.git'
Plug 'https://github.com/easymotion/vim-easymotion.git'
Plug 'https://github.com/natebosch/vim-lsc.git'
Plug 'https://github.com/vimwiki/vimwiki' "TODO Coonsider lazy loading

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'https://github.com/neoclide/coc.nvim', { 'branch': 'release', 'for': 'cs' }
Plug 'https://github.com/OmniSharp/omnisharp-vim', { 'for': 'cs' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Initialize plugin system
call plug#end()

"JELLYBEANS.VIM

colorscheme jellybeans

"LIGHTLINE.VIM

let g:lightline = {'colorscheme': 'jellybeans'}
set noshowmode

"OMNISHARP
let g:OmniSharp_selector_ui = 'fzf'    " Use fzf

"FZF.vim
nmap <leader>b :Buffers<CR>
"TODO

"VIM-EASYMOTION

let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap s <Plug>(easymotion-overwin-f2)

"VIM WIKI
let g:vimwiki_list = [{ 'path': '~/VimWiki/',
                      \ 'syntax': 'markdown',
                      \ 'ext': '.md'}]

nmap <leader>mp <Plug>MarkdownPreviewToggle

"COC.NVIM
let g:coc_global_extensions=[ 'coc-omnisharp' ] " Provides list of extansions for coc.nvim to be installed automatically
nmap <leader>rn <Plug>(coc-rename)

"VIM-LSC

" Used to make sure that error messages are not suppressed (neovim specific)
set shortmess-=F 

" All possible mappings TODO - change overrides
let g:lsc_auto_map = {
    \ 'GoToDefinition': '<C-]>',
    \ 'GoToDefinitionSplit': ['<C-W>]', '<C-W><C-]>'],
    \ 'FindReferences': 'gr',
    \ 'NextReference': '<C-n>',
    \ 'PreviousReference': '<C-p>',
    \ 'FindImplementations': 'gI',
    \ 'FindCodeActions': 'ga',
    \ 'Rename': 'gR',
    \ 'ShowHover': v:true,
    \ 'DocumentSymbol': 'go',
    \ 'WorkspaceSymbol': 'gS',
    \ 'SignatureHelp': 'gm',
    \ 'Completion': 'completefunc',
    \}

"Set ccls language server for cpp files
let g:lsc_server_commands = {
\ 'cpp': {
\    'command': 'ccls',
\    'suppress_stderr': v:true,
\    'message_hooks': {
\        'initialize': {
\            'initializationOptions': {'cache': {'directory': '/tmp/ccls/cache'}},
\            'rootUri': {m, p -> lsc#uri#documentUri(fnamemodify(findfile('compile_commands.json', expand('%:p') . ';'), ':p:h'))}
\        },
\    },
\  },
\ 'c': {
\    'command': 'ccls',
\    'suppress_stderr': v:true,
\    'message_hooks': {
\        'initialize': {
\            'initializationOptions': {'cache': {'directory': '/tmp/ccls/cache'}},
\            'rootUri': {m, p -> lsc#uri#documentUri(fnamemodify(findfile('compile_commands.json', expand('%:p') . ';'), ':p:h'))}
\        },
\    },
\  },
\
\ 'python' : 'pyls' 
\}

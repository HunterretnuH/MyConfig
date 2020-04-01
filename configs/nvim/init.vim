set ts=4 sts=4 sw=4 et
set autoindent smartindent
set breakindent breakindentopt=min:20,shift:1,sbr showbreak=>\  

set ignorecase smartcase

set number
set cursorline

set clipboard=unnamedplus


let mapleader = ","

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

" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Initialize plugin system
call plug#end()

"JELLYBEANS.VIM

colorscheme jellybeans

"LIGHTLINE.VIM

let g:lightline = {'colorscheme': 'jellybeans'}
set noshowmode

"FZF.vim

"TODO

"VIM-EASYMOTION

let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap s <Plug>(easymotion-overwin-f2)

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
\
\ 'python' : 'pyls' 
\}

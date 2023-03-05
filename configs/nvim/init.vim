" vim: foldmethod=marker
" Whole 2 years of config modifications was lost ;(
" TODO:
" * właściwie to można przepisać to wszystko na LUA od razu, ale najpiew poukładam co już jest
" * znaleźć uniwersalny fold i ustawić kategorie typu: general options, general keybindings, plugin-manager, per-plugin settings
" * skonfigurować vim-wiki, albo od razu zmigrowac na inne wiki
" * skonfigurować tree-sitter
" * 
" * 
" * 

" {{{ BASIC SETTINGS
set ts=4 sts=4 sw=4 et
set autoindent smartindent
set breakindent breakindentopt=min:20,shift:1,sbr showbreak=>\  
set ignorecase smartcase
set number
set cursorline
set clipboard=unnamedplus
set hidden
set termguicolors
"}}}

let mapleader = "\<Space>"

"Regex to clear whitespaces at the EOL in whole buffer
noremap <leader>w :%s/\s\+$//<CR>:noh<CR>

noremap : q:i
noremap q: :
noremap / q/i
noremap q/ / 
noremap ? q?i
noremap q? ? 

"NETRW

let g:netrw_banner = 0     " Hide annoying 'help' banner
let g:netrw_liststyle = 3  " Use tree view
let g:netrw_winsize = '30' " Smaller default window size

"VIM-PLUG

" Specify a directory for plugins (:echo stdpath('data') and add folder /plugged)
call plug#begin('~/.local/share/nvim/plugged') 

"Plug 'nanotech/jellybeans.vim'
"Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'vimwiki/vimwiki' "TODO Coonsider lazy loading
Plug 'chrisbra/Recover.vim'
Plug 'habamax/vim-godot'
Plug 'jremmen/vim-ripgrep'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'preservim/tagbar'
Plug 'tomasr/molokai'
Plug 'rktjmp/lush.nvim'
Plug 'metalelf0/jellybeans-nvim'
Plug 'olimorris/onedarkpro.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'nvim-treesitter/playground'
Plug 'npxbr/gruvbox.nvim'
"Plug 'ryanoasis/vim-devicons'
Plug  'nvim-tree/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'

" On-demand loading
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'https://github.com/neoclide/coc.nvim', { 'branch': 'release', 'for': ['cs', 'c'] }
"autocmd! User coc.nvim source ~/.config/nvim/coc-init.lua
Plug 'OmniSharp/omnisharp-vim', { 'for': 'cs' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Initialize plugin system
call plug#end()

"JELLYBEANS.VIM

"colorscheme jellybeans-nvim

"LIGHTLINE.VIM

let g:lightline = {'colorscheme': 'jellybeans'}
set noshowmode

"OMNISHARP
let g:OmniSharp_selector_ui = 'fzf'    " Use fzf
nmap K :OmniSharpDocumentation<CR>
nmap <C-k> :OmniSharpGotoDefinition<CR>


"FZF.vim
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>ff :Files<CR>

"VIM-EASYMOTION

let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap s <Plug>(easymotion-overwin-f2)

"VIM WIKI
let g:vimwiki_list = [{ 'path': '~/Documents/Wiki-Notatki/',
            \ 'syntax': 'markdown',
            \ 'ext': '.md'}]

nmap <leader>mp <Plug>MarkdownPreviewToggle

"COC.NVIM
let g:coc_global_extensions=[ ] " Provides list of extansions for coc.nvim to be installed automatically

lua << EOF
require'nvim-treesitter.configs'.setup 
{
    -- A list of parser names, or "all"
    ensure_installed = { "c", "lua", "c_sharp", "python", "bash" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    --auto_install = true,

    -- List of parsers to ignore installing (for "all")
    --ignore_install = { "javascript" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = 
    {
            -- `false` will disable the whole extension
            enable = true,

            -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
            -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
            -- the name of the parser)
            -- list of language that will be disabled
            --disable = { "c", "rust" },
            -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    },
}
EOF

"TAGBAR
noremap <leader>go :TagbarToggle<CR>
noremap <leader>gf :NERDTreeToggle<CR>


lua << EOF
require("onedarkpro").setup({
dark_theme = "onedark_vivid", -- The default dark theme
light_theme = "onelight", -- The default light theme
colors = {
    onedark = {
        bg = "#121212" -- grey
        },
    onedark_vivid = {
        bg = "#121212" -- grey
        },
    onelight = {
        --bg = "#121212" -- grey
        }
    },
    styles = {
        conditionals = "bold",
        repeats = "bold",
        functions = "bold",
    },
    options = {
        cursorline = true,
    }
    })
vim.cmd("colorscheme onedarkpro")
EOF

lua << EOF
require('lualine').setup {
 options = { theme  = 'onedarkpro' },
}
EOF

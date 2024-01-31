--############################### NEOVIM CONFIG ##################################

--{ GENERAL FUNCTIONS

--  local function init_toggle(on_handler, off_handler, name)
--      local message = name
--      local state = "off"
--      local toggle = function()
--          if state == "off" then
--              state = "on"
--              message = message .. " enabled"
--              on_handler()
--          else
--              state = "off"
--              message = message .. " disabled"
--              off_handler()
--          end
--          vim.notify(message)
--      end
--      return toggle
--  end

--} GENERAL FUNCTIONS

--###################    GENERAL CONFIG    #####################
--{ OPTIONS

    vim.o.tabstop = 4                               -- set ts=4
    vim.o.softtabstop = 4                           -- set sts
    vim.o.shiftwidth = 4                            -- set sw=4
    vim.o.expandtab = true                          -- set ts
    vim.o.autoindent = true                         -- set ai
    vim.o.smartindent = true                        -- set smartindent
    vim.o.breakindent = true                        -- set breakindent
    vim.o.breakindentopt = 'min:20,shift:1,sbr'     -- set breakindentopt=min:20,shift:1,sbr
    vim.o.showbreak = [[|-> ]]                      -- set showbreak=\|->\
    vim.o.ignorecase = true                         -- set ignorecase
    vim.o.smartcase = true                          -- set smartcase
    vim.o.number = true                             -- set number
    vim.o.relativenumber = true                     -- set relativenumber
    vim.o.cursorline = true                         -- set cursorline
    vim.o.clipboard = 'unnamedplus'                 -- set clipboard=unnamedplus
    vim.o.hidden = true                             -- set hidden
    vim.o.termguicolors = true                      -- set termguicolors
    vim.o.hlsearch = true                           -- set hlsearch
    vim.o.signcolumn = 'auto:2'                     -- set termguicolors
    vim.o.spelllang = 'en,pl'
    vim.o.cedit = '<C-e>'
    vim.o.virtualedit = 'all'
    -- TODO Add autocmd to go to insert mode after opening Cmd Window
    -- TODO Add autocmd make bufer local mapping for Cmd Window to close with q
    --vim.o.timeoutlen = 1000
    --vim.o.ttimeoutlen = 500

--} OPTIONS
--{ BASIC KEYMAPPINGS

    vim.g.mapleader = ' '           -- let mapleader = "\<Space>"
    local telescopeLeader = '\''
    local debugLeader = '\\'

    vim.keymap.set({ 'n', 'v', 'o' }, ':',  'q:i', { remap = false }) -- noremap : q:i
    vim.keymap.set({ 'n', 'v', 'o' }, '/',  'q/i', { remap = false }) -- noremap / q/i
    vim.keymap.set({ 'n', 'v', 'o' }, '?',  'q?i', { remap = false }) -- noremap ? q?i
    vim.keymap.set({ 'n', 'v', 'o' }, 'q:', ':',   { remap = false }) -- noremap q: :
    vim.keymap.set({ 'n', 'v', 'o' }, 'q/', '/',   { remap = false }) -- noremap q/ /
    vim.keymap.set({ 'n', 'v', 'o' }, 'q?', '?',   { remap = false }) -- noremap q? ?

    local function removeSomeKeyMappingsInCmdLineWin()
        vim.keymap.set({ 'n', 'v', 'o' }, ':', ':',   { remap = false, buffer = true }) -- noremap <silent> : :
        vim.keymap.set({ 'n', 'v', 'o' }, '/', '/',   { remap = false, buffer = true }) -- noremap <silent> / /
        vim.keymap.set({ 'n', 'v', 'o' }, '?', '?',   { remap = false, buffer = true }) -- noremap <silent> ? ?
        vim.keymap.set({ 'n', 'v', 'o' }, 'q:', 'q:', { remap = false, buffer = true }) -- noremap <silent> q: q:
        vim.keymap.set({ 'n', 'v', 'o' }, 'q/', 'q/', { remap = false, buffer = true }) -- noremap <silent> q/ q/
        vim.keymap.set({ 'n', 'v', 'o' }, 'q?', 'q?', { remap = false, buffer = true }) -- noremap <silent> q? q?
    end
    vim.api.nvim_create_autocmd( {"CmdwinEnter"}, { callback = removeSomeKeyMappingsInCmdLineWin} )

--} BASIC KEYMAPPINGS
--{ ADDITIONAL KEYMAPPINGS: <l>p = VisSelRepl, <l>cd = ChDirToCurrFileLoc, <l>dw = RmEOLNewLine, <l>dW = RmEOLCarrRet

    -- Replace visual selection with clipboard content, but don't yank selected text to clipboard
    vim.keymap.set('v', '<leader>p', '"_dP', { remap = false, silent = true }) -- vnoremap <silent> <leader>p "_dP

    -- Change vim current working directory to currently opened file location.
    vim.keymap.set({ 'n' }, '<leader>cd', function()                            -- nnoremap <leader>cd :cd%:p:h<CR>
        vim.cmd('cd%:p:h')
        local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":p")
        vim.notify("Changed CWD to: " .. dir)
    end
    , { remap = false })

    -- Regex to clear whitespaces at the EOL in whole buffer
    vim.keymap.set('n', '<leader>dw', ':%s/\\s\\+$//<CR>:noh<CR>', {}) -- noremap <leader>dw :%s/\s\+$//<CR>:noh<CR>

    -- Regex to clear all carriage returns at the EOL in whole buffer
    vim.keymap.set({ 'n', 'v', 'o' }, '<leader>dm',  ':%s/\\r//g<CR>:noh<CR>', {}) -- noremap <leader>dm :%s/\r//g<CR>:noh<CR>

    -- Edit vimrc - init.lua
    vim.keymap.set('n', '<leader>ce', ':edit $MYVIMRC<CR>', {})

    -- Source vimrc - init.lua
    vim.keymap.set('n', '<leader>cl', ':source $MYVIMRC<CR>', {})

    -- Disable search highlight
    vim.keymap.set('n', '<C-n>', ':noh<CR>', {})

    -- Save
    vim.keymap.set('n', '<C-s>', ':w<CR>', {})

    -- Save all
    vim.keymap.set('n', '<C-s>s'    , ':wa<CR>:lua vim.notify("Saved all buffers")<CR>', { silent = true })
    -- Ditto modified to allow holding Ctrl
    vim.keymap.set('n', '<C-s><C-s>', ':wa<CR>:lua vim.notify("Saved all buffers")<CR>', { silent = true })


    -- Reload/repply modelines
    vim.keymap.set('n', '<C-r>m',     ':doautocmd BufRead<CR>', { silent = true })
    -- Ditto modified to allow holding Ctrl
    vim.keymap.set('n', '<C-r><C-m>', ':doautocmd BufRead<CR>', { silent = true })

    -- Quit
    vim.keymap.set({'n', 'i' }, '<C-q>', '<ESC>:q<CR>', { remap = false, silent = true })

    -- Force quit
    vim.keymap.set({'n', 'i' }, '<C-S-q>', '<ESC>:q!<CR>', { remap = false, silent = true })

    -- Help
    vim.keymap.set('n', '<C-h>', ':e ~/Documents/MyWiki/VIM.md<CR>:lua vim.notify("Help opened")<CR>', { remap = false, silent = true })

    -- Exit terminal
    vim.keymap.set('t', '<Leader><ESC>', '<C-\\><C-n>', {noremap = true})

    -- Delete words with Ctrl + Backspace
    vim.keymap.set({'n', 'i' }, '<C-BS>', '<C-w>', { remap = false, silent = true })

    -- Highlight occurances of any non-ascii character
    -- TODO: Finish toggle and hl group creation for some reason doesn't work for me in lua, but nonascii group already exists
    --vim.api.nvim_set_hl(0, "dupa", { guibg = Blue, bold = true })
    vim.api.nvim_create_autocmd( {"BufReadPost"}, {
        callback = function()
            vim.cmd('syntax match nonascii "[^\\u0000-\\u007F]"')
        end })
    --vim.keymap.set({ 'n' }, '<leader>hn', ':syntax match nonascii "[^\\u0000-\\u007F]"<CR>', { remap = false })

    -- TABS MANAGEMENT
    -- Open new tab
    -- Rename tab
    -- Delete tab
    -- notemap <C-t>
    -- nnoremap g<C-t> <C-t>
    -- vim.keymap.set({ 'n' }, '<C-h>', ':e ~/Documents/MyWiki/VIM.md<CR>:lua vim.notify("Help opened")<CR>', { remap = false, silent = true })

--} ADDITIONAL KEYMAPPINGS

--###################    PLUGINS CONFIG    #####################
--{ DUPLICATE-SETTINGS        global variables for plugins necessary to be set before loading plugins

    -- NVIM-TREE
    vim.g.loaded_netrw = 1       -- let g:loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1 -- let g:loaded_netrwPlugin = 1

    -- RNVIMR
    local rnvimr = vim.fn.stdpath("config") .. "/tmp.vim"
    --vim.cmd.source(rnvimr)

--} DUPLICATE-SETTINGS
--{ EDIT BROWSER TEXTBOXES:   FIRENVIM    TODO: Check why it must be present before loading plugins

        --  local function toggle_spell_check()
        --      vim.opt.spell = not(vim.opt.spell:get())
        --  end

        vim.api.nvim_create_autocmd({'UIEnter'}, {
            callback = function(event)
                local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
                if client ~= nil and client.name == "Firenvim" then
                    vim.opt.spell = true
                    --vim.keymap.set({ 'n', 'v', 'o', 'i' }, '<C-e>',  '<Esc>:wq<CR>', { remap = false }) -- noremap : q:i
                    vim.keymap.set({ 'n' }, '<CR>',  ':wq<CR>', { remap = false }) -- noremap : q:i
                    vim.keymap.set({'n', 'i' }, '<C-q>', '<ESC>:wq<CR>', { remap = false, silent = true })
                end
            end
        })

        vim.g.firenvim_config = {
            globalSettings = { alt = "all" },
            localSettings = {
                [".*"] = {
                    cmdline  = "neovim",
                    content  = "text",
                    priority = 0,
                    selector = "textarea",
                    takeover = "never"
                }
            }
        }

--} EDIT BROWSER TEXTBOXES

--{ PLUGIN MANAGER            LAZY.NVIM

    --{ Install lazy.nvim if not installed (bootstrap)
        -- TODO: Doesn't work probably due to being embedded in init.vim
        local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
        if not vim.loop.fs_stat(lazypath) then
            vim.fn.system({
                "git",
                "clone",
                "--filter=blob:none",
                "https://github.com/folke/lazy.nvim.git",
                "--branch=stable", -- latest stable release
                lazypath,
            })
        end
        vim.opt.rtp:prepend(lazypath)
    --}

    vim.keymap.set({ 'n' }, '<leader>mp', ':Lazy<CR>')
    -- TODO: Check:
    -- * https://github.com/numToStr/Comment.nvim
    -- * https://github.com/gcmt/taboo.vim
    -- * https://github.com/lukas-reineke/headlines.nvim

    -- List of plugins
        require("lazy").setup({
        --{ GENERALY USEFULL PLUGINS
            { "nvim-treesitter/nvim-treesitter",                    -- syntax highlighting
                 build = ":TSUpdate" },
            { "metalelf0/jellybeans-nvim" },                        -- colorscheme
            { "olimorris/onedarkpro.nvim" },                        -- colorscheme
            { "nvim-lualine/lualine.nvim",                          -- statusline
                dependencies = { "nvim-tree/nvim-web-devicons" } },
            { "nvim-tree/nvim-tree.lua",                            -- simple file manager with tree view
                dependencies = { "nvim-tree/nvim-web-devicons" } },
            { "kevinhwang91/rnvimr" },                              -- ranger file manager inside vim TODO: Add deps
            { "jremmen/vim-ripgrep" },                              -- ripgrep and vim integration TODO: Add deps - ripgrep
            { "nvim-telescope/telescope.nvim",
                tag = '0.1.2',
                dependencies = { 'nvim-lua/plenary.nvim' } },
            { "LukasPietzschmann/telescope-tabs" },
            { "junegunn/fzf.vim",                                   -- Fuzzy Finder FZF and vim integration
                dependencies = { "junegunn/fzf",
                                 build = ":call fzf#Install()" } },
            { "chrisbra/Recover.vim" },                             -- Addc [C]ompare option to recovery menu
            { "tpope/vim-repeat" },
            { 'ggandor/lightspeed.nvim' },
         -- { 'justinmk/vim-sneak' },
         -- { "easymotion/vim-easymotion" },                        -- Move to any place on screen
            { "lervag/wiki.vim" },                                  -- personal wiki
         -- { "preservim/vim-markdown" },                           -- syntax highlighting for markdown files
            { "img-paste-devs/img-paste.vim" },                     -- paste image file links in markdown (or custom) format
            { "godlygeek/tabular" },
            { "edluffy/hologram.nvim" },
            { "PeterRincker/vim-searchlight" },
            { "inkarkat/vim-ingo-library" },
            { "inkarkat/vim-mark" },
            { "akinsho/bufferline.nvim",
                version = "*",
                dependencies = 'nvim-tree/nvim-web-devicons'},
         -- { "kdheepak/tabline.nvim",
         -- config = function()
         --     require'tabline'.setup {
         --         options = {
         --              -- |  |  | 🭡 | 🭅 |
         --               section_separators = {'🭡  ', '🭅'},
         --               component_separators = {'/ ', '/'},
         --             }
         --         }
         --     end
         -- },
         -- { "petertriho/nvim-scrollbar"},
         -- { "kevinhwang91/nvim-hlslens",
         --     config = function()
         --         -- require('hlslens').setup() is not required
         --         auto_enable = false
         --         enable_incsearch = true
         --         require("scrollbar.handlers.search").setup({
         --             -- hlslens config overrides
         --             override_lens = function() end,
         --         })
         --     end,
         -- },
            { "dstein64/nvim-scrollview" },
            { "glacambre/firenvim",
                -- Lazy load firenvim
                -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
                cond = not not vim.g.started_by_firenvim,
                build = function()
                    require("lazy").load({ plugins = "firenvim", wait = true })
                    vim.fn["firenvim#install"](0)
                end },
            { "folke/which-key.nvim",
                event = "VeryLazy",
                init = function()
                    vim.o.timeout = true
                    vim.o.timeoutlen = 300
                end,
                opts = {
                    -- your configuration comes here or leave it empty to use the default settings
                } },
        --}
        --{ DEVELOPMENT-RELATED PLUGINS:
            { "preservim/tagbar" },                     -- outliner based on c tags TODO: Add C-tags dep
            { "folke/neodev.nvim", opts = {} },         -- Lua server, completion etc. for init.lua TODO: Check if works
            { "williamboman/mason.nvim",                -- LSP, DAP, Linter and Formatters
                 build = ":MasonUpdate" },              -- :MasonUpdate updates registry contents
            { "williamboman/mason-lspconfig.nvim" },    -- integration of mason and lspconfig i.e. adds hook which adds
            { "neovim/nvim-lspconfig" },                -- Configuration for servers for built-in LSP client
            { "hrsh7th/nvim-cmp" },                     -- Autocompletion plugin (instead of omnifunc)
            { "hrsh7th/cmp-nvim-lsp-signature-help" },  -- Function signatures with the current parameter emphasized source
            { "hrsh7th/cmp-nvim-lsp" },                 -- LSP source
            { "hrsh7th/cmp-buffer" },                   -- Buffer source
            { "hrsh7th/cmp-path" },                     -- Path completion source
            { "hrsh7th/cmp-cmdline" },                  -- Cmdline completion source
            { "L3MON4D3/LuaSnip" },                     -- Snippets plugin
            { "saadparwaiz1/cmp_luasnip" },             -- Snippets source for nvim-cmp
            { "mfussenegger/nvim-dap" },                -- Debug Adapter Protocol plugin
            { "jay-babu/mason-nvim-dap.nvim" },         -- Mason and nvim-dap integration
            { "rcarriga/nvim-dap-ui" },                 -- UI for nvim-dap
            { "habamax/vim-godot" },                    -- godot and vim integration TODO: Add deps?
            { "vim-scripts/AnsiEsc.vim" },              -- Allow optional coloring of console escape sequences
            { "ldelossa/litee.nvim" },
            { "ldelossa/litee-calltree.nvim" },
            { "nvim-telescope/telescope-project.nvim" },
            { "pianocomposer321/project-templates.nvim",
                 build = ':UpdateRemotePlugins' },
            { "nvim-telescope/telescope-ui-select.nvim" },
            { "Shatur/neovim-session-manager",
                 build = ":UpdateRemotePlugins" },
            { "tpope/vim-fugitive" },
            { "sindrets/diffview.nvim" }
        --}
        --{ OLD SAVED PLUGINS OR NEW ONES TO CHECK:
            -- { "lukas-reineke/indent-blankline.nvim" },               -- TODO: check and customize
            -- { "andymass/vim-matchup",
            --    event = "VimEnter" },
            -- { "jose-elias-alvarez/null-ls.nvim",
            --     dependencies = { "nvim-lua/plenary.nvim" } },
            -- { "neoclide/coc.nvim",                                  -- VSCode compatibility layer and LSP
            --   branch = "release" }, -- TODO: Fix lazy load and add coc-fzf and keybindings, fix :w<CR> permanently
            --     --ft = { "sh", "bash", "c", "cpp", "cmake", "html", "vim", "json", "php", "python" },
            --     --config = "vim.cmd[[source ~/.config/nvim/coc-init.lua]]" },
            -- { "antoinemadec/coc-fzf",                               -- Requires pynvim to be installed (pip3 install pynvim)
            --     branch = "release" },
            -- { "OmniSharp/omnisharp-vim",                            -- LSP and more, works better for C# then coc.nvim
            --     ft = {"cs"} },

            --use "nvim-treesitter/playground"
            --use {"glepnir/galaxyline.nvim", branch = "main", config = function() require"statusline" end, requires = {"kyazdani42/nvim-web-devicons"}}
            -- TODO:
            -- Plug "mfussenegger/nvim-dap"
            -- Plug "rcarriga/nvim-dap-ui"
            -- Plug "theHamsta/nvim-dap-virtual-text"
            -- Plug "nvim-lua/plenary.nvim"
            -- use "nvim-treesitter/nvim-treesitter-context"
            -- use "numToStr/Comment.nvim"
            -- use "junegunn/vim-peekaboo"
            -- use "ggandor/leap.nvim"
            -- Check: telescope.nvim and trouble.nvim
        --}
        })

--} PLUGIN MANAGER
--{ TREE FILE EXPLORER:       NVIM-TREE:        <l>t = NvimTreeToggle, <l>T = NvimTreeFindFile

    -- disable netrw at the very start of your init.lua (strongly advised)
    vim.g.loaded_netrw = 1 -- let g:loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1 -- let g:loaded_netrwPlugin = 1

    -- set termguicolors to enable highlight groups (already set)
    vim.o.termguicolors = true

    --{ Custom keymappings
        -- Function used for shortening declarations of keymappings in on_attach method

        -- Function which is run upon creating nvim-tree buffer
        local function on_attach(bufnr)
          local api = require("nvim-tree.api")

          local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          local function opts_no_desc()
            return { buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          -- put some default mappings here
          vim.keymap.set('n', '?',          api.tree.toggle_help,                  opts('Help'))
          vim.keymap.set('n', 'q',          api.tree.close,                        opts('Close'))
          vim.keymap.set('n', '<CR>',       api.node.open.edit,                    opts('Open [zo]'))
          vim.keymap.set('n', 'zo',         api.node.open.edit,                    opts_no_desc())
          vim.keymap.set('n', 'zc',         api.node.navigate.parent_close,        opts('Close Directory'))
          vim.keymap.set('n', 'rt',         api.node.open.tab,                     opts('Open: New Tab'))
          vim.keymap.set('n', 'ry',         api.node.open.vertical,                opts('Open: Vertical Split'))
          vim.keymap.set('n', 'rx',         api.node.open.horizontal,              opts('Open: Horizontal Split'))
          vim.keymap.set('n', 'rp',         api.node.open.preview,                 opts('Open Preview'))
          vim.keymap.set('n', 'yy',         api.fs.copy.node,                      opts('Copy'))
          vim.keymap.set('n', 'a',          api.fs.rename,                         opts('Rename Filename (Append)'))
          vim.keymap.set('n', 'Af',         api.fs.rename_sub,                     opts('Rename Filename'))
          vim.keymap.set('n', 'Ab',         api.fs.rename_basename,                opts('Rename Basename'))
          vim.keymap.set('n', 'p',          Print_node_path,                       opts('Print path'))
          vim.keymap.set('n', 'yn',         api.fs.copy.filename,                  opts('Copy Name'))
          vim.keymap.set('n', 'yp',         api.fs.copy.absolute_path,             opts('Copy Absolute Path'))
          vim.keymap.set('n', 'YP',         api.fs.copy.relative_path,             opts('Copy Relative Path'))
          vim.keymap.set('n', 'zh',         api.tree.toggle_hidden_filter,         opts('Toggle Hidden [<C-h>]'))
          vim.keymap.set('n', '<C-h>',      api.tree.toggle_hidden_filter,         opts_no_desc())
          vim.keymap.set('n', 'pp',         api.fs.paste,                          opts('Paste'))
          vim.keymap.set('n', 'dd',         api.fs.cut,                            opts('Cut'))
          vim.keymap.set('n', 'dD',         api.fs.remove,                         opts('Delete'))
          vim.keymap.set('n', 'DD',         api.fs.trash,                          opts('Trash'))
          vim.keymap.set('n', 'cd',         api.tree.change_root_to_node,          opts('Change Directory'))
          vim.keymap.set('n', 'i',          api.node.show_info_popup,              opts('Info'))
          vim.keymap.set('n', '<C-n>',      api.node.navigate.sibling.next,        opts('Next Sibling'))
          vim.keymap.set('n', '<C-p>',      api.node.navigate.sibling.prev,        opts('Previous Sibling'))
          vim.keymap.set('n', 'J',          api.node.navigate.sibling.last,        opts('Last Sibling'))  -- ??
          vim.keymap.set('n', 'K',          api.node.navigate.sibling.first,       opts('First Sibling')) -- ??
          vim.keymap.set('n', ':',          api.node.run.cmd,                      opts('Run Command'))
          vim.keymap.set('n', 'm',          api.marks.toggle,                      opts('Toggle Bookmark'))
          vim.keymap.set('n', 'M',          api.marks.bulk.move,                   opts('Move Bookmarked'))

          vim.keymap.set('n', 'f',          api.live_filter.start,                 opts('Filter'))
          vim.keymap.set('n', 'F',          api.live_filter.clear,                 opts('Clean Filter'))
          vim.keymap.set('n', 'c',          api.fs.create,                         opts('Create'))
          vim.keymap.set('n', 'R',          api.tree.reload,                       opts('Refresh'))
          vim.keymap.set('n', 'S',          api.tree.search_node,                  opts('Search'))
          vim.keymap.set('n', 'cr',         api.tree.change_root_to_parent,        opts('Up'))
          vim.keymap.set('n', 'B',          api.tree.toggle_no_buffer_filter,      opts('Toggle No Buffer'))
          vim.keymap.set('n', 'H',          api.node.navigate.parent,              opts('Parent Directory'))
          vim.keymap.set('n', 's',          api.node.run.system,                   opts('Run System'))
          vim.keymap.set('n', 'U',          api.tree.toggle_custom_filter,         opts('Toggle Hidden'))
          vim.keymap.set('n', 'W',          api.tree.collapse_all,                 opts('Collapse'))
          --vim.keymap.set('n', 'C',     api.tree.toggle_git_clean_filter,      opts('Toggle Git Clean'))
          --vim.keymap.set('n', '[c',    api.node.navigate.git.prev,            opts('Prev Git'))
          --vim.keymap.set('n', ']c',    api.node.navigate.git.next,            opts('Next Git'))
          --vim.keymap.set('n', 'I',     api.tree.toggle_gitignore_filter,      opts('Toggle Git Ignore'))
          --vim.keymap.set('n', 'E',     api.tree.expand_all,                   opts('Expand All'))
          --vim.keymap.set('n', ']e',    api.node.navigate.diagnostics.next,    opts('Next Diagnostic'))
          --vim.keymap.set('n', '[e',    api.node.navigate.diagnostics.prev,    opts('Prev Diagnostic'))

          --vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer,     opts('Open: In Place'))

          vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,           opts('Open'))
          vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
        end

        -- Function used to print path of the directory/file
        function Print_node_path()
          local api = require("nvim-tree.api")
          local node = api.tree.get_node_under_cursor()
          print(node.absolute_path)
        end
    --} Custom keymappings

    require("nvim-tree").setup({
      on_attach = on_attach, -- required for custom keybindings
      sort_by = "case_sensitive",
      hijack_netrw = false,
      view = {
        width = 40,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    })
    vim.keymap.set('n', '<leader>E', ":NvimTreeToggle<CR>")     -- nmap <leader>t :NvimTreeToggle<CR>
    vim.keymap.set('n', '<leader>T', ":NvimTreeFindFile<CR>")   -- nmap <leader>T :NvimTreeFindFile<CR> --TODO: Why it's not working?

--}}} TREE FILE EXPLORER
--{ STATUSLINE:               LUALINE

    require('lualine').setup {
        options = { theme  = 'onedark',
        component_separators = { left = '/', right = '\\'},
        section_separators = { left = '🭛', right = '🭦'}, -- 🭛🭋 🭀🭦 | 🭡🭅 🭐🭖
    },
        sections = {
            lualine_a = {
                {
                    'mode',
                    fmt = nil, -- Can be used to change text INSERT/NORMAL to something else
		    }
	        },
            lualine_b = {
                {
                    'diagnostics',
                    symbols = { error = "🛇 ", warn = "⚠️⚠", hint = "󰌶 ", info = "🛈 " }
                }
            },
            lualine_c = {
                {
                    'filename',
                    file_status = true,     -- Displays file status (readonly status, modified status)
                    symbols = {
                        modified = '●',     -- Text to show when the file is modified.
                        readonly = '🛇 ',    -- Text to show when the file is non-modifiable or readonly.
                        unnamed = '➖',     -- Text to show for unnamed buffers.
                        newfile = '[New]',  -- Text to show for newly created file before first write
                    }
                }
            },
        },
        inactive_sections = {
            lualine_c = {
                {
                    'filename',
                    file_status = true,     -- Displays file status (readonly status, modified status)
                    symbols = {
                        modified = '●',     -- Text to show when the file is modified.
                        readonly = '🛇 ',    -- Text to show when the file is non-modifiable or readonly.
                        unnamed = '➖',     -- Text to show for unnamed buffers.
                        newfile = '[New]',  -- Text to show for newly created file before first write
                    }
                }
            },
            lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
        },
        tabline = {},
         -- lualine_a = {},
         -- lualine_b = {
         --     {
         --         'tabs',
         --         max_length = vim.o.columns, -- Maximum width of tabs component.
         --         -- Note:
         --         -- It can also be a function that returns
         --         -- the value of `max_length` dynamically.
         --         mode = 1, -- 0: Shows tab_nr
         --         -- 1: Shows tab_name
         --         -- 2: Shows tab_nr + tab_name

         --      -- -- Automatically updates active tab color to match color of other components (will be overidden if buffers_color is set)
         --      -- use_mode_colors = false,

         --      -- tabs_color = {
         --      --     -- Same values as the general color option can be used here.
         --      --     active = 'lualine_{section}_normal',     -- Color for active tab.
         --      --     inactive = 'lualine_{section}_inactive', -- Color for inactive tab.
         --      -- },

         --         fmt = function(name, context)
         --             -- Show + if buffer is modified in tab
         --             local buflist = vim.fn.tabpagebuflist(context.tabnr)
         --             local winnr = vim.fn.tabpagewinnr(context.tabnr)
         --             local bufnr = buflist[winnr]
         --             local mod = vim.fn.getbufvar(bufnr, '&mod')

         --             return name .. (mod == 1 and ' ●' or '')
         --         end
         --     }
         -- },
         -- lualine_c = {},
         -- lualine_x = {},
         -- lualine_y = {},
         -- lualine_z = {}
         -- },
        }

--} STATUSLINE
--{ COLORSCHEME:              ONEDARKPRO (COLORSCHEME)
--
    --local color = require("onedarkpro.helpers")
    --local colors = color.get_colors()

    require("onedarkpro").setup({
    colors = {
        onedark = {
            bg = "#121212" -- grey
            },
        onedark_vivid = {
            --highlight = "#caca00",
            selection = "#555500",
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
    vim.cmd("colorscheme onedark_vivid")

--} COLORSCHEME
--{ COLORSCHEME:              JELLYBEANS.NVIM (COLORSCHEME)

    --vim.cmd('colorscheme jellybeans-nvim')

--} COLORSCHEME
--{ SYNTAX HIGHLIGHTING:      TREESITTER
    require'nvim-treesitter.configs'.setup
    {
        -- A list of parser names, or "all"
        ensure_installed = { "c", "vim", "lua", "c_sharp", "python", "bash", "commonlisp"},

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
--} SYNTAX HIGHLIGHTING
--{ FUZZY FINDER:             FZF.vim:          <l>fb = Buffers, <l>ff = Files, <l>fg = GFiles, <l>fm = Marks

    --vim.keymap.set({ 'n' }, '<leader>fb', ':Buffers<CR>', { remap = false }) -- nnoremap <leader>fb :Buffers<CR>
    --vim.keymap.set({ 'n' }, '<leader>ff', ':Files<CR>',   { remap = false }) -- nnoremap <leader>ff :Files<CR>
    --vim.keymap.set({ 'n' }, '<leader>fg', ':GFiles<CR>',  { remap = false }) -- nnoremap <leader>fg :GFiles<CR>
    --vim.keymap.set({ 'n' }, '<leader>fm', ':Marks<CR>',   { remap = false }) -- nnoremap <leader>fm :Marks<CR>

--}}} FUZZY FINDER
--{ TELESCOPE.NVIM

     -- -- Alternative version using current_buffer_fuzzy_find
     -- function searchToLocList()
     --     local search_string = vim.api.nvim_exec("echo getreg('/')", true):gsub("\\<", ""):gsub("\\>", "")
     --     require('telescope.builtin').current_buffer_fuzzy_find({
     --         default_text = search_string,
     --         initial_mode='normal'})
     -- end

    -- Move current search results to location list
    local function searchToLocList()
        vim.cmd("vimgrep // %")
        require('telescope.builtin').quickfix({
          sorting_strategy='ascending',
          initial_mode='normal'})
    end

    vim.keymap.set('n', telescopeLeader .. 'n', function() searchToLocList() end, { remap = false })

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', telescopeLeader .. '\'', builtin.resume,                    {})  -- Resume last window
    vim.keymap.set('n', telescopeLeader .. 'f',  builtin.live_grep,                 {})  -- Find inside files in cwd
    vim.keymap.set('n', telescopeLeader .. 'F',  builtin.find_files,                {})  -- Find files in cwd
    vim.keymap.set('n', telescopeLeader .. 'g',  builtin.git_files,                 {})  -- Find inside GIT tracked files in cwd
    vim.keymap.set('n', telescopeLeader .. '*',  builtin.grep_string,               {})  -- Find word under cursor inside files in cwd
    vim.keymap.set('n', telescopeLeader .. 'b',  builtin.buffers,                   {})  -- Buffers
    vim.keymap.set('n', telescopeLeader .. 'h',  builtin.help_tags,                 {})  -- Help tags
    vim.keymap.set('n', telescopeLeader .. 'm',  builtin.marks,                     {})  -- Marks
    vim.keymap.set('n', telescopeLeader .. 'o',  builtin.vim_options,               {})  -- Options
    vim.keymap.set('n', telescopeLeader .. '/',  builtin.current_buffer_fuzzy_find, {})  -- Find inside buffer
    vim.keymap.set('n', telescopeLeader .. 'q',  builtin.quickfix,                  {})  -- Quickfix list
    vim.keymap.set('n', telescopeLeader .. 'j',  builtin.jumplist,                  {})  -- Quickfix list
    vim.keymap.set('n', telescopeLeader .. 'r',  builtin.oldfiles,                  {})  -- Resume file editing
    vim.keymap.set('n', telescopeLeader .. 't',  require('telescope-tabs').list_tabs,       {})
    vim.keymap.set('n', '<C-p>',                 require('telescope-tabs').go_to_previous,  {})
    -- vim.keymap.set('n', telescopeLeader .. 'S',  builtin.<SessionManagerLoadSession>, {})    -- Sessioons
    -- LSP related TODO
    vim.keymap.set('n', telescopeLeader .. 'd',  builtin.diagnostics, {})    -- Diagnostics
    vim.keymap.set('n', telescopeLeader .. 's',  builtin.lsp_document_symbols, {})    -- Symbols

    -- vim.keymap.set('n', telescopeLeader .. '-',  builtin.lsp_references
    -- vim.keymap.set('n', telescopeLeader .. '-',  builtin.lsp_incoming_calls
    -- vim.keymap.set('n', telescopeLeader .. '-',  builtin.lsp_outgoing_calls
    -- vim.keymap.set('n', telescopeLeader .. 's',  builtin.lsp_document_symbols
    -- vim.keymap.set('n', telescopeLeader .. '-',  builtin.lsp_workspace_symbols
    -- vim.keymap.set('n', telescopeLeader .. '-',  builtin.lsp_dynamic_workspace_symbols
    -- vim.keymap.set('n', telescopeLeader .. '-',  builtin.diagnostics
    -- vim.keymap.set('n', telescopeLeader .. '-',  builtin.lsp_implementations
    -- vim.keymap.set('n', telescopeLeader .. 'd',  builtin.lsp_definitions
    -- vim.keymap.set('n', telescopeLeader .. '-',  builtin.lsp_type_definitions

    local actions = require('telescope.actions')

    require('telescope').setup{
      defaults = {
        mappings = {
          n = {
            ["<C-q>"] = actions.close,
            ["<C-f>"] = actions.open_qflist,
          },
          i = {
            ["<C-q>"] = actions.close,
            ["<C-f>"] = actions.open_qflist,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      }
    }

    local function launchTelescopeProjects()
        require'telescope'.extensions.project.project{
        --display_type = 'full',
        --prompt_title = 'Select a project',
        attach_mappings = function(prompt_bufnr, map)
            --map({ 'n', 'i'}, '<C-q>', { "<cmd>echo \"Hello, World!\"<cr>", type = "command" })
            return true
            end
        }
    end

    -- PLUGINS
    require'telescope'.load_extension('project')
    local ext = require'telescope'.extensions
    vim.keymap.set('n', telescopeLeader .. 'p', launchTelescopeProjects, {noremap = true, silent = true})

    require'telescope-tabs'.setup{}


--} TELESCOPE.NVIM
--{ FILE EXPLORER:            RNVIMR:           <l>e = RnvimrToggle, <l>re = RnvimrResize

    vim.keymap.set({ 'n' }, '<leader>e', ':RnvimrToggle<CR>', { remap = false, silent = true }) -- nnoremap <silent> <leader>e :RnvimrToggle<CR>
    vim.keymap.set({ 't' }, '<leader>e', '<C-\\><C-n>:RnvimrToggle<CR>', { remap = false, silent = true }) -- tnoremap <silent> <leader>e

    -- Resize floating window by all preset layouts
    vim.keymap.set({ 't' }, '<leader>r', '<C-\\><C-n>:RnvimrResize<CR>', { remap = false, silent = true }) -- tnoremap <silent> <leader>re <C-\><C-n>:RnvimrResize<CR>

--} FILE EXPLORER
--{ ADDITIONAL MOTION:        VIM-EASYMOTION:   <l>s = MoveToText

    -- Disable default mappings
    -- vim.g.Easymotion_do_mapping = 0 -- let g: = 0 TODO: Doesn't work - https://github.com/easymotion/vim-easymotion/issues/320
    -- vim.keymap.set('n', '<leader>j', '<Plug>(easymotion-overwin-f2)') -- nmap <leader>m <Plug>(easymotion-overwin-f2)

--} ADDITIONAL MOTION
--{ VIM-SNEAK

    vim.g["sneak#label"] = 1 -- Enable labels
    vim.g["sneak#target_labels"] = "ASDFGHJKL" -- Set labels - Why it doesn't work?

--} VIM-SNEAK
--{ LIGHTSPEED.NVIM
    --require'lightspeed'.setup {
--} LIGHTSPEED.NVIM
--{ PERSONAL WIKI:            WIKI.VIM:         <l>ww = OpenWiki

    -- Remap of wiki opening which also sets CWD to wiki root
    vim.keymap.set('n', '<leader>ww', '<Plug>(wiki-index):cd%:p:h<CR>', { silent = true }) -- nmap <silent> <leader>ww <Plug>(wiki-index):cd%:p:h<CR>
    -- TODO Add MyWiki directory creation command
    vim.g.wiki_root = '~/Documents/MyWiki/' -- let g:wiki_root = '~/Documents/MyWiki/'
    vim.g.wiki_filetypes = {'md'} -- let g:wiki_filetypes = ['md']
    vim.g.wiki_link_extension = '.md' -- let g:wiki_link_extension = '.md'
    vim.g.wiki_link_target_type= 'md' -- let g:wiki_link_target_type= 'md'

    vim.g.markdown_fenced_languages = { 'python', 'c', 'bash', 'go', 'vim', 'lua', 'html' } -- It doesn't use treesitter TODO: Search for better solution.

    vim.g.wiki_export = {
        args = '',
        from_format = 'markdown',
        ext = 'html',
        link_ext_replace = true,
        view = false,
        output = vim.fn.fnamemodify(vim.fn.tempname(), ':h'),
    }

    vim.api.nvim_create_augroup('MyWikiAutocmdsGroup', { clear = true })
    vim.api.nvim_create_autocmd('User WikiBufferInitialized',
                                { group = 'MyWikiAutocmdsGroup',
                                  callback = function()
                                    vim.keymap.set({ 'n', 'v', 'o' }, '<C-j>', '<plug>(wiki-link-next)', { remap = false, buffer = true })
                                    vim.keymap.set({ 'n', 'v', 'o' }, '<C-k>', '<plug>(wiki-link-prev)', { remap = false, buffer = true })
                                  end })

    vim.api.nvim_create_autocmd( -- autocmd FileType markdown set textwidth=120 colorcolumn=121 nowrap
        { 'FileType' },
        { pattern = { 'markdown' },
          callback = function()
              vim.o.textwidth = 102
              vim.o.colorcolumn = "103"
              vim.o.wrap = false
              vim.o.foldlevel = 1
              end
        })

--} PERSONAL WIKI
--{ PASTE IMAGES IN MARKDOWN: IMG-PASTE:        <l>p = MarkdownClipboardImage

    vim.api.nvim_create_autocmd(
        { 'FileType' },
        {
            pattern = { 'markdown' },
            callback = function() vim.keymap.set('n', '<leader>P', ':call mdip#MarkdownClipboardImage()<cr>', { silent = true }) end
        }) -- autocmd filetype markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<cr>
    vim.g.mdip_imgdir_absolute = '~/Documents/MyWiki/img' -- let g:mdip_imgdir_absolute = '~/Documents/MyWiki/img'

--} IMG-PASTE
--{ VIEW IMAGES IN MARKDOWN:  HOLOGRAM.NVIM

    require('hologram').setup{
        auto_display = false -- WIP automatic markdown image display, may be prone to breaking
    }

--}
--{ SCROLLBAR                 NVIM-SCROLLVIEW

    vim.cmd('highlight ScrollView                 guibg=Grey')
    vim.cmd('highlight ScrollViewCursor           guifg=White')
    vim.cmd('highlight ScrollViewSearch           guifg=Yellow')
    --vim.cmd('highlight ScrollViewMarks          guibg=Blue guifg=Red')

    vim.cmd('highlight ScrollViewDiagnosticsError guifg=Red')
    vim.cmd('highlight ScrollViewDiagnosticsHint  guifg=White')
    vim.cmd('highlight ScrollViewDiagnosticsInfo  guifg=LightBlue')
    vim.cmd('highlight ScrollViewDiagnosticsWarn  guifg=Orange')

    require('scrollview').setup({
        excluded_filetypes = {'nerdtree'},
        always_show = true,
        cursor_symbol = '▪',
        search_symbol = '🭹',
        diagnostics_error_symbol = '🭹',
        diagnostics_hint_symbol = '🭹',
        diagnostics_info_symbol = '🭹',
        diagnostics_warn_symbol = '🭹',
        column = 1,
        signs_on_startup = {
            'cursor',
            'search',
            --'marks',
            'diagnostics',
            'conflicts',
        },
    })

--} SCROLLBAR
--{ SEARCHLIGHT
    vim.cmd('highlight Searchlight guibg=\'#caca00\' guifg=\'#000000\'')

--} SEARCHLIGHT
--{ LITEE.LIB

    -- configure the litee.nvim library
    require('litee.lib').setup({
        tree = {
            icon_set = "codicons"
        },
        panel = {
            orientation = "right",
            panel_size  = 50
        } })

    -- configure litee-calltree.nvim
    require('litee.calltree').setup({
        resolve_symbols = true,
        jump_mode = "invoking",
        map_resize_keys = true,
    })

    function ToggleHierarchy()
        -- TODO: add toggle function which when
        --  * disabling will jump to calltree window use "gg" and call LTHideCalltree
        --  * enabling call LTOpenToCalltree
        vim.cmd("LTCloseCalltree")
    end
    vim.keymap.set("n", "<leader>h", ToggleHierarchy, {})
    vim.cmd(([[
        autocmd Filetype calltree lua vim.api.nvim_set_keymap("n", "q",         ":LTHideCalltree<CR>", {})
        autocmd Filetype calltree lua vim.api.nvim_set_keymap("n", "<leader>h", ":LTHideCalltree<CR>", {})
        ]]))

--} LITEE.LIB
--{ VIM-MARK
--
--let g:mwDefaultHighlightingPalette = 'extended'   -- extended palette
--To enable(1) or disable(0) the automatic restore of marks from a previous Vim session:
    --let g:mwAutoLoadMarks = 1
--If you want no or only a few of the available mappings, you can completely turn off the creation of the default mappings by defining:
    --:let g:mw_no_mappings = 1
--By default, any marked words are also added to the search (/) and input (@) history; if you don't want that, remove the corresponding symbols from:
    --let g:mwHistAdd = '/@'
--By default, tab pages / windows / buffers that have t:nomarks / w:nomarks / b:nomarks with a true value are excluded. Therefore, to suppress mark highlighting in a buffer, you can simply
    --:let b:nomarks = 1
--There are no default mappings for toggling all marks and for the :MarkClear command, but you can define some yourself:
    --nmap <Leader>M <Plug>MarkToggle
    --nmap <Leader>N <Plug>MarkAllClear
    --
--If you want the * and # mappings to search for the next occurrence of any mark with fallback to *:
    --nmap * <Plug>MarkSearchOrAnyNext
    --nmap # <Plug>MarkSearchOrAnyPrev

--} VIM-MARK
--{ NEOVIM-SESSION-MANAGER

    local Path = require('plenary.path')
    local smconfig = require('session_manager.config')
    require('session_manager').setup({
      sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
      --session_filename_to_dir = session_filename_to_dir, -- Function that replaces symbols into separators and colons to transform filename into a session directory.
      --dir_to_session_filename = dir_to_session_filename, -- Function that replaces separators and colons into special symbols to transform session directory into a filename. Should use `vim.loop.cwd()` if the passed `dir` is `nil`.
      autoload_mode = smconfig.AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
      autosave_last_session = true, -- Automatically save last session on exit and on session switch.
      autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
      autosave_ignore_dirs = {}, -- A list of directories where the session will not be autosaved.
      autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
        'gitcommit',
        'gitrebase',
      },
      autosave_ignore_buftypes = {}, -- All buffers of these bufer types will be closed before the session is saved.
      autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
      max_path_length = 80,  -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
    })
-- load_session 	            Select and load session.
-- load_last_session 	        Will remove all buffers and :source the last saved session.
-- load_current_dir_session 	Will remove all buffers and :source the last saved session file of the current dirtectory.
-- save_current_session 	    Works like :mksession, but saves/creates current directory as a session in sessions_dir.
-- delete_session 	            Select and delete session.

--} NEOVIM-SESSION-MANAGER
--{ TABLINE BUFFERLINE.NVIM

    vim.o.mousemoveevent = true

    local color_background = '#121212'
    local color_inactive_tab = '#22262D'
    local color_active_tab = '#3d4350'
    vim.cmd('highlight NvimTreeTitle guibg=' .. color_inactive_tab)


    local bufferline = require('bufferline')
    bufferline.setup {
        options = {
            mode = "tabs",
            themable = true,
            middle_mouse_command = "bdelete! %d",
            indicator = {
                --icon = '▎', -- this should be omitted if indicator style is not 'icon'
                style = 'none',
            },
            left_trunc_marker  = '🡄',--←
            right_trunc_marker = '🡆',--→
            max_name_length = 50,
            -- max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
            truncate_names = true,     -- whether or not tab names should be truncated
            tab_size = 5,
            diagnostics = "nvim_lsp",
            diagnostics_update_in_insert = false,
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local diag_suffix = " "
                local error_count = diagnostics_dict["error"]
                local warning_count = diagnostics_dict["warning"]
                if error_count ~= nil and error_count > 0 then
                    diag_suffix = " " .. error_count   .. "🛇 "
                elseif warning_count ~= nil and warning_count > 0 then
                    diag_suffix = " " .. warning_count .. "⚠️🛇"
                end
                return diag_suffix
            end,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "center",
                    highlight = "NvimTreeTitle",
                    separator = true
                }
            },
            show_close_icon = false,
            show_buffer_close_icons = false,
            always_show_bufferline = false,
            separator_style = "slope",
            show_duplicate_prefix = true,
        },
        highlights = {
            fill = {
                bg = color_background,
            },
            background = {
                bg = color_inactive_tab,
            },
            separator_selected = {
                fg = color_background,
                bg = color_active_tab,
            },
            separator = {
                fg = color_background,
                bg = color_inactive_tab,
            },
            buffer_selected = {
                bg = color_active_tab,
            },
            modified = {
                bg = color_inactive_tab,
            },
            modified_selected = {
                bg = color_active_tab,
            },
            duplicate = {
                bg = color_inactive_tab,
            },
            duplicate_selected = {
                bg = color_active_tab,
            },
            hint = {
                bg = color_inactive_tab,
            },
            hint_selected = {
                bg = color_active_tab,
            },
            hint_diagnostic = {
                bg = color_inactive_tab,
            },
            hint_diagnostic_selected = {
                bg = color_active_tab,
            },
            info = {
                bg = color_inactive_tab,
            },
            info_selected = {
                bg = color_active_tab,
            },
            info_diagnostic = {
                bg = color_inactive_tab,
            },
            info_diagnostic_selected = {
                bg = color_active_tab,
            },
            warning = {
                bg = color_inactive_tab,
            },
            warning_selected = {
                bg = color_active_tab,
            },
            warning_diagnostic = {
                bg = color_inactive_tab,
            },
            warning_diagnostic_selected = {
                bg = color_active_tab,
            },
            error = {
                bg = color_inactive_tab,
            },
            error_selected = {
                bg = color_active_tab,
            },
            error_diagnostic = {
                bg = color_inactive_tab,
            },
            error_diagnostic_selected = {
                bg = color_active_tab,
            },
            indicator_selected = {
                bg = color_active_tab,
            },
            trunc_marker = {
                fg = color_active_tab,
                bg = color_background,
            },
            offset_separator = {
                bg = color_background,
            },
        }
    }
    -- * color of background for NvimTree

    local tabLeader = '<tab>'

   vim.keymap.set('n', tabLeader  ..  '<tab>'  , ':BufferLinePick<CR>'     , {})
   vim.keymap.set('n', tabLeader  ..  'd'    , ':BufferLinePickClose<CR>', {})
   vim.keymap.set('n', tabLeader  ..  'q'    , ':tabclose<CR>'           , {})
   vim.keymap.set('n', tabLeader  ..  'n'    , ':tabnew<CR> '            , {})
   vim.keymap.set('n', tabLeader  ..  'r'    , ':Rename<CR>'             , {})
   vim.keymap.set('n', tabLeader  ..  'l'    , ':tabmove +1<CR>'         , {})
   vim.keymap.set('n', tabLeader  ..  'h'    , ':tabmove -1<CR>'         , {})
   vim.keymap.set('n', tabLeader  ..  'L'    , ':tabmove   <CR>'         , {})
   vim.keymap.set('n', tabLeader  ..  'H'    , ':tabmove  0<CR>'         , {})
   vim.keymap.set('n', tabLeader  ..  'K'    , ':tablast<CR>'            , {})
   vim.keymap.set('n', tabLeader  ..  'J'    , ':tabfirst<CR>'           , {})
   vim.keymap.set('n', tabLeader  ..  'k'    , ':BufferLineCycleNext<CR>', {})
   vim.keymap.set('n', tabLeader  ..  'j'    , ':BufferLineCyclePrev<CR>', {})

   -- Ditto modified to allow holding Ctrl
   vim.keymap.set('n', tabLeader  ..  '<C-t>', ':BufferLinePick<CR>'     , {})
   vim.keymap.set('n', tabLeader  ..  '<C-d>', ':BufferLinePickClose<CR>', {})
   vim.keymap.set('n', tabLeader  ..  '<C-q>', ':tabclose<CR>'           , {})
   vim.keymap.set('n', tabLeader  ..  '<C-n>', ':tabnew<CR> '            , {})
   vim.keymap.set('n', tabLeader  ..  '<C-r>', ':Rename<CR>'             , {})
   vim.keymap.set('n', tabLeader  ..  '<C-l>', ':tabmove +1<CR>'         , {})
   vim.keymap.set('n', tabLeader  ..  '<C-h>', ':tabmove -1<CR>'         , {})
   vim.keymap.set('n', tabLeader  ..  '<C-L>', ':tabmove   <CR>'         , {})
   vim.keymap.set('n', tabLeader  ..  '<C-H>', ':tabmove  0<CR>'         , {})
   vim.keymap.set('n', tabLeader  ..  '<C-K>', ':tablast<CR>'            , {})
   vim.keymap.set('n', tabLeader  ..  '<C-J>', ':tabfirst<CR>'           , {})
   vim.keymap.set('n', tabLeader  ..  '<C-k>', ':BufferLineCycleNext<CR>', {})
   vim.keymap.set('n', tabLeader  ..  '<C-j>', ':BufferLineCyclePrev<CR>', {})

--} TABLINE BUFFERLINE.NVIM

--###################    DEVELOPMENT RELATED    #####################
--{ PROJECT-TEMPLATES

    -- Placeholders in templates (i.e. #{PLACEHOLDER}) can be used to customize template.
    -- When loading templete user will be prompted for values to replace them.
    -- TODO: Make LoadTemplate invoke project creation from telescope-project.nvim plugin
    --       May be useful: ":lua require'telescope'.extensions.project.project{}<CR>",
    vim.keymap.set('n', '<leader>tl', ':LoadTemplate<CR>',   { remap = false }) -- Load a template into a new project.
    vim.keymap.set('n', '<leader>td', ':DeleteTemplate<CR>', { remap = false }) -- Delete a template
    vim.keymap.set('n', '<leader>tc', ':SaveAsTemplate<CR>', { remap = false }) -- Save the current folder and all files and subfolders as a new template

--} PROJECT-TEMPLATES
    --{ OUTLINER:                 TAGBAR (C-tags based outliner):   <l>so = TagbarToggle

        vim.keymap.set({ 'n', 'v', 'o' }, 'go',  ':TagbarToggle<CR>', { remap = false }) -- noremap <leader>go :TagbarToggle<CR>

    --} OUTLINER
--{ AUTOCOMPLETION:           CMP-NVIM

    --{ ADD ADDITIONAL CAPABILITIES SUPPORTED BY NVIM-CMP
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
        local servers = { 'clangd', 'pyright', 'gopls'} -- 'pyright'
        local lspconfig = require('lspconfig')
        for _, lsp in ipairs(servers) do
          lspconfig[lsp].setup {
            -- on_attach = my_custom_on_attach,
            capabilities = capabilities,
          }
        end
    --}
    --{ NVIM-CMP SETUP, KEYMAPPINGS

        -- set autocomplete menu selection color
        vim.cmd('highlight PmenuSel guibg=\'#333333\'')

        local cmp = require('cmp')
        local luasnip = require('luasnip')
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-u>'] =     cmp.mapping.scroll_docs(-4), -- Up
                ['<C-d>'] =     cmp.mapping.scroll_docs(4),  -- Down
                ['<C-b>'] =     cmp.mapping.scroll_docs(-8), -- Up
                ['<C-f>'] =     cmp.mapping.scroll_docs(8),  -- Down
                ['<C-j>'] =     cmp.mapping.select_next_item(),
                ['<C-k>'] =     cmp.mapping.select_prev_item(),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] =     cmp.mapping.abort(),
                ['<C-CR>'] =    cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                },
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'nvim_lsp_signature_help' },
                { name = 'buffer' },
             -- { name = 'cmdline' }, -- TODO: Temporary solution to no completion in command line window. Fix or fill bug report.
            })
        })

        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
                { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            },
            {
                { name = 'buffer' },
            })
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            },
            {
                { name = 'cmdline' }
            })
        })

    --}

--} AUTOCOMPLETION
--{ LSP:                      MASON, MASON-LSPCONFIG:           <l>mm = Mason

    require("mason").setup()
    vim.keymap.set({ 'n' }, '<leader>mm', ':Mason<CR>')

    require("mason-lspconfig").setup( {
        -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
        -- This setting has no relation with the `automatic_installation` setting.
        ---@type string[]
        ensure_installed = { "clangd", },

        -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
        -- This setting has no relation with the `ensure_installed` setting.
        -- Can either be:
        --   - false: Servers are not automatically installed.
        --   - true: All servers set up via lspconfig are automatically installed.
        --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
        --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
        ---@type boolean
        automatic_installation = false,

        -- See `:h mason-lspconfig.setup_handlers()`
        ---@type table<string, fun(server_name: string)>?
        handlers = nil,
    } )

--} MASON, MASON-LSPCONFIG
--{ NEODEV.NVIM

    require("neodev").setup({
      -- add any options here, or leave empty to use the default settings
    })

--} NEODEV.NVIM
--{ LSPCONFIG

    -- LUA
        -- local lua_rtp = vim.split(package.path, ';')
        -- table.insert(lua_rtp, 'lua/?.lua')
        -- table.insert(lua_rtp, 'lua/?/init.lua')
    lspconfig.lua_ls.setup({
        settings = {
            Lua = {
 --             runtime = {
 --                 -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
 --                 version = 'LuaJIT',
 --                 -- Setup your lua path
 --                 path = lua_rtp,
 --             },
                completion = {
                    callSnippet = "Replace"
                },
 --             diagnostics = {
 --                 globals = { 'vim' }
 --             },
 --             workspace = {
 --                 -- Make the server aware of Neovim runtime files
 --                 library = vim.api.nvim_get_runtime_file('', true),
 --             },
 --             telemetry = {
 --                 -- Do not send telemetry data containing a randomized but unique identifier
 --                 enable = false,
 --             },
            }
        }
    })

    -- MARKDOWN
    require'lspconfig'.marksman.setup{}

    -- KEYBINDINGS
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<leader><space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<leader><space>q', vim.diagnostic.setloclist)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            local lspLeader = 'g'
            vim.keymap.set('n',                       'K',     vim.lsp.buf.hover,                   opts)
            vim.keymap.set('n',                       '<C-k>', vim.lsp.buf.definition,              opts)
            vim.keymap.set('n', lspLeader ..          'd',     vim.lsp.buf.declaration,             opts)
            vim.keymap.set('n', lspLeader ..          'D',     vim.lsp.buf.type_definition,         opts)
            vim.keymap.set('n', lspLeader ..          'k',     vim.lsp.buf.signature_help,          opts)
            vim.keymap.set('n', lspLeader ..          'i',     vim.lsp.buf.implementation,          opts)
            vim.keymap.set('n', lspLeader ..          'r',     vim.lsp.buf.references,              opts)
            vim.keymap.set('n', lspLeader ..          'h',     vim.lsp.buf.incoming_calls,          opts)
            vim.keymap.set('n', lspLeader ..          'H',     vim.lsp.buf.outgoing_calls,          opts)
            vim.keymap.set('n', lspLeader ..          's',     vim.lsp.buf.document_symbol,         opts)
            vim.keymap.set('n', lspLeader ..          'n',     vim.lsp.buf.rename,                  opts)
            vim.keymap.set('n', lspLeader ..          'wa',    vim.lsp.buf.add_workspace_folder,    opts)
            vim.keymap.set('n', lspLeader ..          'wr',    vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', lspLeader ..          'ws',    vim.lsp.buf.workspace_symbol,        opts)
            vim.keymap.set('n', lspLeader ..          'wl',    function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))                       end, opts)
            vim.keymap.set('n', lspLeader ..          'F',     function()
                vim.lsp.buf.format { async = true }                                            end, opts)
            vim.keymap.set({ 'n', 'v' }, lspLeader .. 'c',vim.lsp.buf.code_action,                  opts)
            end,
        })
    --
--}
--{ SNIPPETS:                 LUASNIP

    require('luasnip').setup()

--} SNIPPETS
--{ DAP

    require ('mason-nvim-dap').setup({
        ensure_installed = { 'codelldb' },
        handlers = {
            function(config)
                -- all sources with no handler get passed here

                -- Keep original functionality
                require('mason-nvim-dap').default_setup(config)
            end,
            codelldb = function(config)
                config.configurations = {
                {
                    name = 'LLDB: Launch',
                    type = 'codelldb',
                    request = 'launch',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    args = function()
                        local argument_string = vim.fn.input('Program arguments: ')
                        return vim.fn.split(argument_string, " ", true)
                    end,
                },
            }

                require('mason-nvim-dap').default_setup(config)
            end,
        },
    })

    local opt = { remap = false, silent = true }
    local dap = require('dap')

    vim.keymap.set({ 'n' }, debugLeader .. 'p', function() dap.toggle_breakpoint() end, opt)                                            -- nnoremap <silent><leader>db <cmd>lua require('dap').toggle_breakpoint()<CR>
    vim.keymap.set({ 'n' }, debugLeader .. 'L', function() dap.list_breakpoints()  end, opt)                                            -- nnoremap <silent><leader>dBl <Cmd>lua require('dap').list_breakpoints()<CR>
    vim.keymap.set({ 'n' }, debugLeader .. 'C', function() dap.clear_breakpoints() end, opt)                                            -- nnoremap <silent><leader>dBc <Cmd>lua require('dap').clear_breakpoints()<CR>
    vim.keymap.set({ 'n' }, debugLeader .. 'f', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))        end, opt)  -- nnoremap <silent><leader>dBC <Cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>

    vim.keymap.set({ 'n' }, debugLeader .. 'l', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, opt)
    vim.keymap.set({ 'n' }, debugLeader .. 'c', function() dap.continue()          end, opt)
    vim.keymap.set({ 'n' }, debugLeader .. 'B', function() dap.reverse_continue()  end, opt)
    vim.keymap.set({ 'n' }, debugLeader .. 'r', function() dap.run_last()          end, opt)
    vim.keymap.set({ 'n' }, debugLeader .. 'R', function() dap.restart()           end, opt)
    vim.keymap.set({ 'n' }, debugLeader .. 'q', function() dap.terminate()         end, opt)
    vim.keymap.set({ 'n' }, debugLeader .. 'Q', function() dap.disconnect()        end, opt)
    vim.keymap.set({ 'n' }, debugLeader .. 's', function() dap.step_over()         end, opt)
    vim.keymap.set({ 'n' }, debugLeader .. 'b', function() dap.step_back()         end, opt)
    vim.keymap.set({ 'n' }, debugLeader .. 'i', function() dap.step_into()         end, opt)
    vim.keymap.set({ 'n' }, debugLeader .. 'o', function() dap.step_out()          end, opt)
    vim.keymap.set({ 'n' }, debugLeader .. 'u', function() dap.up()                end, opt)
    vim.keymap.set({ 'n' }, debugLeader .. 'd', function() dap.down()              end, opt)
    vim.keymap.set({ 'n' }, debugLeader .. 't', function() dap.repl.toggle()       end, opt)

--} DAP
--{ DAP-UI
    --{
    --  vim.api.nvim_create_augroup('UserDefLoadOnce', {})
    --  vim.api.nvim_set_hl(0, 'UserDefLoadOnce', {})
    --  vim.api.nvim_create_autocmd("ColorScheme", {
    --  pattern = "*",
    --  group = "UserDefLoadOnce",
    --  desc = "prevent colorscheme clears self-defined DAP icon colors.",
    --  callback = function()
    --      vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939' })
    --      vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef' })
    --      vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379' })
    --  end
    --  })
    --}

    vim.api.nvim_set_hl(0, 'DapBreakpoint',          { ctermbg = 0, fg = '#993333' })
    vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { ctermbg = 0, fg = '#993333' })
    vim.api.nvim_set_hl(0, 'DapBreakpointRejected',  { ctermbg = 0, fg = '#993333' })
    vim.api.nvim_set_hl(0, 'DapLogPoint',            { ctermbg = 0, fg = '#61afef' })
    vim.api.nvim_set_hl(0, 'DapStopped',             { ctermbg = 0, fg = '#339933' })

    vim.fn.sign_define('DapBreakpoint',              { text='🟠', texthl='DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointCondition',     { text='⦾ ', texthl='DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointRejected',      { text='🞅 ', texthl='DapBreakpoint' })
    vim.fn.sign_define('DapLogPoint',                { text='⯁ ', texthl='DapLogPoint' })
    vim.fn.sign_define('DapStopped',                 { text='⫸ ', texthl='DapStopped' })


    -- Default UI keybindings:
    --    edit:   e
    --    expand: <CR> or left click
    --    open:   o
    --    remove: d
    --    repl:   r
    --    toggle: t
    --  Help:   :h dapui.setup() for configuration options and defaults.
    local dapui = require('dapui')
    dapui.setup()
    vim.keymap.set({ 'n' },      debugLeader .. 'd', function() dapui.toggle()      end,  opt)
    vim.keymap.set({ 'n', 'v' }, debugLeader .. 'D', function() dapui.open()        end,  opt)
    vim.keymap.set({ 'n', 'v' }, debugLeader .. 'e', function() dapui.eval()        end,  opt)

    local widgets = require('dap.ui.widgets')
    vim.keymap.set({'n', 'v'},   debugLeader .. 'H', function() widgets.hover()     end,  opt)
    vim.keymap.set({'n', 'v'},   debugLeader .. 'P', function() widgets.preview()   end,  opt)
    --TODO: fix stupid quit with ZZ for both widgets below
    vim.keymap.set('n',          debugLeader .. 'F', function() widgets.centered_float(widgets.frames) end,  opt)
    vim.keymap.set('n',          debugLeader .. 'S', function() widgets.centered_float(widgets.scopes) end, opt)

--} DAP-UI
--{ SYMBOL COLUMN - DIAGNOSTICS UI

    local signs = { Error = "🛇 ", Warn = "⚠️⚠", Hint = "󰌶 ", Info = "🛈 " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

--} DIAGNOSTICS

--###################    OTHER    #####################
--{ VIMSCRIPT

local vimrc = vim.fn.stdpath("config") .. "/config.vim"
vim.cmd.source(vimrc)

--} VIMRSCRIPT


--###################    OLD CONFIGS    #####################
--{ C# LSP-alternative:       OMNISHARP
--[[
    vim.g.OmniSharp_selector_ui = "fzf" -- let g:OmniSharp_selector_ui = 'fzf'
    vim.keymap.set('n', 'K', ':OmniSharpDocumentation<CR>') -- nmap K :OmniSharpDocumentation<CR>
    vim.keymap.set('n', '<C-k>', ':OmniSharpGotoDefinition<CR>') -- nmap <C-k> :OmniSharpGotoDefinition<CR>
--]]
--} C# LSP-alternative
--{ VSCODE COMP LAYER(LSP):   COC.NVIM
--[[
     -- List of extansions for coc.nvim to be installed automatically
    require('coc-init')
    vim.g.coc_global_extensions = {'coc-sh', 'coc-cmake', 'coc-html', 'coc-json', 'coc-phpls', 'coc-pyright', 'coc-tsserver'} -- let g:coc_global_extensions=[ 'coc-sh', 'coc-pyright' ]

    local disableExCommandLine = function()
        if (string.match(vim.api.nvim_buf_get_name(0), "CocTree%d")) then
            vim.api.nvim_buf_set_keymap(0, "n", ":", ":", {silent = true, noremap = true})
        end
    end
    vim.api.nvim_create_autocmd( {"BufEnter"}, {callback = disableExCommandLine} )
--]]
--} VSCode compatibility layer, LSP
--{ NULL-LS
    --  local null_ls = require("null-ls")
    --  null_ls.setup({
    --      sources = {
    --          null_ls.builtins.completion.luasnip, },     -- TODO: configure luasnip
    --      })
--} NULL-LS

-- vim: foldmethod=marker foldmarker=--{,--} textwidth=120 colorcolumn=121 nowrap


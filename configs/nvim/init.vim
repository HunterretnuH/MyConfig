" vim: foldmethod=marker textwidth=120 colorcolumn=121

" GENERAL CONFIG
"--{{{ PLUGIN MANAGER - packer.nvim
lua << EOF
    require('plugins') -- ~/.config/nvim/lua/plugins.lua
EOF
"--}}} PLUGIN MANAGER
"--{{{ OPTIONS
lua << EOF
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
--}}} OPTIONS
--{{{ BASIC KEYMAPPINGS
    vim.g.mapleader = ' '                     -- let mapleader = "\<Space>"

    vim.keymap.set({ 'n', 'v', 'o' }, ':',  'q:i', { remap = false }) -- noremap : q:i
    vim.keymap.set({ 'n', 'v', 'o' }, '/',  'q/i', { remap = false }) -- noremap / q/i
    vim.keymap.set({ 'n', 'v', 'o' }, '?',  'q?i', { remap = false }) -- noremap ? q?i
    vim.keymap.set({ 'n', 'v', 'o' }, 'q:', ':',   { remap = false }) -- noremap q: :
    vim.keymap.set({ 'n', 'v', 'o' }, 'q/', '/',   { remap = false }) -- noremap q/ /
    vim.keymap.set({ 'n', 'v', 'o' }, 'q?', '?',   { remap = false }) -- noremap q? ?

    function removeSomeKeyMappingsInCmdLineWin()
        vim.keymap.set({ 'n', 'v', 'o' }, ':', ':',   { remap = false, buffer = true }) -- noremap <silent> : : 
        vim.keymap.set({ 'n', 'v', 'o' }, '/', '/',   { remap = false, buffer = true }) -- noremap <silent> / / 
        vim.keymap.set({ 'n', 'v', 'o' }, '?', '?',   { remap = false, buffer = true }) -- noremap <silent> ? ? 
        vim.keymap.set({ 'n', 'v', 'o' }, 'q:', 'q:', { remap = false, buffer = true }) -- noremap <silent> q: q: 
        vim.keymap.set({ 'n', 'v', 'o' }, 'q/', 'q/', { remap = false, buffer = true }) -- noremap <silent> q/ q/ 
        vim.keymap.set({ 'n', 'v', 'o' }, 'q?', 'q?', { remap = false, buffer = true }) -- noremap <silent> q? q? 
    end
    vim.api.nvim_create_autocmd( {"CmdwinEnter"}, { callback = removeSomeKeyMappingsInCmdLineWin} )
--}}} BASIC KEYMAPPINGS
--{{{ ADDITIONAL KEYMAPPINGS: <l>p = VisSelRepl, <l>cd = ChDirToCurrFileLoc, <l>dw = RmEOLNewLine, <l>dW = RmEOLCarrRet
    -- Replace visual selection with clipboard content, but don't yank selected text to clipboard
    vim.keymap.set('v', '<leader>p', '_dP', { remap = false, silent = true }) -- vnoremap <silent> <leader>p "_dP

    -- Change current working directory to currently opened file location.
    vim.keymap.set({ 'n' }, '<leader>cd', ':cd%:p:h<CR>', { remap = false }) -- nnoremap <leader>cd :cd%:p:h<CR>

    -- Regex to clear whitespaces at the EOL in whole buffer
    vim.keymap.set({ 'n' }, '<leader>dw', ':%s/\\s\\+$//<CR>:noh<CR>', { remap = false }) -- noremap <leader>dw :%s/\s\+$//<CR>:noh<CR>

    -- Regex to clear all carriage returns at the EOL in whole buffer
    vim.keymap.set({ 'n', 'v', 'o' }, '<leader>dm',  ':%s/\\r//g<CR>:noh<CR>', { remap = false }) -- noremap <leader>dm :%s/\r//g<CR>:noh<CR>
EOF
"--}}} ADDITIONAL KEYMAPPINGS

" PLUGINS:
"--{{{ TREE FILE EXPLORER:       NVIM-TREE: <l>t = NvimTreeToggle, <l>T = NvimTreeFindFile
lua << EOF
    -- disable netrw at the very start of your init.lua (strongly advised)
    vim.g.loaded_netrw = 1 -- let g:loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1 -- let g:loaded_netrwPlugin = 1

    -- set termguicolors to enable highlight groups (already set)
    vim.o.termguicolors = true

    --{{{ Custom keymappings

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
      vim.keymap.set('n', 'p',          print_node_path,                       opts('Print path'))
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
    function print_node_path()
      local node = api.tree.get_node_under_cursor()
      print(node.absolute_path)
    end
    --}}} Custom keymappings

    require("nvim-tree").setup({
      on_attach = on_attach, -- required for custom keybindings
      sort_by = "case_sensitive",
      hijack_netrw = false,
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
    })
    vim.keymap.set('n', '<leader>T', ":NvimTreeFindFile<CR>") -- nmap <leader>T :NvimTreeFindFile<CR>
    vim.keymap.set('n', '<leader>t', ":NvimTreeToggle<CR>") -- nmap <leader>t :NvimTreeToggle<CR>
--}}} TREE FILE EXPLORER
--{{{ STATUSLINE:               LUALINE
    require('lualine').setup {
        options = { theme  = 'onedark' },
    }
--}}} STATUSLINE
--{{{ COLORSCHEME:              ONEDARKPRO (COLORSCHEME)
    require("onedarkpro").setup({
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
    vim.cmd("colorscheme onedark_vivid")
--}}} COLORSCHEME
--{{{ COLORSCHEME:              JELLYBEANS.NVIM (COLORSCHEME)
    --vim.cmd('colorscheme jellybeans-nvim')
--}}} COLORSCHEME
--{{{ SYNTAX HIGHLIGHTING:      TREESITTER
    require'nvim-treesitter.configs'.setup
    {
        -- A list of parser names, or "all"
        ensure_installed = { "c", "vim", "lua", "c_sharp", "python", "bash" },

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
--}}} SYNTAX HIGHLIGHTING
--{{{ FUZZY FINDER:             FZF.vim: <l>fb = Buffers, <l>ff = Files, <l>fg = GFiles, <l>fm = Marks
    vim.keymap.set({ 'n' }, '<leader>fb', ':Buffers<CR>', { remap = false }) -- nnoremap <leader>fb :Buffers<CR>
    vim.keymap.set({ 'n' }, '<leader>ff', ':Files<CR>',   { remap = false }) -- nnoremap <leader>ff :Files<CR>
    vim.keymap.set({ 'n' }, '<leader>fg', ':GFiles<CR>',  { remap = false }) -- nnoremap <leader>fg :GFiles<CR>
    vim.keymap.set({ 'n' }, '<leader>fm', ':Marks<CR>',   { remap = false }) -- nnoremap <leader>fm :Marks<CR>
--}}} FUZZY FINDER
--{{{ FILE EXPLORER:            RNVIMR: <l>e = RnvimrToggle, <l>re = RnvimrResize
    vim.keymap.set({ 'n' }, '<leader>e', ':RnvimrToggle<CR>', { remap = false, silent = true }) -- nnoremap <silent> <leader>e :RnvimrToggle<CR>
    vim.keymap.set({ 't' }, '<leader>e', '<C-\\><C-n>:RnvimrToggle<CR>', { remap = false, silent = true }) -- tnoremap <silent> <leader>e 

    -- Resize floating window by all preset layouts
    vim.keymap.set({ 't' }, '<leader>re', '<C-\\><C-n>:RnvimrResize<CR>', { remap = false, silent = true }) -- tnoremap <silent> <leader>re <C-\><C-n>:RnvimrResize<CR>
EOF
    "{{{ Other options (default):
        " Make Ranger replace Netrw and be the file explorer
        let g:rnvimr_enable_ex = 1

        " Make Ranger to be hidden after picking a file
        let g:rnvimr_enable_picker = 1

        " Replace `$EDITOR` candidate with this command to open the selected file
        let g:rnvimr_edit_cmd = 'drop'

        " Disable a border for floating window
        let g:rnvimr_draw_border = 0

        " Hide the files included in gitignore
        let g:rnvimr_hide_gitignore = 1

        " Change the border's color
        let g:rnvimr_border_attr = {'fg': 14, 'bg': -1}

        " Make Neovim wipe the buffers corresponding to the files deleted by Ranger
        let g:rnvimr_enable_bw = 1

        " Add a shadow window, value is equal to 100 will disable shadow
        let g:rnvimr_shadow_winblend = 70

        " Draw border with both
        let g:rnvimr_ranger_cmd = ['ranger', '--cmd=set draw_borders outline']

        " Link CursorLine into RnvimrNormal highlight in the Floating window
        highlight link RnvimrNormal CursorLine

        " Resize floating window by special preset layouts
        "tnoremap <silent> <leader>es <C-\><C-n>:RnvimrResize 1,8,9,11,5<CR>

        " Resize floating window by single preset layout
        " tnoremap <silent> <leader>eS <C-\><C-n>:RnvimrResize 6<CR>

        " Map Rnvimr action
        let g:rnvimr_action = {
                    \ '<C-t>': 'NvimEdit tabedit',
                    \ '<C-x>': 'NvimEdit split',
                    \ '<C-v>': 'NvimEdit vsplit',
                    \ 'gw': 'JumpNvimCwd',
                    \ 'yw': 'EmitRangerCwd'
                    \ }

        " Add views for Ranger to adapt the size of floating window
        let g:rnvimr_ranger_views = [
                    \ {'minwidth': 90, 'ratio': []},
                    \ {'minwidth': 50, 'maxwidth': 89, 'ratio': [1,1]},
                    \ {'maxwidth': 49, 'ratio': [1]}
                    \ ]

        " Customize the initial layout
        let g:rnvimr_layout = {
                    \ 'relative': 'editor',
                    \ 'width': float2nr(round(0.7 * &columns)),
                    \ 'height': float2nr(round(0.7 * &lines)),
                    \ 'col': float2nr(round(0.15 * &columns)),
                    \ 'row': float2nr(round(0.15 * &lines)),
                    \ 'style': 'minimal'
                    \ }

        " Customize multiple preset layouts
        " '{}' represents the initial layout
        let g:rnvimr_presets = [
                    \ {'width': 0.600, 'height': 0.600},
                    \ {},
                    \ {'width': 0.800, 'height': 0.800},
                    \ {'width': 0.950, 'height': 0.950},
                    \ {'width': 0.500, 'height': 0.500, 'col': 0, 'row': 0},
                    \ {'width': 0.500, 'height': 0.500, 'col': 0, 'row': 0.5},
                    \ {'width': 0.500, 'height': 0.500, 'col': 0.5, 'row': 0},
                    \ {'width': 0.500, 'height': 0.500, 'col': 0.5, 'row': 0.5},
                    \ {'width': 0.500, 'height': 1.000, 'col': 0, 'row': 0},
                    \ {'width': 0.500, 'height': 1.000, 'col': 0.5, 'row': 0},
                    \ {'width': 1.000, 'height': 0.500, 'col': 0, 'row': 0},
                    \ {'width': 1.000, 'height': 0.500, 'col': 0, 'row': 0.5}
                    \ ]

        " Fullscreen for initial layout
        " let g:rnvimr_layout = {
        "            \ 'relative': 'editor',
        "            \ 'width': &columns,
        "            \ 'height': &lines - 2,
        "            \ 'col': 0,
        "            \ 'row': 0,
        "            \ 'style': 'minimal'
        "            \ }
        "
        " Only use initial preset layout
        " let g:rnvimr_presets = [{}]
    "}}}
lua << EOF
--}}} FILE EXPLORER
--{{{ ADDITIONAL MOTION:        VIM-EASYMOTION: <l>m = MoveToText
    -- Disable default mappings
    vim.g.EasyMotion_do_mapping = 0 -- let g: = 0
    vim.keymap.set('n', '<leader>m', '<Plug>(easymotion-overwin-f2)') -- nmap <leader>m <Plug>(easymotion-overwin-f2)
--}}} ADDITIONAL MOTION
--{{{ PERSONAL WIKI:            WIKI.VIM: <l>ww = OpenWiki
    -- Remap of wiki opening which also sets CWD to wiki root
    vim.keymap.set('n', '<leader>ww', '<Plug>(wiki-index):cd%:p:h<CR>', { silent = true }) -- nmap <silent> <leader>ww <Plug>(wiki-index):cd%:p:h<CR>
    vim.g.wiki_root = '~/Documents/MyWiki/' -- let g:wiki_root = '~/Documents/MyWiki/'
    vim.g.wiki_filetypes = {'md'} -- let g:wiki_filetypes = ['md']
    vim.g.wiki_link_extension = '.md' -- let g:wiki_link_extension = '.md'
    vim.g.wiki_link_target_type= 'md' -- let g:wiki_link_target_type= 'md'

    vim.api.nvim_create_autocmd( 
        { 'FileType' }, 
        {
            pattern = { 'markdown' }, 
            callback = function() 
                vim.o.textwidth = 120
                vim.o.colorcolumn = "121"
                vim.o.wrap = false
            end
        }) -- autocmd FileType markdown set textwidth=120 colorcolumn=121 nowrap
--}}} PERSONAL WIKI
--{{{ IMAGES IN MARKDOWN:       IMG-PASTE: <l>p = MarkdownClipboardImage
    vim.api.nvim_create_autocmd( 
        { 'FileType' }, 
        {
            pattern = { 'markdown' }, 
            callback = function() vim.keymap.set('n', '<leader>p', ':call mdip#markdownclipboardimage()<cr>', { silent = true }) end
        }) -- autocmd filetype markdown nmap <buffer><silent> <leader>p :call mdip#markdownclipboardimage()<cr>
    vim.g.mdip_imgdir_absolute = '~/Documents/MyWiki/img' -- let g:mdip_imgdir_absolute = '~/Documents/MyWiki/img'
EOF
"--}}} IMG-PASTE

" DEVELOPMENT RELATED
"--{{{ OUTLINER:                 TAGBAR (C-tags based outliner): <l>go = TagbarToggle
lua << EOF
    vim.keymap.set({ 'n', 'v', 'o' }, '<leader>go',  ':TagbarToggle<CR>', { remap = false }) -- noremap <leader>go :TagbarToggle<CR>
--}}} OUTLINER
--{{{ C# LSP-alternative:       OMNISHARP
    vim.g.OmniSharp_selector_ui = "fzf" -- let g:OmniSharp_selector_ui = 'fzf'
    vim.keymap.set('n', 'K', ':OmniSharpDocumentation<CR>') -- nmap K :OmniSharpDocumentation<CR>
    vim.keymap.set('n', '<C-k>', ':OmniSharpGotoDefinition<CR>') -- nmap <C-k> :OmniSharpGotoDefinition<CR>
--}}} C# LSP-alternative
--{{{ VSCODE COMP LAYER(LSP):   COC.NVIM
     -- List of extansions for coc.nvim to be installed automatically
    vim.g.coc_global_extensions = {'coc-sh', 'coc-cmake', 'coc-html', 'coc-json', 'coc-phpls', 'coc-pyright', 'coc-tsserver'} -- let g:coc_global_extensions=[ 'coc-sh', 'coc-pyright' ]

    local disableExCommandLine = function()
        if (string.match(vim.api.nvim_buf_get_name(0), "CocTree%d")) then
            vim.api.nvim_buf_set_keymap(0, "n", ":", ":", {silent = true, noremap = true})
        end
    end
    vim.api.nvim_create_autocmd( {"BufEnter"}, {callback = disableExCommandLine} )
EOF
"}}} VSCode compatibility layer, LSP
" TODO:
"--{{{ DEBUGGING                 NVIM-DAP
lua << EOF
--[[
local dap  = require("dap")
dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
        command = '/home/mgzela/MyPrograms/codelldb/extension/adapter/codelldb',
        args = {"--port", "${port}"},
    }
}
dap.configurations.cpp = {
    {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
    }
}
dap.configurations.c = dap.configurations.cpp

require("nvim-dap-virtual-text").setup()
require("dapui").setup({
  icons = { expanded = "", collapsed = "", current_frame = "" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Use this to override mappings for specific elements
  element_mappings = {
    -- Example:
    -- stacks = {
    --   open = "<CR>",
    --   expand = "o",
    -- }
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7") == 1,
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "",
      terminate = "",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})
--]]
EOF
" nnoremap <silent><leader>db <cmd>lua require('dap').toggle_breakpoint()<CR>
" nnoremap <silent><leader>dBC <Cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
" nnoremap <silent><leader>dBc <Cmd>lua require('dap').clear_breakpoints()<CR>
" nnoremap <silent><leader>dBl <Cmd>lua require('dap').list_breakpoints()<CR>
" nnoremap <silent><leader>dl <Cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
" nnoremap <silent><leader>dc <cmd>lua require('dap').continue()<CR>
" nnoremap <silent><leader>dC <cmd>lua require('dap').run_last()<CR>
" nnoremap <silent><leader>dso <cmd>lua require('dap').step_over()<CR>
" nnoremap <silent><leader>dsO <cmd>lua require('dap').step_out()<CR>
" nnoremap <silent><leader>dsi <cmd>lua require('dap').step_into()<CR>
" nnoremap <silent><leader>dro <cmd>lua require('dap').repl.open()<CR>
"
" nnoremap <silent><leader>du <cmd>lua require('dapui').toggle()<CR>
" nnoremap <silent><leader>de <cmd>lua require('dapui').eval()<CR>
" vnoremap <silent><leader>de <cmd>lua require('dapui').eval()<CR>
"--}}} DEBUGGING

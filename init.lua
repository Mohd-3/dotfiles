vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.scrolloff = 8
vim.opt.showmode = false
-- vim.opt.confirm = true
vim.opt.inccommand = 'split'
vim.opt.termguicolors = true

vim.opt.backspace = 'indent,eol,start'
vim.opt.laststatus = 2
vim.opt.colorcolumn = '89'
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.hidden = true
vim.opt.modeline = false
vim.opt.mouse = ''
vim.opt.wildignore = {
    '*/__pycache__/',
    '*/env/*',
    '*.pyc',
    '*.o',
    '*.out',
    '*.jpg',
    '*.jpeg',
    '*.png',
    '*.gif',
    '*.zip',
    '*.tar.gz',
    '*.class',
}
vim.opt.completeopt = 'menu,menuone,noinsert,noselect'

vim.opt.showcmd = true
vim.opt.wildmenu = true
vim.opt.showmatch = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.winminheight = 0
vim.opt.winminwidth = 0
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.softtabstop = 4
vim.opt.smarttab = true

vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.undofile = true
vim.opt.undodir = '/home/mohd/.local/share/nvim/undo'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.api.nvim_create_user_command('FormatDisable', function(args)
    if args.bang then
        vim.b.disable_autoformat = true
    else
        vim.g.disable_autoformat = true
    end
end, {
    desc = 'Disable autoformat-on-save',
    bang = true,
})
vim.api.nvim_create_user_command('FormatEnable', function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
end, {
    desc = 'Re-enable autoformat-on-save',
})
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { '/var/log/*' },
    desc = 'Set log file settings',
    callback = function()
        vim.bo.filetype = 'log'
        vim.bo.undofile = false
    end,
})
function _G.get_oil_winbar()
    local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    local dir = require('oil').get_current_dir(bufnr)
    if dir then
        return vim.fn.fnamemodify(dir, ':~')
    else
        return vim.api.nvim_buf_get_name(0)
    end
end

local function parse_output(proc)
    local result = proc:wait()
    local ret = {}
    if result.code == 0 then
        for line in vim.gsplit(result.stdout, '\n', { plain = true, trimempty = true }) do
            line = line:gsub('/$', '')
            ret[line] = true
        end
    end
    return ret
end

local function new_git_status()
    return setmetatable({}, {
        __index = function(self, key)
            local ignore_proc = vim.system(
                { 'git', 'ls-files', '--ignored', '--exclude-standard', '--others', '--directory' },
                {
                    cwd = key,
                    text = true,
                }
            )
            local tracked_proc = vim.system({ 'git', 'ls-tree', 'HEAD', '--name-only' }, {
                cwd = key,
                text = true,
            })
            local ret = {
                ignored = parse_output(ignore_proc),
                tracked = parse_output(tracked_proc),
            }

            rawset(self, key, ret)
            return ret
        end,
    })
end
local git_status = new_git_status()

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
    { 'tpope/vim-eunuch' },
    { 'NMAC427/guess-indent.nvim' },
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        opts = {},
        keys = {

            { '<leader>zz', '<cmd>ToggleTerm direction=float<CR>', noremap = true, silent = true },
            { '<leader>zj', '<cmd>ToggleTerm direction=horizontal<CR>', noremap = true, silent = true },
            { '<leader>zl', '<cmd>ToggleTerm direction=vertical<CR>', noremap = true, silent = true },
        },
    },
    {
        'norcalli/nvim-colorizer.lua',
        opts = {},
    },
    {
        'AckslD/nvim-neoclip.lua',
        dependencies = {
            { 'nvim-telescope/telescope.nvim' },
        },
        opts = {},
        keys = {
            { '<leader>y', '<cmd>Telescope registers<CR>' },
        },
    },
    {
        'chentoast/marks.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'zeioth/garbage-day.nvim',
        dependencies = {
            { 'neovim/nvim-lspconfig' },
        },
        -- lazy = false,
        event = 'VeryLazy',
        opts = {},
    },
    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        ft = { 'markdown' },
        build = function()
            vim.fn['mkdp#util#install']()
        end,
        keys = {
            { '<leader>mt', '<cmd>MarkdownPreviewToggle<CR>', desc = 'Toggle Markdown Preview' },
        },
    },
    {
        's1n7ax/nvim-search-and-replace',
        opts = {
            ignore = {
                '**/node_modules/**',
                '**/.git/**',
                '**/.gitignore',
                '**/.gitmodules',
                'build/**',
                'env/**',
                '**/migrations/**',
                '**/*.pyc',
            },
            update_changes = false,
            replace_keymap = '<leader>sr',
            replace_all_keymap = '<leader>sR',
            replace_and_save_keymap = '<leader>su',
            replace_all_and_save_keymap = '<leader>sU',
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gitsigns.nav_hunk('next')
                    end
                end)

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end)

                -- Actions
                map('n', '<leader>hs', gitsigns.stage_hunk)
                map('n', '<leader>hr', gitsigns.reset_hunk)

                map('v', '<leader>hs', function()
                    gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                map('v', '<leader>hr', function()
                    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                map('n', '<leader>hS', gitsigns.stage_buffer)
                map('n', '<leader>hR', gitsigns.reset_buffer)
                map('n', '<leader>hp', gitsigns.preview_hunk)
                map('n', '<leader>hi', gitsigns.preview_hunk_inline)

                map('n', '<leader>hb', function()
                    gitsigns.blame_line({ full = true })
                end)

                map('n', '<leader>hd', gitsigns.diffthis)

                map('n', '<leader>hD', function()
                    gitsigns.diffthis('~')
                end)

                map('n', '<leader>hQ', function()
                    gitsigns.setqflist('all')
                end)
                map('n', '<leader>hq', gitsigns.setqflist)

                map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
                map('n', '<leader>tw', gitsigns.toggle_word_diff)

                map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
            end,
        },
    },
    -- {
    --     'rmehri01/onenord.nvim',
    --     opts = {},
    --     priority = 1000,
    -- },
    {
        'joshdick/onedark.vim',
        config = function()
            vim.cmd('colorscheme onedark')
        end,
        priority = 1000,
    },
    {
        'kylechui/nvim-surround',
        event = 'VeryLazy',
        opts = {},
    },
    { 'nvim-tree/nvim-web-devicons' },
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
        opts = {
            lsp = {
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true,
                },
            },
            presets = {
                bottom_search = false,
                command_palette = false,
                long_message_to_split = false,
                inc_rename = false,
                lsp_doc_border = false,
            },
            routes = {
                {
                    view = 'notify',
                    filter = { event = 'msg_showmode' },
                },
            },
            views = {
                cmdline_popup = {
                    position = {
                        row = 5,
                        col = '50%',
                    },
                    size = {
                        width = 60,
                        height = 'auto',
                    },
                },
                popupmenu = {
                    relative = 'editor',
                    position = {
                        row = 8,
                        col = '50%',
                    },
                    size = {
                        width = 60,
                        height = 10,
                    },
                    border = {
                        style = 'rounded',
                        padding = { 0, 1 },
                    },
                    win_options = {
                        winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
                    },
                },
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        lazy = false,
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
        },
        event = { 'InsertEnter', 'CmdlineEnter' },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                mapping = {
                    ['<CR>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            -- if luasnip.expandable() then
                            --     luasnip.expand()
                            -- else
                            cmp.confirm({
                                select = true,
                            })
                        -- end
                        else
                            fallback()
                        end
                    end),

                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        -- elseif luasnip.locally_jumpable(1) then
                        --   luasnip.jump(1)
                        elseif require('copilot.suggestion').is_visible() then
                            require('copilot.suggestion').accept()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),

                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        -- elseif luasnip.locally_jumpable(-1) then
                        --   luasnip.jump(-1)
                        elseif require('copilot.suggestion').is_visible() then
                            require('copilot.suggestion').dismiss()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'path' },
                }),
            })
            cmp.event:on('menu_opened', function()
                vim.b.copilot_suggestion_hidden = true
            end)

            cmp.event:on('menu_closed', function()
                vim.b.copilot_suggestion_hidden = false
            end)
        end,
    },
    {
        'stevearc/conform.nvim',
        event = { 'BufWritePre' },
        cmd = { 'ConformInfo' },
        keys = {
            {
                '<leader>ef',
                function()
                    require('conform').format({ async = true })
                end,
                mode = '',
                desc = 'Format buffer',
            },
            {
                '<leader>ed',
                '<cmd>FormatDisable<CR>',
                desc = 'Disable Format on Save',
            },
        },
        opts = {
            formatters_by_ft = {
                lua = { 'stylua' },
                python = { 'isort', 'black' },
                javascript = { 'prettierd', 'prettier', stop_after_first = true },
            },

            default_format_opts = {
                lsp_format = 'fallback',
            },
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end

                return { timeout_ms = 500, lsp_format = 'fallback' }
            end,
            formatters = {
                shfmt = {
                    append_args = { '-i', '2' },
                },
                black = {
                    append_args = { '--skip-string-normalization' },
                },
                isort = {
                    append_args = { '--profile', 'black' },
                },
                stylua = {
                    append_args = {
                        '--indent-type',
                        'Spaces',
                        '--indent-width',
                        '4',
                        '--quote-style',
                        'AutoPreferSingle',
                    },
                },
            },
        },
    },
    {
        'greggh/claude-code.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        opts = {
            window = {
                position = 'float',
                float = {
                    width = '90%',
                    height = '90%',
                    row = 'center',
                    col = 'center',
                    relative = 'editor',
                    border = 'single',
                },
            },
        },
        keys = {
            { '<leader>cc', '<cmd>ClaudeCode<CR>', desc = 'Toggle Claude Code' },
            { '<leader>cr', '<cmd>ClaudeCodeContinue<CR>', desc = 'Toggle Claude Code Coninue' },
        },
    },
    {
        'johnseth97/codex.nvim',
        lazy = true,
        cmd = { 'Codex', 'CodexToggle' },
        keys = {
            {
                '<leader>cd',
                function()
                    require('codex').toggle()
                end,
                desc = 'Toggle Codex popup',
                mode = { 'n', 't' },
            },
        },
        opts = {
            keymaps = {
                toggle = nil,
                quit = '<C-q>',
            },
            border = 'rounded',
            width = 0.8,
            height = 0.8,
            model = nil,
            autoinstall = true,
        },
    },
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
        opts = {
            panel = {
                layout = {
                    position = 'right',
                    ratio = 0.4,
                },
            },
            suggestion = {
                keymap = {
                    accept = '<M-o>',
                    accept_word = false,
                    accept_line = false,
                    next = '<M-]>',
                    prev = '<M-[>',
                    dismiss = '<C-]>',
                },
            },
        },
    },
    {
        'rest-nvim/rest.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            opts = function(_, opts)
                opts.ensure_installed = opts.ensure_installed or {}
                table.insert(opts.ensure_installed, 'http')
            end,
            keys = {
                { '<leader>pe', '<cmd>lua require("telescope").extensions.rest.select_env()<CR>' },
            },
        },
    },
    {
        'fei6409/log-highlight.nvim',
        opts = {},
    },
    {
        'stevearc/oil.nvim',
        opts = {},
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'benomahony/oil-git.nvim',
            'JezerM/oil-lsp-diagnostics.nvim',
        },
        lazy = false,
        config = function()
            local detail = false
            require('oil').setup({
                win_options = {
                    winbar = '%!v:lua.get_oil_winbar()',
                },
                view_options = {
                    is_hidden_file = function(name, bufnr)
                        local dir = require('oil').get_current_dir(bufnr)
                        local is_dotfile = vim.startswith(name, '.') and name ~= '..'
                        if not dir then
                            return is_dotfile
                        end
                        if is_dotfile then
                            return not git_status[dir].tracked[name]
                        else
                            return git_status[dir].ignored[name]
                        end
                    end,
                },
                keymaps = {
                    ['gd'] = {
                        desc = 'Toggle file detail view',
                        callback = function()
                            detail = not detail
                            if detail then
                                require('oil').set_columns({ 'icon', 'permissions', 'size', 'mtime' })
                            else
                                require('oil').set_columns({ 'icon' })
                            end
                        end,
                    },
                },
            })
        end,
        keys = {
            { '-', '<Cmd>Oil<CR>', desc = 'Browse files from here' },
        },
    },
    {
        'https://github.com/tpope/vim-sleuth',
        event = { 'BufReadPost', 'BufNewFile' },
    },
    {
        'https://github.com/farmergreg/vim-lastplace',
        event = 'BufReadPost',
    },
    {
        'NeogitOrg/neogit',
        lazy = true,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
            'nvim-telescope/telescope.nvim',
        },
        cmd = 'Neogit',
        keys = {
            { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Show Neogit UI' },
        },
    },
    {
        'https://github.com/nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'mason-org/mason.nvim',
        opts = {},
    },
    {
        'owallb/mason-auto-install.nvim',
        dependencies = {
            'williamboman/mason.nvim',
            'neovim/nvim-lspconfig',
        },
        opts = {
            packages = {
                'lua-language-server',
                'stylua',
                'prettier',
                'prettierd',
                'python-lsp-server',
                'isort',
                'html-lsp',
                'htmlbeautifier',
                'vue-language-server',
                'black',
                'copilot-language-server',
                'django-template-lsp',
                'vim-language-server',
            },
        },
    },
    {
        'nvim-flutter/flutter-tools.nvim',
        lazy = false,
        opts = {
            defaults = {
                file_ignore_patterns = {
                    'node_modules',
                    '.git/',
                    '__pycache__/',
                    'env/',
                },
            },
        },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim',
        },
        keys = {
            { '<leader>fa', ':FlutterRun<CR>', noremap = true, silent = true },
            { '<leader>fr', ':FlutterReload<CR>', noremap = true, silent = true },
            { '<leader>fR', ':FlutterRestart<CR>', noremap = true, silent = true },
            { '<leader>fq', ':FlutterQuit<CR>', noremap = true, silent = true },
            { '<leader>fD', ':FlutterVisualDebug<CR>', noremap = true, silent = true },
            { '<leader>fe', ':FlutterEmulators<CR>', noremap = true, silent = true },
        },
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.9',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'BurntSushi/ripgrep',
        },
        opts = {},
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    },
    {
        'rmagatti/goto-preview',
        event = 'BufEnter',
        opts = {},
        keys = {
            {
                '<leader>d',
                '<cmd>lua require("goto-preview").goto_preview_definition()<CR>',
                noremap = true,
            },
            {
                '<leader>r',
                '<cmd>lua require("goto-preview").goto_preview_references()<CR>',
                noremap = true,
            },

            {
                '<leader>gc',
                '<cmd>lua require("goto-preview").close_all_win()<CR>',
                noremap = true,
            },
        },
    },
    {
        'dnlhc/glance.nvim',
        cmd = 'Glance',
        opts = {
            list = {
                position = 'left',
                width = 0.33,
            },
        },
    },

    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'master',
        lazy = false,
        build = ':TSUpdate',
        opts = {
            ensure_installed = {
                'python',
                'lua',
                'dart',
                'javascript',
                'typescript',
                'html',
                'htmldjango',
                'css',
                'c_sharp',
                'dockerfile',
                'cpp',
                'json',
                'bash',
                'vue',
                'vim',
                'yaml',
            },
            highlight = {
                enable = true,
            },
        },
    },
    {
        'nyngwang/NeoZoom.lua',
        opts = {
            popup = { enabled = true },
            winopts = {
                offset = {
                    width = 150,
                    height = 0.85,
                },
                border = 'thicc',
            },
            presets = {
                {
                    filetypes = { 'dapui_.*', 'dap-repl' },
                    winopts = {
                        offset = { top = 0.02, left = 0.26, width = 0.74, height = 0.25 },
                    },
                },
                {
                    filetypes = { 'markdown' },
                    callbacks = {
                        function()
                            vim.wo.wrap = true
                        end,
                    },
                },
            },
        },
        keys = {
            {
                '<CR>',
                function()
                    vim.cmd('NeoZoomToggle')
                end,
                silent = true,
                nowait = true,
            },
        },
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {},
        keys = {
            {
                '<leader>?',
                function()
                    require('which-key').show({ global = false })
                end,
                desc = 'Buffer Local Keymaps (which-key)',
            },
        },
    },
})

vim.lsp.config('pylsp', {
    cmd = { vim.fn.expand('~/.venvs/pylsp/bin/pylsp') },
    settings = {
        pylsp = {
            plugins = {
                pylsp_rope = { rename = true },
                rope_rename = { enabled = false },
                jedi_rename = { enaled = false },
            },
        },
    },
})

local enabled_servers = { 'pylsp', 'html-lsp', 'vue_lsp', 'lua_ls', 'djls', 'cssls' }
for _, server in ipairs(enabled_servers) do
    vim.lsp.enable(server)
end

require('codex').status()
require('telescope').load_extension('fzf')
require('telescope').load_extension('rest')
local builtin = require('telescope.builtin')
local refresh = require('oil.actions').refresh

local orig_refresh = refresh.callback
refresh.callback = function(...)
    git_status = new_git_status()
    orig_refresh(...)
end

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { silent = true })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>en', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>pg', builtin.git_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>ph', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', '<leader>ga', vim.lsp.buf.code_action, { desc = 'LSP code action' })
vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, { desc = 'LSP rename' })
vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, { desc = 'LSP hover' })
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, { desc = 'LSP references' })
vim.keymap.set('n', '<leader>fz', ':resize 10<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-N>')
vim.keymap.set('t', '<A-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<A-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<A-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<A-l>', '<C-\\><C-N><C-w>l')
vim.keymap.set('i', '<A-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('i', '<A-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('i', '<A-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('i', '<A-l>', '<C-\\><C-N><C-w>l')
vim.keymap.set('n', '<A-h>', '<C-w>h')
vim.keymap.set('n', '<A-j>', '<C-w>j')
vim.keymap.set('n', '<A-k>', '<C-w>k')
vim.keymap.set('n', '<A-l>', '<C-w>l')
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', 'B', '^')
vim.keymap.set('n', 'E', '$')
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('i', '<C-k', '<Up>')
vim.keymap.set('i', '<C-j', '<Down>')
vim.keymap.set('i', '<C-h', '<Left>')
vim.keymap.set('i', '<C-l', '<Right>')
vim.keymap.set('v', '<Right>', 'xpgvlolo')
vim.keymap.set('v', '<Left>', 'xhPgvhoho')
vim.keymap.set('v', '<Down>', 'xjPgvjojo')
vim.keymap.set('v', '<Up>', 'xkPgvkoko')

vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#282C34' })

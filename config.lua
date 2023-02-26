--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
-- lvim.colorscheme = "lunar"
-- lvim.colorscheme = "darkblue"
lvim.colorscheme = "gruvbox"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.list = true
vim.opt.listchars = { eol = '↲', tab = '▸ ', trail = '˽' }

-- go to last position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    callback = function()
        vim.cmd [[
                 if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
        ]]
    end,
})

vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- format json
vim.cmd [[
command! JsonFormat :%!python3 -m json.tool
]]

-- save as root
vim.cmd [[
command! W :execute ':silent w !sudo tee % >/dev/null' | :edit!
command! Wq :execute ':silent w !sudo tee % >/dev/null' | :edit! | :quit
]]

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = ","
-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

lvim.builtin.cmp.cmdline.enable = true
lvim.builtin.terminal.open_mapping = "<c-t>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }
--

-- lvim.builtin.which_key.mappings["l"] = { "<cmd>Telescope resume<CR>", "last search" }
-- -- remove
-- lvim.builtin.which_key.mappings['w'] = {}

lvim.builtin.which_key.mappings[";"] = { "<cmd>Alpha<cr>", "Dashboard" }
lvim.builtin.which_key.mappings["e"] = { "<cmd>NvimTreeToggle<cr>", "File Explorer" }
lvim.builtin.which_key.mappings["/"] = { '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>', "Comment" }
lvim.builtin.which_key.mappings["p"] = {
    name = "Package Manage",
    s = { "<cmd>Lazy sync<cr>", "sync plugins" },
    l = { "<cmd>Lazy log<cr>", "lazy log" },
    p = { "<cmd>Lazy show<cr>", "lazy show" },
    b = { "<cmd>Lazy build<cr>", "lazy build" },
}
lvim.builtin.which_key.mappings["o"] = {
    name = "Options",
    w = { '<cmd>lua require("functions").toggle_option("wrap")<cr>', "Wrap" },
    r = { '<cmd>lua require("functions").toggle_option("relativenumber")<cr>', "Relative" },
    l = { '<cmd>lua require("functions").toggle_option("cursorline")<cr>', "Cursorline" },
    c = { '<cmd>lua require("functions").toggle_option("cursorcolumn")<cr>', "Cursorcolumn" },
    s = { '<cmd>lua require("functions").toggle_option("spell")<cr>', "Spell" },
    D = { "<cmd>set background=dark<cr>", "set background to dark" },
    L = { "<cmd>set background=light<cr>", "set background to light" },
    C = { "<cmd>checkhealth<cr>", "Check Health" },
    e = { "<cmd>edit ~/.config/nvim/init.lua<cr>", "edit init.lua" },
    -- t = { '<cmd>lua require("functions").toggle_tabline()<cr>', "Tabline" },
}
lvim.builtin.which_key.mappings["h"] = {
    { "<cmd>nohlsearch<cr>", "No Highlight" },
}
lvim.builtin.which_key.mappings["b"] = {
    name = "Buffer manage",
    h = { "<cmd>BufferLineCloseLeft<cr>", "close all to the left" },
    l = { "<cmd>BufferLineCloseRight<cr>", "close all to the right" },
    p = { "<cmd>BufferLineCyclePrev<cr>", "previous" },
    b = { "<cmd>BufferLineCyclePrev<cr>", "previous" },
    n = { "<cmd>BufferLineCycleNext<cr>", "next" },
    j = { "<cmd>BufferLinePick<cr>", "jump" },
    c = { "<cmd>BufferLinePickClose<cr>", "pick buffer to close" },
}
lvim.builtin.which_key.mappings["w"] = {
    name = "Window and Tab",
    h = { "<c-w>h", "left window" },
    j = { "<c-w>j", "bottom window" },
    k = { "<c-w>k", "top window" },
    l = { "<c-w>l", "right window" },
    ["["] = { "<cmd>bprevious<cr>", "left tab" },
    ["]"] = { "<cmd>bnext<cr>", "right tab" },
    ["-"] = { "<cmd>split<cr>", "HSplit" },
    ["|"] = { "<cmd>vsplit<cr>", "VSplit" },
    q = { "<cmd>q<cr>", "Close Window" },
    f = { "<cmd>NvimTreeFindFile<cr>", "focus file in nvim tree" },
}
lvim.builtin.which_key.mappings["q"] = {
    name = "Quickfix",
    n = { "<cmd>cnext<cr>", "next quickfix location" },
    p = { "<cmd>cprevious<cr>", "previous quickfix location" },
    c = { "<cmd>cclose<cr>", "close quickfix window" },
    j = { "<cmd>cnext<cr>", "next quickfix location" },
    k = { "<cmd>cprevious<cr>", "previous quickfix location" },
    q = { "<cmd>cclose<cr>", "close quickfix window" },
}
-- ["q"] = { '<cmd>lua require("functions").smart_quit()<CR>', "Quit" },
lvim.builtin.which_key.mappings["T"] = {
    name = "Terminal",
    t = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal Terminal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical Terminal" },
}
lvim.builtin.which_key.mappings["f"] = {
    name = "File",
    F = { "<cmd>Telescope find_files<cr>", "Find Files (With Previewer)" },
    f = {
        "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        "Find Files",
    },
    t = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
    b = { "<cmd>Telescope buffers<cr>", "Buffer List" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
    -- i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
    w = { "<cmd>wall<cr>", "save all" },
    c = { "<cmd>Telescope commands<cr>", "Commands" },
    q = { "<cmd>wqall<cr>", "save all and quit" },
    Q = { "<cmd>qall!<cr>", "quit without save!!" },
}
lvim.builtin.which_key.mappings["t"] = {
    name = "Telescope",
    r = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    h = { "<cmd>Telescope command_history<cr>", "Command History" },
    c = { "<cmd>Telescope commands<cr>", "Commands" },
    m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    ["l"] = { "<cmd>Telescope resume<cr>", "Last Search" },
    ["?"] = { "<cmd>Telescope help_tags<cr>", "Help" },
}
lvim.builtin.which_key.mappings["g"] = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    -- l = { "<cmd>GitBlameToggle<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
        "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    -- d = {
    --   "<cmd>Gitsigns diffthis HEAD<cr>",
    --   "Diff",
    -- },
    -- G = {
    --     name = "Gist",
    --     a = { "<cmd>Gist -b -a<cr>", "Create Anon" },
    --     d = { "<cmd>Gist -d<cr>", "Delete" },
    --     f = { "<cmd>Gist -f<cr>", "Fork" },
    --     g = { "<cmd>Gist -b<cr>", "Create" },
    --     l = { "<cmd>Gist -l<cr>", "List" },
    --     p = { "<cmd>Gist -b -p<cr>", "Create Private" },
    -- },
}




-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "tsx",
    "css",
    "rust",
    "java",
    "yaml",
    "markdown",
    "markdown_inline"
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
-- lvim.plugins = {
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }
lvim.plugins = {
    {
        'ellisonleao/gruvbox.nvim'
    },
    {
        'hrsh7th/cmp-cmdline'

    },
    {
        "s1n7ax/nvim-window-picker",
        tag = "1.*",
    },
    {
        {
            "tpope/vim-surround",
        },
        {
            "tpope/vim-repeat",
        }
    },
    {
        'phaazon/hop.nvim',
        brance = 'v2'
    },
    {

        "karb94/neoscroll.nvim",
    },
    {
        "glepnir/lspsaga.nvim",
        branch = "main",
        requires = {
            { "nvim-tree/nvim-web-devicons" },
            --Please make sure you install markdown and markdown_inline parser
            { "nvim-treesitter/nvim-treesitter" }
        }
    },
    {
        "ray-x/lsp_signature.nvim",
    }

}

require('user.lsp-signature').setup()
require('user.lspsaga').setup()
require('user.surround').setup()
require('user.hop').setup()
require('user.neoscroll').setup()
require('user.window-picker').setup()



-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

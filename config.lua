-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.leader = ","

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
-- lvim.colorscheme = "lunar"
-- lvim.colorscheme = "darkblue"
-- lvim.colorscheme = "gruvbox"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.timeoutlen = 150

vim.opt.list = true
vim.opt.listchars = { eol = "↲", tab = "▸ ", trail = "˽" }

-- local opts = { noremap = true, silent = true }
-- local keymap = vim.api.nvim_set_keymap
-- keymap("n", "<up>", "<cmd>resize +2<cr>", opts)
-- keymap("n", "<down>", "<cmd>resize -2<cr>", opts)
-- keymap("n", "<left>", "<cmd>vertical resize -2<cr>", opts)
-- keymap("n", "<right>", "<cmd>vertical resize +2<cr>", opts)

-- go to last position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    callback = function()
        vim.cmd([[
                 if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
        ]])
    end,
})

vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

-- format json
vim.cmd([[
command! JsonFormat :%!python3 -m json.tool
]])

-- save as root
vim.cmd([[
command! W :execute ':silent w !sudo tee % >/dev/null' | :edit!
command! Wq :execute ':silent w !sudo tee % >/dev/null' | :edit! | :quit
]])

lvim.builtin.cmp.cmdline.enable = true
lvim.builtin.terminal.open_mapping = "<c-t>"

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
    o = { "<cmd>BufferLineCloseOthers<cr>", "close all other tabs" },
    c = { "<cmd>BufferLinePickClose<cr>", "pick buffer to close" },

    p = { "<cmd>BufferLineCyclePrev<cr>", "previous" },
    n = { "<cmd>BufferLineCycleNext<cr>", "next" },

    b = { "<cmd>BufferLineCyclePrev<cr>", "previous" },
    j = { "<cmd>BufferLinePick<cr>", "jump" },
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

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end

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

-- lvim.builtin.which_key.mappings["s"] = {
--     name = "Lspsaga",
--     f = { "<cmd>Lspsaga finder<cr>", "Finder" },
--     r = { "<cmd>Lspsaga rename<cr>", "Rename" },
--     o = { "<cmd>Lspsaga outline<cr>", "Outline" },
--     a = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
--     t = { "<cmd>Lspsaga term_toggle<cr>", "Terminal" },
--     w = { "<cmd>Lspsaga winbar_toggle<cr>", "Winbar" },
-- }

lvim.builtin.which_key.mappings["l"] = {
    name = "LSP",

    -- Code Action
    -- a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    a = { "<cmd>Lspsaga code_action<cr>", "Code Action" },

    -- d = { "<cmd>TroubleToggle<cr>", "Diagnostics" },

    f = { "<cmd>Lspsaga finder<cr>", "Finder" },
    -- f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
    -- F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },

    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
        "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
        "Next Diagnostic",
    },
    k = {
        "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
        "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },

    -- o = { "<cmd>SymbolsOutline<cr>", "Outline" },
    o = { "<cmd>Lspsaga outline<cr>", "Outline" },

    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },

    -- r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    r = { "<cmd>Lspsaga rename<cr>", "Rename" },

    R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },

    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        "Workspace Symbols",
    },

    -- t = { '<cmd>lua require("functions").toggle_diagnostics()<cr>', "Toggle Diagnostics" },
    t = { "<cmd>Lspsaga term_toggle<cr>", "Terminal" },

    -- w = {
    --     "<cmd>Telescope lsp_workspace_diagnostics<cr>",
    --     "Workspace Diagnostics",
    -- },
    w = { "<cmd>Lspsaga winbar_toggle<cr>", "Winbar" },
}

lvim.plugins = {
    {
        "tpope/vim-surround",
    },
    {
        "tpope/vim-repeat",
    },
    {
        "karb94/neoscroll.nvim",
    },
    {
        "phaazon/hop.nvim",
        branch = "v2",
    },
    {
        "j-hui/fidget.nvim",
        version = "legacy",
    },
    {
        "folke/todo-comments.nvim",
        event = "BufRead",
    },
    {
        "glepnir/lspsaga.nvim",
        branch = "main",
    },
    {
        "ray-x/lsp_signature.nvim",
    },
    {
        "rmagatti/auto-session",
    },
}

require("user.surround").setup()
require("user.neoscroll").setup()
require("user.hop").setup()
require("user.fidget").setup()
require("user.todo_comments").setup()
require("user.lspsaga").setup()
require("user.lsp-signature").setup()
require("user.auto-session").setup()

require("user.basic")

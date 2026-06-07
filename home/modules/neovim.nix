{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      tree-sitter
      ripgrep
      fd
    ];

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      nvim-treesitter.withAllGrammars
      telescope-nvim
      plenary-nvim
      oil-nvim
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      luasnip
      cmp_luasnip
      gitsigns-nvim
      which-key-nvim
      mini-nvim
      nvim-autopairs
      comment-nvim
      indent-blankline-nvim
    ];

    extraLuaConfig = ''
      vim.g.mapleader = " "
      vim.g.maplocalleader = "\\"
      
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.termguicolors = true
      vim.opt.wrap = false
      vim.opt.scrolloff = 8
      vim.opt.sidescrolloff = 8
      
      vim.opt.expandtab = true
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
      vim.opt.smartindent = true
      vim.opt.shiftround = true
      
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.inccommand = "split"
      
      vim.opt.clipboard = "unnamedplus"
      vim.opt.undofile = true
      vim.opt.backup = false
      vim.opt.swapfile = false
      
      require("catppuccin").setup({
        flavour = "frappe",
        transparent_background = false,
      })
      vim.cmd.colorscheme("catppuccin")
      
      require("nvim-autopairs").setup({
        enable_check_bracket_line = true,
        check_ts = true,
        disable_filetype = { "TelescopePrompt" },
      })
      
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      
      require("mini.indentscope").setup({
        draw = {
          delay = 50,
          animation = require("mini.indentscope").gen_animation.linear({
            duration = 10,
            unit = "total",
          }),
        },
      })
      
      require("Comment").setup({
        toggler = {
          line = "gcc",
          block = "gbc",
        },
        opleader = {
          line = "gc",
          block = "gb",
        },
      })
      
      require("gitsigns").setup({
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
        },
      })
      
      require("ibl").setup({
        indent = { char = "│" },
        scope = { enabled = true, char = "▎" },
        whitespace = { highlight = { "Whitespace" } },
      })
      
      require("oil").setup({
        default_file_explorer = true,
        columns = { "icon" },
        win_options = {
          signcolumn = "no",
        },
      })
      vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
      vim.keymap.set("n", "<leader>e", require("oil").open, { desc = "Open file explorer" })
      
      require("telescope").setup({
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              preview_width = 0.55,
            },
          },
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = false,
            respect_gitignore = true,
          },
        },
      })
      
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
      vim.keymap.set("n", "<leader>fs", builtin.grep_string, { desc = "Grep string" })
      vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Commands" })
      
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 100 },
          { name = "luasnip", priority = 75 },
          { name = "buffer", priority = 50 },
          { name = "path", priority = 40 },
        }),
        formatting = {
          format = function(_, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[vim_item.menu] or vim_item.menu
            return vim_item
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
      
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      local on_attach = function(client, bufnr)
        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
        
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "References" })
        vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, { buffer = bufnr, desc = "Format file" })
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc = "Add workspace folder" })
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, desc = "Remove workspace folder" })
      end
      
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          spacing = 4,
        },
        severity_sort = true,
        float = {
          source = true,
          border = "rounded",
        },
      })
      
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })
      
      vim.lsp.config("clangd", {
        cmd = { "clangd" },
        capabilities = capabilities,
        on_attach = on_attach,
      })
      
      vim.lsp.config("rust_analyzer", {
        cmd = { "rust-analyzer" },
        capabilities = capabilities,
        on_attach = on_attach,
      })
      
      vim.lsp.config("gopls", {
        cmd = { "gopls" },
        capabilities = capabilities,
        on_attach = on_attach,
      })
      
      vim.lsp.config("nixd", {
        cmd = { "nixd" },
        capabilities = capabilities,
        on_attach = on_attach,
      })
      
      vim.lsp.config("lua_ls", {
        cmd = { "lua-language-server" },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
            },
          },
        },
      })
      
      vim.lsp.enable({ "clangd", "rust_analyzer", "gopls", "nixd", "lua_ls" })
      
      require("which-key").setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
        },
        win = {
          border = "rounded",
          padding = { 2, 2 },
        },
      })
      
      vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
      vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to down window" })
      vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to up window" })
      vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
      
      vim.keymap.set("n", "<leader>h", ":split<CR>", { desc = "Split horizontally" })
      vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { desc = "Split vertically" })
      
      vim.keymap.set("n", "[b", ":bprevious<CR>", { desc = "Previous buffer" })
      vim.keymap.set("n", "]b", ":bnext<CR>", { desc = "Next buffer" })
      vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
      
      vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without register" })
      
      vim.keymap.set("n", "<leader>y", [["+y]], { desc = "Yank to clipboard" })
      vim.keymap.set("v", "<leader>y", [["+y]], { desc = "Yank to clipboard" })
      vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to clipboard" })
    '';
  };
}

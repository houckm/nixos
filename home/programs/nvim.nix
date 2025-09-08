{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    
    plugins = with pkgs.vimPlugins; [
      # Essential dependencies
      plenary-nvim
      nvim-web-devicons
      
      # File navigation & fuzzy finding
      telescope-nvim
      telescope-fzf-native-nvim
      
      # File tree
      nvim-tree-lua
      
      # Syntax highlighting
      (nvim-treesitter.withPlugins (p: [
        p.bash
        p.c
        p.css
        p.html
        p.javascript
        p.json
        p.lua
        p.markdown
        p.nix
        p.python
        p.rust
        p.typescript
        p.yaml
      ]))
      
      # LSP & completion
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      
      # Git integration
      gitsigns-nvim
      fugitive
      
      # Status line
      lualine-nvim
      
      # Color scheme
      catppuccin-nvim
      
      # Utilities
      comment-nvim
      nvim-autopairs
      indent-blankline-nvim
      which-key-nvim
      nvim-surround
    ];
    
    extraLuaConfig = ''
      -- Basic settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
      vim.opt.smartindent = true
      vim.opt.wrap = false
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.incsearch = true
      vim.opt.hlsearch = false
      vim.opt.scrolloff = 8
      vim.opt.signcolumn = "yes"
      vim.opt.updatetime = 50
      vim.opt.termguicolors = true
      
      -- Set leader key
      vim.g.mapleader = " "
      
      -- Colorscheme
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
      })
      vim.cmd.colorscheme "catppuccin"
      
      -- Treesitter
      require'nvim-treesitter.configs'.setup {
        highlight = { enable = true },
        indent = { enable = true },
      }
      
      -- Telescope
      require('telescope').setup{
        defaults = {
          mappings = {
            i = {
              ["<C-h>"] = "which_key"
            }
          }
        }
      }
      require('telescope').load_extension('fzf')
      
      -- Telescope keymaps
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
      
      -- Nvim-tree
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
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true })
      
      -- LSP Configuration
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      -- Enable some language servers
      local servers = { 'nil_ls', 'pyright', 'ts_ls', 'rust_analyzer' }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          capabilities = capabilities,
        }
      end
      
      -- LSP keymaps
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
      
      -- Completion setup
      local cmp = require'cmp'
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        })
      })
      
      -- Gitsigns
      require('gitsigns').setup()
      
      -- Lualine
      require('lualine').setup {
        options = {
          theme = 'catppuccin'
        }
      }
      
      -- Comment.nvim
      require('Comment').setup()
      
      -- Autopairs
      require('nvim-autopairs').setup({
        check_ts = true,
      })
      
      -- Indent blankline
      require("ibl").setup()
      
      -- Which-key
      require("which-key").setup()
      
      -- Surround
      require("nvim-surround").setup()
      
      -- General keymaps
      vim.keymap.set('n', '<leader>w', ':w<CR>', { silent = true })
      vim.keymap.set('n', '<leader>q', ':q<CR>', { silent = true })
      vim.keymap.set('n', '<leader>x', ':x<CR>', { silent = true })
      
      -- Better window navigation
      vim.keymap.set('n', '<C-h>', '<C-w>h')
      vim.keymap.set('n', '<C-j>', '<C-w>j')
      vim.keymap.set('n', '<C-k>', '<C-w>k')
      vim.keymap.set('n', '<C-l>', '<C-w>l')
      
      -- Buffer navigation
      vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { silent = true })
      vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { silent = true })
      vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { silent = true })
    '';
  };
  
  # LSP servers and tools  
  home.packages = with pkgs; [
    # Language servers
    nil              # Nix LSP
    pyright          # Python LSP
    typescript-language-server  # Moved out of nodePackages too
    rust-analyzer
    
    # Additional tools
    ripgrep          # Required for telescope live_grep
    fd               # Better find, used by telescope
  ];
}

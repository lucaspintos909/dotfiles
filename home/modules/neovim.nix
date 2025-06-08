{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    plugins = with pkgs.vimPlugins; [
      # File explorer
      nvim-tree-lua
      
      # Status line
      lualine-nvim
      nvim-web-devicons
      
      # Syntax highlighting
      nvim-treesitter.withAllGrammars
      
      # LSP support
      nvim-lspconfig
      
      # Autocompletion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      luasnip
      cmp_luasnip
      
      # Fuzzy finder
      telescope-nvim
      plenary-nvim
      
      # Git integration
      gitsigns-nvim
      
      # Color scheme
      tokyonight-nvim
      
      # Better commenting
      comment-nvim
      
      # Auto pairs
      nvim-autopairs
      
      # Indentation guides
      indent-blankline-nvim
      
      # Which key helper
      which-key-nvim
      
      # Better buffer management
      bufferline-nvim
      
      # Terminal integration
      toggleterm-nvim
    ];
    
    extraConfig = ''
      " General settings
      set number
      set relativenumber
      set tabstop=2
      set shiftwidth=2
      set expandtab
      set smartindent
      set wrap
      set ignorecase
      set smartcase
      set incsearch
      set hlsearch
      set scrolloff=8
      set sidescrolloff=8
      set mouse=a
      set clipboard=unnamedplus
      set updatetime=250
      set timeoutlen=500
      set splitbelow
      set splitright
      set termguicolors
      
      " Leader key
      let mapleader = " "
      
      " Basic keymaps
      nnoremap <leader>w :w<CR>
      nnoremap <leader>q :q!<CR>
      nnoremap <leader>x :x<CR>
      nnoremap <leader>h :noh<CR>
      
      " Window navigation
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l
      
      " Resize windows
      nnoremap <C-Up> :resize +2<CR>
      nnoremap <C-Down> :resize -2<CR>
      nnoremap <C-Left> :vertical resize -2<CR>
      nnoremap <C-Right> :vertical resize +2<CR>
      
      " Better indenting
      vnoremap < <gv
      vnoremap > >gv
      
      " Move lines up and down
      nnoremap <A-j> :m .+1<CR>==
      nnoremap <A-k> :m .-2<CR>==
      inoremap <A-j> <Esc>:m .+1<CR>==gi
      inoremap <A-k> <Esc>:m .-2<CR>==gi
      vnoremap <A-j> :m '>+1<CR>gv=gv
      vnoremap <A-k> :m '<-2<CR>gv=gv
    '';
    
    # Load Lua configuration from separate file
    extraLuaConfig = builtins.readFile ./neovim/init.lua;
  };
}

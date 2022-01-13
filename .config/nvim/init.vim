"--------------------------------------------------------------------------
" General settings
"--------------------------------------------------------------------------

set number
set autoindent
set ruler
set hidden

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

syntax on

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

"--------------------------------------------------------------------------
" Key maps
"--------------------------------------------------------------------------

let mapleader = "\<space>"

nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nmap <leader>vr :source ~/.config/nvim/init.vim<cr>

" Allow gf to open non-existent files
map gf :edit <cfile><cr>

" Open the current file using the default program
nmap <leader>x :!xdg-open %<cr><cr>

" Save file using sudo
cmap w!! %!sudo tee > /dev/null/ %

"--------------------------------------------------------------------------
" Plugins
"--------------------------------------------------------------------------

" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugins')

source ~/.config/nvim/plugins/vim-commentary.vim
source ~/.config/nvim/plugins/vim-surround.vim
source ~/.config/nvim/plugins/vim-fugitive.vim
source ~/.config/nvim/plugins/markdown-preview.vim
source ~/.config/nvim/plugins/nvim-lspconfig.vim
source ~/.config/nvim/plugins/editor-config.vim
source ~/.config/nvim/plugins/nerdtree.vim
source ~/.config/nvim/plugins/gitgutter.vim
source ~/.config/nvim/plugins/airline.vim
source ~/.config/nvim/plugins/fzf.vim

call plug#end()
" doautocmd User PlugLoaded

"--------------------------------------------------------------------------
" Misc
"-------------------------------------------------------------------------

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
    local nvim_lsp = require('lspconfig')

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      -- Enable completion triggered by <c-x><c-o>
      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      local opts = { noremap=true, silent=true }

      -- See `:help vim.lsp.*` for documentation on any of the below functions
      buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
      buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
      buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
      buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
      buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
      buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
      buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
      buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    end

    -- Use a loop to conveniently call 'setup' on multiple servers and
    -- map buffer local keybindings when the language server attaches
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local servers = { 'rust_analyzer' }
    for _, lsp in ipairs(servers) do
      nvim_lsp[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        }
      }
    end

    local project_library_path = "/Users/yaro/.nvm/versions/node/v14.18.2/lib/node_modules"
    local cmd = {"node", "/Users/yaro/.nvm/versions/node/v14.18.2/lib/node_modules/@angular/language-server","--stdio", "--tsProbeLocations", project_library_path , "--ngProbeLocations", project_library_path}

    nvim_lsp.angularls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = cmd,
        on_new_config = function(new_config,new_root_dir)
            new_config.cmd = cmd
        end,
    }

    require'lspconfig'.omnisharp.setup{
        on_attach = on_attach,
        cmd = { "/usr/local/bin/omnisharp-osx-arm64-net6.0/Omnisharp", "--languageserver" , "--hostPID", tostring(pid) },
        capabilities = capabilities
    }

EOF

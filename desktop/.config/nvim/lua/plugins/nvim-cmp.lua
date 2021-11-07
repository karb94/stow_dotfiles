-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = {
    -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-k>'] = cmp.mapping.select_prev_item({ cmp.SelectBehavior.Select }),
    ['<C-j>'] = cmp.mapping.select_next_item({ cmp.SelectBehavior.Select }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp', keyword_length = 3 },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
      { name = 'buffer', keyword_length = 3 },
    })
})

local servers = {
  "pyright",
  "clangd",
  "bashls",
  "texlab",
  "vimls",
}

for _, lsp in ipairs(servers) do
  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    require('lspconfig')[lsp].setup {
    capabilities = capabilities
  }
end

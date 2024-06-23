--[[ Kickstart.nvim ]]

-- See `:help cmp`
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
luasnip.config.setup({})

cmp.setup({
	formatting = {
		format = lspkind.cmp_format({}),
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = { completeopt = "menu,menuone,noinsert" },

	-- read `:help ins-completion`
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(), -- [n]ext item
		["<C-p>"] = cmp.mapping.select_prev_item(), -- [p]revious item
		["<C-b>"] = cmp.mapping.scroll_docs(-4), -- [b]ack
		["<C-f>"] = cmp.mapping.scroll_docs(4), -- [f]orward
		["<C-y>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }), -- Accept ([y]es)
		["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }), -- Accept ([y]es)

		-- Show completion menu or confirm suggestion
		["<C-Space>"] = cmp.mapping(function()
			if not cmp.visible() then
				cmp.complete()
			else
				cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
			end
		end, { "i", "s" }),

		["<Tab>"] = cmp.mapping(function(fallback)
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
		--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "nvim_lsp_signature_help" },
	},
})

require("nvim-autopairs").setup({})
-- automatically add `(` after selecting a function or method
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

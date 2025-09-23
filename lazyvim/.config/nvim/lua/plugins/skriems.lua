return {
  {
    -- Lokales Plugin per Pfad
    dir = "~/.config/nvim/lua/dev/skriems", -- absoluter Pfad
    name = "skriems", -- interner Name (optional, aber hilfreich)
    dev = true, -- markiert als Dev-Plugin (kein Update via Git)
    -- Optional: Lazy-Load steuern
    cmd = { "Skriems" }, -- lädt bei :MyHello
    -- keys = { { "<leader>mh", "<cmd>MyHello<cr>", desc = "My Hello" } },
    -- config = function() require("myplugin").setup({ ... }) end, -- falls du setup anbietest
  },
}

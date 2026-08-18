return {
  "mrcjkb/rustaceanvim",
  opts = {
    server = {
      default_settings = {
        ["rust-analyzer"] = {
          lens = {
            debug = { enable = true },
            enable = true,
            implementations = { enable = true },
            references = {
              adt = { enable = true },
              enumVariant = { enable = true },
              method = { enable = true },
              trait = { enable = true },
            },
            run = { enable = true },
            updateTest = { enable = true },
          },
        },
      },
    },
  },
}

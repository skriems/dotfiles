return {
  opts = function(opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.filetypes = require("astronvim.utils").list_insert_unique(opts.filetypes, {
      "html",
    })
    return opts
  end,
}

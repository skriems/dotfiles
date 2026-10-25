return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        -- Markdownlint treats MDX's JSX elements as forbidden inline HTML.
        ["markdown.mdx"] = {},
      },
    },
  },
}

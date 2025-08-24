local function find_config(bufnr, config_files)
  return vim.fs.find(config_files, {
    upward = true,
    stop = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
  })[1]
end

local function get_formatter(bufnr)
  local has_biome_config = find_config(bufnr, { "biome.json", "biome.jsonc" })

  -- vim.notify("Checking for Biome config: " .. tostring(has_biome_config), vim.log.levels.DEBUG)

  if has_biome_config then
    return { "biome-check", stop_after_first = true }
  end

  local has_eslint_config = find_config(bufnr, {
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    ".eslintrc",
    ".eslintrc.json",
    ".eslintrc.yml",
    ".eslintrc.yaml",
    ".eslintrc.json5",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.toml",
  })

  if has_eslint_config then
    return { "eslint", stop_after_first = true }
  end

  local has_prettier_config = find_config(bufnr, {
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.json5",
    ".prettierrc.js",
    ".prettierrc.cjs",
    ".prettierrc.toml",
    "prettier.config.js",
    "prettier.config.cjs",
  })

  if has_prettier_config then
    return { "prettier", stop_after_first = true }
  end

  -- Default to Biome if no config is found
  return { "biome-check", stop_after_first = true }
end

local filetypes_with_dynamic_formatter = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "vue",
  "css",
  "scss",
  "less",
  "html",
  "json",
  "jsonc",
  "yaml",
  "markdown",
  "markdown.mdx",
  "graphql",
  "handlebars",
}

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = (function()
        local result = {}
        for _, ft in ipairs(filetypes_with_dynamic_formatter) do
          result[ft] = get_formatter
        end
        return result
      end)(),
    },
  },
}

return {
  'David-Kunz/gen.nvim',
  lazy = false,
  opts = {
    model = 'llama3',       -- The default model to use.
    display_mode = 'float', -- The display mode. Can be "float" or "split".
    show_prompt = false,    -- Shows the Prompt submitted to Ollama.
    show_model = false,     -- Displays which model you are using at the beginning of your chat session.
    no_auto_close = false,  -- Never closes the window automatically.
    debug = true,           -- Prints errors and the command which is run.

    init = function()
      pcall(io.popen, 'ollama serve > /dev/null 2>&1 &')
    end,
    command = function(options)
      local body = { model = options.model, stream = true }
      return 'curl --silent --no-buffer -X POST http://' .. options.host .. ':' .. options.port .. '/api/chat -d $body'
    end,
    list_models = '<omitted lua function>', -- Retrieves a list of model names
  },
  keys = {
    { mode = 'n', '<leader>O',  ':Gen<cr>',                          desc = 'Ollama' },
    { mode = 'v', '<leader>O',  ':Gen<cr>',                          desc = 'Ollama' },
    { mode = 'v', '<leader>Og', ':Gen Enhance_Grammar_Spelling<CR>', desc = 'Ollama' },
  },
}

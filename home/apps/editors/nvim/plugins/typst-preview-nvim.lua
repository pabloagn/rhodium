require("typst-preview").setup({
  debug = false,
  open_cmd = "firefox --new-window -P Ultra %s",

  -- Custom port to open the preview server.
  port = 63000,

  -- Color inversion for dark/light modes
  invert_colors = "never",

  -- Whether the preview will follow the cursor in the source file
  follow_cursor = true,

  -- Paths to binaries for dependencies.
  dependencies_bin = {
    ["tinymist"] = nil,
    ["websocat"] = nil,
  },

  -- A list of extra arguments (or nil) to be passed to previewer.
  -- For example, extra_args = { "--input=ver=draft", "--ignore-system-fonts" }
  extra_args = nil,

  -- This function will be called to determine the root of the typst project
  get_root = function(path_of_main_file)
    local root = os.getenv("TYPST_ROOT")
    if root then
      return root
    end
    return vim.fn.fnamemodify(path_of_main_file, ":p:h")
  end,

  -- This function will be called to determine the main file of the typst
  -- project.
  get_main_file = function(path_of_buffer)
    return path_of_buffer
  end,
})

-- table as a list of (mapping, opts) pairs to be registered in "which-key" plugin
return {
  {
    {
      f = {
        name = "file", -- optional group name
        t = { "<cmd>Neotree toggle<cr>", "Neotree Toggle" }, -- create a binding with label
        n = { "New File" }, -- just a label. don't create any mapping
        e = "Edit File", -- same as above
        b = { function() print("bar") end, "Foobar" },
        f = { function() require("telescope.builtin").find_files() end, "Find Files" },
      },
    },
    { prefix = "<leader>" }
  },
}

return {
  {
    "folke/sidekick.nvim",
    opts = {
      -- 1. Focus strictly on NES (Next Edit Suggestions)
      nes = {
        enabled = true,
        display = "float", -- Using floating windows is more stable on Windows Terminal
      },
      -- 2. Kill the "CLI" features that break on Windows
      cli = {
        mux = {
          enabled = false, -- THIS IS CRITICAL: Stops Sidekick from looking for Zellij/Tmux
        },
      },
    },
    keys = {
      -- Custom Tab behavior: Jump to suggestion if it exists, otherwise do normal Tab
      {
        "<tab>",
        function()
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>"
          end
        end,
        expr = true,
        desc = "Jump to/Apply Next Edit",
      },
    },
  },
}

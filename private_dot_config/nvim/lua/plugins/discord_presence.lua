return {
  "andweeb/presence.nvim",
  lazy = false,
  config = function()
    require("presence").setup ({
      auto_update = true,
      main_image = "file",
      neovim_image_text = "Living Inside Vim 🧙",
      enable_line_number = true,
      show_time = true,
      editing_text = "Editing %s",
      file_explorer_text = "Browsing %s",
      git_commit_text = "Committing changes",
      plugin_manager_text = "Managing plugins",
      reading_text = "Reading %s",
      workspace_text = "Working on %s",
      line_number_text = "Line %s out of %s",
    })
  end,
}

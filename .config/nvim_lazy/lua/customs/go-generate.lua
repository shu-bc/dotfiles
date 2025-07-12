local utils = require("customs.utils")

local function go_generate()
  local file_path = utils.get_current_file_relative_path()
  if not file_path then
    return
  end

  vim.notify("Running go generate on " .. file_path, vim.log.levels.INFO)

  local cmd = "go generate " .. file_path
  local result = vim.fn.system(cmd)
  local exit_code = vim.v.shell_error

  if exit_code == 0 then
    vim.notify("go generate completed successfully", vim.log.levels.INFO)
  else
    vim.notify("go generate failed: " .. result, vim.log.levels.ERROR)
  end
end

vim.api.nvim_create_user_command("GoGenerate", go_generate, {
  desc = "Run go generate on the current file",
})

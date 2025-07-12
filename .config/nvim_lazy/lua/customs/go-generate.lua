local utils = require("customs.utils")

local function go_generate()
  local file_path = utils.get_current_file_relative_path()
  if not file_path then
    return
  end

  vim.notify("Running go generate on " .. file_path, vim.log.levels.INFO)

  local cmd = { "go", "generate", file_path }
  local output = {}

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then
        vim.list_extend(output, data)
      end
    end,
    on_stderr = function(_, data)
      if data then
        vim.list_extend(output, data)
      end
    end,
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        vim.notify("go generate completed successfully", vim.log.levels.INFO)
      else
        local error_msg = table.concat(output, "\n")
        if error_msg == "" then
          error_msg = "Unknown error"
        end
        vim.notify("go generate failed: " .. error_msg, vim.log.levels.ERROR)
      end
    end,
  })
end

vim.api.nvim_create_user_command("GoGenerate", go_generate, {
  desc = "Run go generate on the current file",
})

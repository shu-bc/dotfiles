local utils = {}

-- get current file relative path from git root
utils.get_current_file_relative_path = function()
  local current_file = vim.fn.expand("%:p")
  if current_file == "" then
    vim.notify("No file in current buffer", vim.log.levels.ERROR)
    return nil
  end

  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if not git_root or git_root == "" then
    vim.notify("Not inside a Git repository", vim.log.levels.ERROR)
    return nil
  end

  return "./" .. current_file:gsub(git_root .. "/", "")
end

utils.get_current_directory_relative_path = function()
  local current_file = utils.get_current_file_relative_path()

  -- strip file name from path
  return current_file and current_file:match("(.*/)")
end

-- get git root from current working directory
utils.get_git_root = function()
  local result = vim.fn.systemlist("git rev-parse --show-toplevel")
  print(result)
  if #result == 0 then
    vim.notify("Not inside a Git repository", vim.log.levels.ERROR)
    return nil
  end
  local git_root = result[1]
  if not git_root or git_root == "" then
    vim.notify("Not inside a Git repository", vim.log.levels.ERROR)
    return nil
  end
  return git_root
end

return utils

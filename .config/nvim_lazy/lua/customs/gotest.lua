local function run_package_test()
  local current_file = vim.fn.expand("%:p")
  if current_file == "" then
    vim.notify("No file in current buffer", vim.log.levels.ERROR)
    return
  end

  local package_dir = vim.fn.fnamemodify(current_file, ":h")

  local cmd = string.format("cd %s && go test -v -json", vim.fn.shellescape(package_dir))

  local json_lines = {}

  vim.fn.jobstart(cmd, {
    on_stdout = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(json_lines, line)
          end
        end
      end
    end,
    on_stderr = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            vim.notify(line, vim.log.levels.ERROR)
          end
        end
      end
    end,
    on_exit = function(_, code)
      -- First pass: collect all test outputs
      local test_outputs = {}
      for _, line in ipairs(json_lines) do
        local ok, parsed = pcall(vim.json.decode, line)
        if ok and parsed.Action == "output" and parsed.Test then
          if not test_outputs[parsed.Test] then
            test_outputs[parsed.Test] = {}
          end
          table.insert(test_outputs[parsed.Test], parsed.Output)
        end
      end

      -- Second pass: identify failed tests
      local failed_test_names = {}
      for _, line in ipairs(json_lines) do
        local ok, parsed = pcall(vim.json.decode, line)
        if ok and parsed.Action == "fail" and parsed.Test then
          table.insert(failed_test_names, parsed.Test)
        end
      end

      if code == 0 then
        vim.notify("Tests passed successfully", vim.log.levels.INFO)
      else
        if #failed_test_names > 0 then
          local failure_report = {}
          for _, test_name in ipairs(failed_test_names) do
            failure_report[#failure_report + 1] = "FAIL: " .. test_name
            if test_outputs[test_name] then
              for _, output in ipairs(test_outputs[test_name]) do
                if type(output) == "string" then
                  failure_report[#failure_report + 1] = output:gsub("\n$", "")
                else
                  failure_report[#failure_report + 1] = tostring(output)
                end
              end
            end
            failure_report[#failure_report + 1] = ""
          end
          vim.notify(table.concat(failure_report, "\n"), vim.log.levels.ERROR)
        else
          vim.notify("Tests failed with exit code: " .. code, vim.log.levels.ERROR)
        end
      end
    end,
  })
end

local function get_test_function_at_cursor()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local cursor_row = cursor_pos[1] - 1 -- Convert to 0-based indexing

  local query = vim.treesitter.query.parse(
    "go",
    [[
      (function_declaration
        name: (identifier) @name
        (#match? @name "^Test")
      ) @func
    ]]
  )

  local parser = vim.treesitter.get_parser(bufnr, "go")
  local tree = parser:parse()[1]
  local root = tree:root()

  for id, node in query:iter_captures(root, bufnr) do
    local capture_name = query.captures[id]
    if capture_name == "func" then
      local start_row, _, end_row, _ = node:range()
      if cursor_row >= start_row and cursor_row <= end_row then
        -- Find the name node within this function
        for name_id, name_node in query:iter_captures(node, bufnr) do
          if query.captures[name_id] == "name" then
            return vim.treesitter.get_node_text(name_node, bufnr)
          end
        end
      end
    end
  end

  return nil
end

local function run_test_function()
  local test_name = get_test_function_at_cursor()
  if not test_name then
    vim.notify("No test function found at cursor position", vim.log.levels.ERROR)
    return
  end

  local current_file = vim.fn.expand("%:p")
  if current_file == "" then
    vim.notify("No file in current buffer", vim.log.levels.ERROR)
    return
  end

  local package_dir = vim.fn.fnamemodify(current_file, ":h")
  local cmd = string.format(
    "cd %s && go test -v -json -run %s",
    vim.fn.shellescape(package_dir),
    vim.fn.shellescape("^" .. test_name .. "$")
  )

  local json_lines = {}

  vim.fn.jobstart(cmd, {
    on_stdout = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(json_lines, line)
          end
        end
      end
    end,
    on_stderr = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            vim.notify(line, vim.log.levels.ERROR)
          end
        end
      end
    end,
    on_exit = function(_, code)
      -- First pass: collect all test outputs
      local test_outputs = {}
      for _, line in ipairs(json_lines) do
        local ok, parsed = pcall(vim.json.decode, line)
        if ok and parsed.Action == "output" and parsed.Test then
          if not test_outputs[parsed.Test] then
            test_outputs[parsed.Test] = {}
          end
          table.insert(test_outputs[parsed.Test], parsed.Output)
        end
      end

      -- Second pass: identify failed tests
      local failed_test_names = {}
      for _, line in ipairs(json_lines) do
        local ok, parsed = pcall(vim.json.decode, line)
        if ok and parsed.Action == "fail" and parsed.Test then
          table.insert(failed_test_names, parsed.Test)
        end
      end

      if code == 0 then
        vim.notify("Test " .. test_name .. " passed successfully", vim.log.levels.INFO)
      else
        if #failed_test_names > 0 then
          local failure_report = {}
          for _, failed_test_name in ipairs(failed_test_names) do
            failure_report[#failure_report + 1] = "FAIL: " .. failed_test_name
            if test_outputs[failed_test_name] then
              for _, output in ipairs(test_outputs[failed_test_name]) do
                if type(output) == "string" then
                  failure_report[#failure_report + 1] = output:gsub("\n$", "")
                else
                  failure_report[#failure_report + 1] = tostring(output)
                end
              end
            end
            failure_report[#failure_report + 1] = ""
          end
          vim.notify(table.concat(failure_report, "\n"), vim.log.levels.ERROR)
        else
          vim.notify("Test " .. test_name .. " failed with exit code: " .. code, vim.log.levels.ERROR)
        end
      end
    end,
  })
end

vim.api.nvim_create_user_command("GoTest", run_package_test, {})
vim.api.nvim_create_user_command("GoTestFunc", run_test_function, {})

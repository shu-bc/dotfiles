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

vim.api.nvim_create_user_command("GoTest", run_package_test, {})

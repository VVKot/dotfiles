vim.g["test#java#runner"] = "gradletest"
vim.g["test#javascript#runner"] = "jest"
vim.g["test#strategy"] = "neovim"
vim.g["test#javascript#jest#options"] = { all = "--silent" }

local last_test_cwd = ""

local does_file_require_changing_cwd = function()
  local ft = vim.bo.filetype
  return ft == "javascript" or ft == "typescript"
end

local call_with_test_directory_as_cwd = function(command)
  if not does_file_require_changing_cwd() then
    vim.api.nvim_command(command)
    return
  end

  local cwd = vim.api.nvim_eval("getcwd()")
  vim.o.autochdir = true
  last_test_cwd = vim.api.nvim_eval("getcwd()")
  vim.api.nvim_command(command)
  vim.o.autochdir = false
  vim.api.nvim_command("cd " .. cwd)
end

local call_with_last_test_cwd = function(command)
  if not does_file_require_changing_cwd() then
    vim.api.nvim_command(command)
    return
  end

  local cwd = vim.api.nvim_eval("getcwd()")
  vim.api.nvim_command("cd " .. last_test_cwd)
  vim.api.nvim_command(command)
  vim.api.nvim_command("cd " .. cwd)
end

vim.keymap.set("n", "<Leader>jh", function()
  call_with_test_directory_as_cwd("TestSuite")
end)
vim.keymap.set("n", "<Leader>jj", function()
  call_with_test_directory_as_cwd("TestFile")
end)
vim.keymap.set("n", "<Leader>jk", function()
  call_with_test_directory_as_cwd("TestNearest")
end)
vim.keymap.set("n", "<Leader>jl", function()
  call_with_last_test_cwd("TestLast")
end)
vim.keymap.set("n", "<Leader>j;", function()
  call_with_last_test_cwd("TestVisit")
end)

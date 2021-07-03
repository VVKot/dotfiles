-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/kot/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/kot/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/kot/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/kot/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/kot/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  MatchTag = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/MatchTag"
  },
  ["astronauta.nvim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/astronauta.nvim"
  },
  ["conflict-marker.vim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/conflict-marker.vim"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/editorconfig-vim"
  },
  ["express_line.nvim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/express_line.nvim"
  },
  fzf = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["git-messenger.vim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/git-messenger.vim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["glow.nvim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/glow.nvim"
  },
  harpoon = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/harpoon"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["neuron.nvim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/neuron.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    needs_bufread = false,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/opt/nvim-autopairs"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-jqx"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/nvim-jqx"
  },
  ["nvim-lightbulb"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/nvim-lightbulb"
  },
  ["nvim-lsp-ts-utils"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/nvim-lsp-ts-utils"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-treesitter-textsubjects"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textsubjects"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["open-browser.vim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/open-browser.vim"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["remote-viewer"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/remote-viewer"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim"
  },
  ["telescope-ultisnips.nvim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/telescope-ultisnips.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ultisnips = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  undotree = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/undotree"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-abolish"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-dirvish"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-dirvish"
  },
  ["vim-dispatch"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-dispatch"
  },
  ["vim-dispatch-neovim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-dispatch-neovim"
  },
  ["vim-doge"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-doge"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-exchange"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-exchange"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-go"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/opt/vim-go"
  },
  ["vim-markdown"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-markdown"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-rhubarb"
  },
  ["vim-scriptease"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-scriptease"
  },
  ["vim-sensible"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-sensible"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-sleuth"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-test"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vista.vim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/vista.vim"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  },
  ["zen-mode.nvim"] = {
    loaded = true,
    path = "/Users/kot/.local/share/nvim/site/pack/packer/start/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: nvim-autopairs
time([[Setup for nvim-autopairs]], true)
try_loadstring("\27LJ\2\nê\1\0\0\3\0\6\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0029\0\2\0005\2\5\0B\0\2\1K\0\1\0\1\0\1\vmap_cr\2$nvim-autopairs.completion.compe\1\0\1\rcheck_ts\2\nsetup\19nvim-autopairs\frequire\0", "setup", "nvim-autopairs")
time([[Setup for nvim-autopairs]], false)
time([[packadd for nvim-autopairs]], true)
vim.cmd [[packadd nvim-autopairs]]
time([[packadd for nvim-autopairs]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType go ++once lua require("packer.load")({'vim-go'}, { ft = "go" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/kot/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]], true)
vim.cmd [[source /Users/kot/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]]
time([[Sourcing ftdetect script at: /Users/kot/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: ".v:exception | echom "Please check your config for correctness" | echohl None')
end

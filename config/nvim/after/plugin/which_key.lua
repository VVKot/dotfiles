local wk = require("which-key")

wk.setup()

wk.register({
  ["<Leader>f"] = {
    name = "+file",
    f = { "Find with FZF" },
    t = { "Find with Telescope" },
    c = { "Find commits" },
    b = { "Find buffers" },
    ["<Leader>"] = { "Find in buffer" },
    m = { "Find marks" },
    w = { "Find this string" },
    [":"] = { "Find commands" },
    ["/"] = { "Find searches" },
    u = { "Find snippets" },
  },
  ["<Leader>g"] = {
    name = "+go/git",
    h = { "Peek definition" },
    g = { "Git status" },
    t = { "Git status Telescope" },
  },
  ["<Leader>t"] = {
    name = "+tree/telescope/terminal",
    t = { "Telescope commands" },
    f = { "Tree explorer" },
    u = { "Undo tree" },
    ["1"] = { "Terminal 1" },
    ["2"] = { "Terminal 2" },
    ["3"] = { "Terminal 3" },
    ["4"] = { "Terminal 4" },
  },
  ["<Leader>j"] = {
    name = "+test",
    h = { "Test suite" },
    j = { "Test file" },
    k = { "Test nearest" },
    l = { "Test last" },
    [";"] = { "Test visit" },
  },
})

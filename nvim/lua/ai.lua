-- AI ghost-text completion with a switchable provider.
--   <leader>ai  turn completion on/off (also <leader>?, Cursor's Shift+Cmd+/)
--   <leader>ap  switch provider (windsurf <-> copilot)
--   <Tab>       accept the suggestion (falls back to a normal Tab)
-- The choice survives restarts. First use of each provider needs a sign-in:
-- :Codeium Auth for windsurf, :Copilot auth for copilot.
local M = {}

local PROVIDERS = { "windsurf", "copilot" }
local PLUGIN = { windsurf = "windsurf.nvim", copilot = "copilot.lua" }
local state_file = vim.fn.stdpath("state") .. "/ai.json"

M.state = { provider = "windsurf", enabled = true }
local loaded = {}

local function save()
  vim.fn.writefile({ vim.json.encode(M.state) }, state_file)
end

local function load()
  local ok, lines = pcall(vim.fn.readfile, state_file)
  if ok and lines[1] then
    local decoded_ok, decoded = pcall(vim.json.decode, lines[1])
    if decoded_ok and type(decoded) == "table" then
      M.state = vim.tbl_extend("force", M.state, decoded)
    end
  end
end

local function start(provider)
  if not loaded[provider] then
    require("lazy").load({ plugins = { PLUGIN[provider] } })
    loaded[provider] = true
    return -- loading the plugin starts it
  end
  if provider == "copilot" then
    require("copilot.command").enable()
  else
    require("codeium").enable()
  end
end

local function stop(provider)
  if not loaded[provider] then return end
  if provider == "copilot" then
    require("copilot.command").disable()
  else
    require("codeium").disable()
  end
end

local function apply()
  for _, p in ipairs(PROVIDERS) do
    if M.state.enabled and p == M.state.provider then start(p) else stop(p) end
  end
  vim.cmd.redrawstatus({ bang = true })
end

function M.toggle()
  M.state.enabled = not M.state.enabled
  apply()
  save()
  vim.notify("AI completion " .. (M.state.enabled and ("on (" .. M.state.provider .. ")") or "off"))
end

function M.switch()
  M.state.provider = M.state.provider == "windsurf" and "copilot" or "windsurf"
  M.state.enabled = true
  apply()
  save()
  vim.notify("AI completion: " .. M.state.provider)
end

-- Short label for the winbar, empty when off.
function M.status()
  if not M.state.enabled then return "" end
  return M.state.provider == "copilot" and "AI:copilot" or "AI:windsurf"
end

local function accept()
  if M.state.enabled and loaded[M.state.provider] then
    if M.state.provider == "copilot" then
      if require("copilot.suggestion").is_visible() then
        return "<Cmd>lua require('copilot.suggestion').accept()<CR>"
      end
    else
      local vt = require("codeium.virtual_text")
      if vt.get_current_completion_item() then
        return vt.accept() -- returns the keys that insert the completion
      end
    end
  end
  return "<Tab>"
end

function M.setup()
  load()
  vim.keymap.set("i", "<Tab>", accept, { expr = true, silent = true, desc = "Accept AI suggestion" })
  vim.keymap.set("n", "<leader>ai", M.toggle, { desc = "Toggle AI completion" })
  vim.keymap.set("n", "<leader>?", M.toggle, { desc = "Toggle AI completion" })
  vim.keymap.set("n", "<leader>ap", M.switch, { desc = "Switch AI provider" })
  -- Defer so startup isn't blocked by the language server download/launch.
  vim.defer_fn(apply, 100)
end

return M

-- Octo shows comment bodies as raw text, so review bots' HTML is unreadable.
-- Reduces it to markdown, keeping <details>/<summary> because Octo folds on them.
local M = {}

-- GraphQL logins, which have no [bot] suffix.
local BOTS = { "^greptile" }

local STRIP = {}
for tag in ("a img picture source sub sup p br b i strong em span div center"):gmatch("%S+") do
  STRIP[tag] = true
end
local ENTITIES = { nbsp = " ", amp = "&", lt = "<", gt = ">", quot = '"' }

local function clean_prose(text)
  -- Inline code can hold literal tags, so hide it from the tag stripping below.
  local code = {}
  text = text:gsub("`[^`\n]+`", function(span)
    code[#code + 1] = span
    return "\0" .. #code .. "\0"
  end)

  text = text:gsub("<!%-%-.-%-%->", "")
  text = text:gsub("<picture.-</picture>", "")
  text = text:gsub('<img[^>]-alt="([^"]*)"[^>]*>', "[%1]")
  text = text:gsub("<summary>%s*<h%d>(.-)</h%d>%s*</summary>", "<summary>%1</summary>")
  text = text:gsub("<h(%d)[^>]*>(.-)</h%d>", function(level, title)
    return "\n" .. string.rep("#", tonumber(level)) .. " " .. vim.trim(title) .. "\n"
  end)
  text = text:gsub("</?(%a%w*)[^>]*>", function(tag)
    if STRIP[tag:lower()] then return "" end
  end)
  text = text:gsub("&(%a+);", ENTITIES)
  text = text:gsub("\\(%p)", "%1")

  return (text:gsub("%z(%d+)%z", function(i) return code[tonumber(i)] end))
end

--- Cleans everything outside fenced code blocks.
function M.clean(body)
  local out, prose, fence = {}, {}, nil
  local function flush()
    if #prose > 0 then out[#out + 1] = clean_prose(table.concat(prose, "\n")) end
    prose = {}
  end
  for _, line in ipairs(vim.split(body:gsub("\r\n", "\n"), "\n", { plain = true })) do
    local ticks = line:match("^%s*(```+)")
    if fence then
      out[#out + 1] = line
      if ticks and #ticks >= fence and vim.trim(line) == ticks then fence = nil end
    elseif ticks then
      flush()
      out[#out + 1] = line
      fence = #ticks
    else
      prose[#prose + 1] = line
    end
  end
  flush()
  return vim.trim((table.concat(out, "\n"):gsub("\n%s*\n%s*\n+", "\n\n")))
end

local function is_bot(login)
  for _, pattern in ipairs(BOTS) do
    if login:match(pattern) then return true end
  end
  return false
end

function M.setup()
  local writers = require("octo.ui.writers")
  local write_comment = writers.write_comment
  writers.write_comment = function(bufnr, comment, ...)
    local login = comment.author and comment.author.login
    if login and comment.body and is_bot(login) then
      comment = vim.tbl_extend("force", comment, { body = M.clean(comment.body) })
    end
    return write_comment(bufnr, comment, ...)
  end
end

return M

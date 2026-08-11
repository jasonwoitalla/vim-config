-- Add the current git branch name to my bottom status line
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "BufWritePost", "User", "DirChanged", "BufReadPost" }, {
  group     =  vim.api.nvim_create_augroup("jasonwoitalla/git_branch",  { clear = true }),
  desc      =  "Save git branch to variable",
  pattern   =  { "*",  "OilEnter"  },
  callback  =  function()
    local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d \'\n\'")
    vim.b.branch_name = branch
  end
})

-- Special directories to show a condensed file path
local special_dirs = {
  HOME = "/Users/c080616",
  CODE = "/Users/c080616/code",
  OILCODE = "oil:/Users/c080616/code",
}

-- Icons powered by the "JetBrains Mono Nerd Fonts" font - font (or another nerd font) must be installed for icons to work
-- https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/JetBrainsMono
local icons = {}

icons.diagnostics = {
  ERROR = "",
  HINT  = "",
  INFO  = "",
  WARN  = "",
}

icons.arrows = {
  right = "",
}

icons.developer = {
  folder = "󰉋",
  git    = "",
}

icons.filetype = {
  css        = "",
  go         = "",
  html       = "",
  javascript = "",
  json       = "",
  lua        = "󰢱",
  markdown   = "",
  python     = "",
  rust       = "",
  typescript = "",
  yaml       = "",
}

-- Don't show the command that produced the quickfix list
vim.g.qf_disable_statusline = 1

-- Show the mode in my custom component instead
vim.opt.showmode = false

-- Disable global statusline
vim.opt.laststatus = 2

-- The status line object
local S = {}

function S.mode_component()
  local mode_to_str = {
    ["n"]     = "NORMAL",
    ["no"]    = "OP-PENDING",
    ["nov"]   = "OP-PENDING",
    ["noV"]   = "OP-PENDING",
    ["no\22"] = "OP-PENDING",
    ["niI"]   = "NORMAL",
    ["niR"]   = "NORMAL",
    ["niV"]   = "NORMAL",
    ["nt"]    = "NORMAL",
    ["ntT"]   = "NORMAL",
    ["v"]     = "VISUAL",
    ["vs"]    = "VISUAL",
    ["V"]     = "VISUAL",
    ["Vs"]    = "VISUAL",
    ["\22"]   = "VISUAL",
    ["\22s"]  = "VISUAL",
    ["s"]     = "SELECT",
    ["S"]     = "SELECT",
    ["\19"]   = "SELECT",
    ["i"]     = "INSERT",
    ["ic"]    = "INSERT",
    ["ix"]    = "INSERT",
    ["R"]     = "REPLACE",
    ["Rc"]    = "REPLACE",
    ["Rx"]    = "REPLACE",
    ["Rv"]    = "VIRT REPLACE",
    ["Rvc"]   = "VIRT REPLACE",
    ["Rvx"]   = "VIRT REPLACE",
    ["c"]     = "COMMAND",
    ["cv"]    = "VIM EX",
    ["ce"]    = "EX",
    ["r"]     = "PROMPT",
    ["rm"]    = "MORE",
    ["r?"]    = "CONFIRM",
    ["!"]     = "SHELL",
    ["t"]     = "TERMINAL",
  }

  local mode = mode_to_str[vim.api.nvim_get_mode().mode] or "UNKNOWN"

  local hl = "Other"
  if mode:find "NORMAL" then
    hl = "Normal"
  elseif mode:find "PENDING" then
    hl = "Pending"
  elseif mode:find "VISUAL" then
    hl = "Visual"
  elseif mode:find "INSERT" or mode:find "SELECT" then
    hl = "Insert"
  elseif mode:find "COMMAND" or mode:find "TERMINAL" or mode:find "EX" then
    hl = "Command"
  end

  return table.concat {
    string.format("%%#StatuslineModeSeparator%s#", hl),
    string.format("%%#StatuslineMode%s#%s", hl, mode),
    string.format("%%#StatuslineModeSeparator%s#", hl)
  }
end

function S.terminal_component()
  local mode = vim.api.nvim_get_mode().mode
  local hl = mode == "t" and "Insert" or "Normal"
  local mode_label = mode == "t" and "INSERT" or "NORMAL"

  return table.concat {
    string.format("%%#StatuslineModeSeparator%s#", hl),
    string.format("%%#StatuslineMode%s#%s", hl, mode_label),
    string.format("%%#StatuslineModeSeparator%s#", hl)
  }
end

function S.git_component()
  local branch_name = vim.b.branch_name
  return string.format("%%#StatuslineTitle#%s %s", icons.developer["git"], branch_name)
end

local last_diagnostic_component = "" -- Diagnostic cache for insert mode
function S.diagnostics_component()
  if vim.bo.filetype == "lazy" then
    return ""
  end

  if vim.startswith(vim.api.nvim_get_mode().mode, "i") then
    return last_diagnostic_component
  end

  local severity_init = {
    ERROR = 0,
    WARN = 0,
    HINT = 0,
    INFO = 0,
  }

  local counts = vim.iter(vim.diagnostic.get(0)):fold(severity_init, function(acc, diagnostic)
    local severity = vim.diagnostic.severity[diagnostic.severity]
    acc[severity] = acc[severity] + 1
    return acc
  end)

  local parts = vim.iter(counts)
      :map(function(severity, count)
        if count == 0 then
          return nil
        end

        local hl = "Diagnostic" .. severity:sub(1, 1) .. severity:sub(2):lower()
        return string.format("%%#%s#%s %d", hl, icons.diagnostics[severity], count)
      end)
      :totable()

  local component = table.concat(parts, " ")
  last_diagnostic_component = component
  return component
end

function S.filetype_component()
  local filetype = vim.bo.filetype
  if filetype == "" then
    filetype = "[No Name]"
  end
  local icon = icons.filetype[filetype]
  if icon == nil then
    icon = ""
  end
  return string.format("%%#StatuslineTitle#%s %s", icon, filetype)
end

function S.encoding_component()
  local encoding = vim.opt.fileencoding:get()
  return encoding ~= "" and string.format("%%#StatuslineModeSeparatorOther#%s", encoding) or ""
end

function S.position_component()
  local line = vim.fn.line "."
  local line_count = vim.api.nvim_buf_line_count(0)
  local col = vim.fn.virtcol "."

  return table.concat {
    "%#StatuslineItalic#l: ",
    string.format("%%#StatuslineTitle#%d", line),
    string.format("%%#StatuslineItalic#/%d c: %d", line_count, col)
  }
end

function S.render()
  local function concat_components(components)
    return vim.iter(components):skip(1):fold(components[1], function(acc, component)
      return #component > 0 and string.format("%s    %s", acc, component) or acc
    end)
  end

  if vim.bo.buftype == "terminal" then
    return table.concat {
      concat_components {
        S.terminal_component(),
        string.format("%%#StatuslineTitle#%s", "terminal")
      },
      "%#StatusLine#%=",
      S.position_component(),
      " ",
    }
  end

  return table.concat {
    concat_components {
      S.mode_component(),
      S.git_component(),
    },
    "%#StatusLine#%=",
    concat_components {
      S.diagnostics_component(),
      S.filetype_component(),
      S.encoding_component(),
      S.position_component(),
    },
    " ",
  }
end

-- Winbar
local W = {}

function W.render()
  local path = vim.fs.normalize(vim.fn.expand "%:p")

  if vim.startswith(path, "diffview") then
    return string.format("%#Winbar#%s", path)
  end

  local separator = "%#WinbarSeparator# > "

  local prefix, prefix_path = "", ""

  -- If the window is too small, shorten the path
  if vim.api.nvim_win_get_width(0) < math.floor(vim.o.columns / 3) then
    path = vim.fn.pathshorten(path)
  else
    for dir_name, dir_path in pairs(special_dirs) do
      if vim.startswith(path, vim.fs.normalize(dir_path)) and #dir_path > #prefix_path and prefix == "" then
        prefix, prefix_path = dir_name, dir_path
      end
    end

    if prefix ~= "" then
      path = path:gsub("^" .. prefix_path, "")
      prefix = string.format("%%#WinBarDir#%s %s%s", icons.developer["folder"], prefix, separator)
    end
  end

  path = path:gsub("^/", "")

  return table.concat {
    " ",
    prefix,
    table.concat(
      vim.iter(vim.split(path, "/"))
      :map(function(segment)
        return string.format("%%#Winbar#%s", segment)
      end)
      :totable(),
      separator
    ),
  }
end

-- Color scheme
local hl_groups = {}

local colors = {
  bright_white = "#FFFFFF",
  error_red    = "#DB5355",
  warn_yellow  = "#F6E07D",
}

local statusline_groups = {}
for mode, color in pairs {
  Normal   =  "iris",
  Pending  =  "pine",
  Visual   =  "gold",
  Insert   =  "foam",
  Command  =  "love",
  Other    =  "rose",
} do
  statusline_groups["StatuslineMode" .. mode] = { fg = "surface", bg = color }
  statusline_groups["StatuslineModeSeparator" .. mode] = { fg = color, bg = "surface" }
end

statusline_groups = vim.tbl_extend("error", statusline_groups, {
  StatuslineItalic = { fg = "subtle", bg = "surface", italic = true },
  StatuslineTitle  = { fg = colors.bright_white, bg = "surface", bold = true },
  DiagnosticError  = { fg = colors.error_red },
  DiagnosticWarn   = { fg = colors.warn_yellow },
  DiagnosticHint   = { fg = "iris" },
  DiagnosticInfo   = { fg = "pine" },
  StatusLineTerm   = { fg = colors.bright_white, bg = "surface" },
})

local winbar_groups = {
  WinBar          = { fg = "subtle", bg = "surface" },
  WinBarNC        = { bg = "surface" },
  WinBarDir       = { fg = "love", bg = "surface", italic = true },
  WinBarSeparator = { fg = "foam", bg = "surface" },
}

hl_groups = vim.tbl_extend("error", statusline_groups, winbar_groups)
require("rose-pine").setup({
  variant          = "main",
  dark_variant     = "main",
  highlight_groups = hl_groups,
})
vim.cmd("colorscheme rose-pine")

local G = {}
G.statusline = function()
  return S
end
G.winbar = function()
  return W
end

return G

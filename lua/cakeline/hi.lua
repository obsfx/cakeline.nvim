local M = {}
local hi_table = {}
local hi_namespace = 'Deadline'
local hi_inactive_prefix = 'Inactive'

function M.build_section(hl, exp, native)
  local str = ''
  if hl ~= nil then
    str = '%#' .. hl .. '#'
  end
  if native then
    str = str .. '%' .. exp .. '%*'
  else
    str = str .. '%{' .. exp .. '}%*'
  end
  return str
end

function M.build_hi(name, guibg, guifg, gui, inactive)
  local hi_name = M.build_name(name, inactive)
  return 'hi ' .. hi_name .. ' guibg=' .. guibg .. ' guifg=' .. guifg .. ' gui=' .. gui
end

function M.build_name(name, inactive)
  local hi_name = hi_namespace .. name
  if inactive then
    hi_name = hi_name .. hi_inactive_prefix
  end
  return hi_name
end

return M

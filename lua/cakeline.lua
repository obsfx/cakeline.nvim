local M = {
  sl = {}
}
local wo = vim.wo
local cmd = vim.cmd
local api = vim.api
local fn = vim.fn

function M.setline(line)
  local startidx = nil
  local tokens = {}
  local SPACE = "SPACE"

  for i = 1, #line do
    local c = line:sub(i, i)

    if c == '{' and startidx == nil then
      i = i + 1
      startidx = i
    elseif c == '}' and startidx ~= nil then
      tokens[#tokens+1] = line:sub(startidx, i - 1)
      startidx = nil
    elseif c == " " and startidx == nil then
      tokens[#tokens+1] = SPACE
    end
  end

  local sl = {}
  local section = require('cakeline.sections.table');

  for i = 1, #tokens do
    if tokens[i] ~= SPACE then
      sl[#sl+1] = section[tokens[i]].show
    else
      sl[#sl+1] = section.space.show
    end
  end

  M.sl = sl
end

function M.register(key, config, exp, native)
  require("cakeline.sections.table")[key] = {}
  require("cakeline.sections.table")[key].config = config
  require("cakeline.sections.table")[key].show = function(inactive)
    local config = require("cakeline.sections.table")[key].config
    return M.section(
        key,
        inactive,
        config.activecolors,
        config.inactivecolors,
        exp,
        false,
        config.leftpadding,
        config.rightpadding
      )
  end
end

function M.section(name, inactive, active_color, inactive_color, exp, native, lp, rp)
  local color = active_color
  if inactive then color = inactive_color end
  cmd(require('cakeline.hi').build_hi(name, color.bg, color.fg, color.gui, inactive))
  local hi = require('cakeline.hi').build_name(name, inactive)
  return require('cakeline.hi').build_section(hi, exp, native, lp, rp)
end

function M.build(inactive)
  local section = require('cakeline.sections.table');
  local sl = {}
  for i = 1, #M.sl do
    sl[#sl+1] = M.sl[i](inactive)
  end
  return table.concat(sl)
end

function M.update()
  local curwin = fn.winnr()
  local totalwin = fn.winnr('$')
  for i = 1, totalwin do
    fn.setwinvar(i, '&statusline', M.build(i ~= curwin))
  end

  --print(M.build(false))
end

api.nvim_exec([[
  augroup cakeline
    autocmd!
    autocmd WinEnter,BufEnter,BufDelete,SessionLoadPost,FileChangedShellPost * lua require("cakeline").update()
  augroup end
]], false)

return M

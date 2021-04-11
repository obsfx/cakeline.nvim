local M = {}
local wo = vim.wo
local cmd = vim.cmd
local api = vim.api
local fn = vim.fn

function M.section(name, inactive, active_color, inactive_color, exp, native)
  local color = active_color
  if inactive then color = inactive_color end
  cmd(require('cakeline.hi').build_hi(name, color.bg, color.fg, color.gui, inactive))
  local hi = require('cakeline.hi').build_name(name, inactive)
  return require('cakeline.hi').build_section(hi, exp, native)
end

function M.build(inactive)
  local sl = {
    require('cakeline.mode').show(inactive),
    " ",
    M.section(
      "Filename",
      inactive,
      {bg = '#222222', fg = '#777777', gui = 'NONE'},
      {bg = '#1c1b1a', fg = '#444444', gui = 'NONE'},
      "f",
      true
    )
  }
  return table.concat(sl)
end

function M.update()
  local curwin = fn.winnr()
  local totalwin = fn.winnr('$')
  for i = 1, totalwin do
    vim.fn.setwinvar(i, '&statusline', M.build(i ~= curwin))
  end
end

api.nvim_exec([[
  augroup cakeline
    autocmd!
    autocmd WinEnter,BufEnter,BufDelete,SessionLoadPost,FileChangedShellPost * lua require("cakeline").update()
  augroup end
]], false)


return M

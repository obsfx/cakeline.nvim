local M = {}
local cmd = vim.cmd
local fn = vim.fn

local mode_map = {
	['n'] = '  normal ',
	['no'] = '  noperator pending ',
	['v'] = '  visual ',
	['V'] = '  vline ',
	[''] = '  vblock ',
	['s'] = '  select ',
	['S'] = '  sline ',
	[''] = '  sblock ',
	['i'] = '  insert ',
  ['R'] = '  replace ',
	['Rv'] = '  vreplace ',
	['c'] = '  command ',
	['cv'] = '  vim ex ',
	['ce'] = '  ex ',
	['r'] = '  prompt ',
	['rm'] = '  more ',
	['r?'] = '  confirm ',
	['!'] = '  shell ',
	['t'] = '  terminal '
}

local mode_color_map = {
	['n'] = {bg = '#282828', fg = '#eeeeee', gui = 'BOLD'},
	['no'] = {bg = '#CF2549', fg = '#eeeeee', gui = 'BOLD'},
	['v'] = {bg = '#E1ECF3', fg = '#282828', gui = 'BOLD'},
	['V'] = {bg = '#E1ECF3', fg = '#282828', gui = 'BOLD'},
	[''] = {bg = '#E1ECF3', fg = '#282828', gui =  'BOLD'},
	['s'] = {bg = '#CF2549', fg = '#eeeeee', gui = 'BOLD'},
	['S'] = {bg = '#CF2549', fg = '#eeeeee', gui = 'BOLD'},
	[''] = {bg = '#CF2549', fg = '#eeeeee', gui = 'BOLD'},
	['i'] = {bg = '#5941BD', fg = '#eeeeee', gui = 'BOLD'},
	['R'] = {bg = '#CF2549', fg = '#eeeeee', gui = 'BOLD'},
	['Rv'] = {bg = '#E1ECF3', fg = '#282828', gui = 'BOLD'},
	['c'] = {bg = '#CF2549', fg = '#eeeeee', gui = 'BOLD'},
	['cv'] = {bg = '#CF2549', fg = '#eeeeee', gui = 'BOLD'},
	['ce'] = {bg = '#CF2549', fg = '#eeeeee', gui = 'BOLD'},
	['r'] = {bg = '#CF2549', fg = '#eeeeee', gui = 'BOLD'},
	['rm'] = {bg = '#CF2549', fg = '#eeeeee', gui = 'BOLD'},
	['r?'] = {bg = '#CF2549', fg = '#eeeeee', gui = 'BOLD'},
	['!'] = {bg = '#CF2549', fg = '#eeeeee', gui = 'BOLD'},
	['t'] = {bg = '#CF2549', fg = '#eeeeee', gui = 'BOLD'},
	['inactive'] = {bg = '#1c1b1a', fg = '#444444', gui = 'BOLD'}
}

function M.mode()
  local mode_key = fn.mode()
  local mode_color = mode_color_map[mode_key]
  if inactive then mode_color = mode_color_map['inactive'] end
  cmd(require('cakeline.hi').build_hi('Mode', mode_color.bg, mode_color.fg, mode_color.gui, inactive))
  return string.upper(mode_map[mode_key])
end

function M.show(inactive)
  if inactive then return '%{""}' end
  local hi = require('cakeline.hi').build_name('Mode', inactive)
  local exp = [[luaeval('require("cakeline.mode").mode()')]]
  return require('cakeline.hi').build_section(hi, exp)
end

return M

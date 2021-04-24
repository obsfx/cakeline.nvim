local cakeline = require("cakeline")

cakeline.register("linenumber", {
  leftpadding = 1,
  rightpadding = 3,
  activecolors = {bg = '#222222', fg = '#777777', gui = 'NONE'},
  inactivecolors = {bg = '#1c1b1a', fg = '#444444', gui = 'NONE'}
}, 'line(".")', false)

local statusline = "{filename} {linenumber} {switchright} {mode}"
cakeline.setline(statusline)


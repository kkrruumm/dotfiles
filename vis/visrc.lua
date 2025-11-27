require('vis') -- load standard vis module, providing parts of the Lua API
require('plugins/vis-title')
require('plugins/vis-cursors')
require('plugins/vis-autopairs')
plugin_vis_open = require('plugins/vis-fzf-open')

plugin_vis_open.fzf_args = "--preview='bat -f -p {}' --preview-border='sharp'"

local colorizer = require('plugins/vis-colorizer')
colorizer.six = true

vis.events.subscribe(vis.events.INIT, function()
    -- Global configuration options
    vis:command('map! normal <C-p> :fzf<Enter>')
    vis:command('set theme bummer')
    vis:command('set autoindent')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win) -- luacheck: no unused args
	-- Your per window configuration options e.g.
	-- vis:command('set number')
    vis:command('set expandtab')
    vis:command('set tabwidth 4')
    vis:command('set number')
    vis:command('set showeof off')
    vis:command('set cursorline')
end)

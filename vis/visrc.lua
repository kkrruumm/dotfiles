require('vis') -- load standard vis module, providing parts of the Lua API
require('plugins/vis-title')
require('plugins/vis-cursors')
require('plugins/vis-autopairs')
require('plugins/vis-backspace')
require('plugins/vis-sneak')
plugin_vis_open = require('plugins/vis-fzf-open')

plugin_vis_open.fzf_args = "--preview='bat -f -p {}' --preview-border='sharp'"

local colorizer = require('plugins/vis-colorizer')
colorizer.six = true

vis.events.subscribe(vis.events.INIT, function()
    -- Global configuration options
    vis:command('map! normal <C-p> :fzf<Enter>')
    vis:command('set theme bummer')
    vis:command('set autoindent')

    --shut up mom i'll move around in insert mode if i want
    --additionally, shut up mom i'll use arrow keys if i want
    vis:map(vis.modes.INSERT, '<C-Right>', '<Escape>"+wi') -- this is kind of gross but it works fine
    vis:map(vis.modes.INSERT, '<C-Left>', '<Escape>"+bi')
    --also normal mode
    vis:map(vis.modes.NORMAL, '<C-Right>', '"+w')
    vis:map(vis.modes.NORMAL, '<C-Left>', '"+b')
    --visual mode and stuff
    vis:map(vis.modes.VISUAL, '<C-Right>', '"+w')
    vis:map(vis.modes.VISUAL, '<C-Left>', '"+b')

    --copy (this is broken, hangs up the editor)
    --vis:map(vis.modes.VISUAL, '<C-c>', '"+yy')

    --paste
    --this fixes the problem with the autopairs plugin inserting "theoretical" pairs when pasting something into the editor
    --via something like ctrl+shift+v
    vis:map(vis.modes.NORMAL, '<C-v>', '"+p')
    vis:map(vis.modes.INSERT, '<C-v>', '<Escape>"+pa')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win) -- luacheck: no unused args
	-- Your per window configuration
    vis:command('set expandtab')
    vis:command('set tabwidth 4')
    vis:command('set number')
    vis:command('set showeof off')
    vis:command('set cursorline')
end)

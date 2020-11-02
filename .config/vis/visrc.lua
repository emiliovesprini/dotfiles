require('vis') -- Standard vis module that provides parts of the Lua API

vis.events.subscribe(vis.events.INIT, function() -- Global configuration options
	-- vis:command('set syntax off')
	vis:command('set theme dark-16')
end)

-- vis.events.subscribe(vis.events.WIN_OPEN, function(win) -- Per window configuration options
-- end)

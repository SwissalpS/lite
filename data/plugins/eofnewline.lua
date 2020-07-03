--[[
	eofnewline.lua
	makes sure file ends with newline
	version: 20200703_112529
	originally by bokunodev
	https://github.com/bokunodev/lite_modules/blob/master/plugins/eofnewline.lua?raw=1
--]]
local core = require "core"
local command = require "core.command"
local Doc = require "core.doc"

local function eof_newline(doc)
	local leof, neof = #doc.lines, #doc.lines
	for i = leof, 1, -1 do
		if not string.match(doc.lines[i], "^%s*$") then break end
		neof = i
	end
	if neof ~= leof then
		doc:remove(neof, 1, leof, math.huge)
		return
	end
	if "\n" ~= doc.lines[leof] then doc:insert(leof, math.huge, "\n") end
end

local save = Doc.save
Doc.save = function(self, ...)
	eof_newline(self)
	save(self, ...)
end

command.add("core.docview", {
	["eof-newline:eof-newline"] = function() eof_newline(core.active_view.doc) end,
})



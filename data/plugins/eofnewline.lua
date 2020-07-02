local core = require "core"
local command = require "core.command"
local Doc = require "core.doc"

local function eof_newline(doc)
	local eofl = #doc.lines
	for i = eofl, 1, -1 do
		if string.match(doc.lines[i], "^%s*$") then
			doc:remove(i, 1, i + 1, math.huge)
		else
			break
		end
	end
	eofl = #doc.lines
	if "\n" ~= doc.lines[eofl] then
		doc:insert(eofl, math.huge, "\n")
	end
end

local save = Doc.save
Doc.save = function(self, ...)
	eof_newline(self)
	save(self, ...)
end

command.add("core.docview", {
	["eof-newline:eof-newline"] = function() eof_newline(core.active_view.doc) end,
})


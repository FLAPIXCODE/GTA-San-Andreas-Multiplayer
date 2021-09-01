local sampev = require "lib.samp.events"
g
------------ Переменные ------------
local font_flag			= require('moonloader').font_flag
local font				= renderCreateFont("Arial", 9, font_flag.SHADOW + font_flag.BORDER)

------------ Таблицы ------------
local chat_lines			= {}
local chat_lines_sample		= {}


------------ Флаги ------------
local enabled			= true

local max_chat_line		= 99	-- const
local last_chat_line	= 99
local size_chat			= 12

local chat_X			= 20	-- const
local chat_Y			= 20	-- const
local chat_Y_temp		= chat_Y


function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	lua_thread.create(function()
		while true do
			for i = 99, 1 do
				local text, _, color, _ = sampGetChatString(i)
				if #chat_lines ~= 0 then
					
				else
					addChatLine(text, color)
				end
			end
			
			wait(0)
		end
	end)

-- Рендер:
	while true do
		if enabled and not sampIsScoreboardOpen() then
			for k in pairs(chat_lines) do
				renderFontDrawText(font, chat_lines[k]["time"] .. " " .. chat_lines[k]["text"], chat_X, chat_Y_temp, chat_lines[k]["color"])
			end
		end
		wait(0)
	end
	wait(-1)
end


function addChatLine(text, color)
	lua_thread.create(function()
		table.insert(chat_lines, {text, color})
	end)
end


function ARGBtoRGB(color)
	return string.match(bit.tohex(color), "%w%w(.+)")
end


function sampev.onSendCommand(cmd)
	if cmd == "/chat" then
		enabled = not enabled
		return false
	end
end
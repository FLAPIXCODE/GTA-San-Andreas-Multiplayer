local sampev	= require "lib.samp.events"

local reasons	= {"Тайм-аут/Вылет", "Выход", "Кик/Бан"}
local indicator	= {[true]="{40EB34}включены", [false]="{FF0000}отключены"}
local players	= {}
local enabled	= false
local init		= true

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then
		return
	end
	while not isSampAvailable() do
		wait(100)
	end

	for i = 0, 999 do
		table.insert(players, {nil})
	end
	
	lua_thread.create(function()
		while true do
			if sampGetPlayerPing() ~= 0 then
				break
			end
			wait(200)
		end
		wait(200)
		init = false
		return
	end)

	wait(-1)
end


function sampev.onPlayerJoin(id, color, isNpc, nickname)
	if enabled and not init then
		sampAddChatMessage("[!] " .. nickname .. "[" .. id .. "] подключился.", 0xFF777777)
	end
	players[id + 1] = nickname
end



function sampev.onPlayerQuit(id, reason)
	if enabled then
		sampAddChatMessage("[!] " .. players[id + 1] .. "[" .. id .. "] отключился (" .. reasons[reason + 1] .. ").", 0xFF777777)
	end
	players[id + 1] = nil
end



function sampev.onSendCommand(cmd)
	if cmd == "/connects" then
		enabled = not enabled
		sampAddChatMessage("[!] Коннекты/дисконнекты игроков " .. indicator[enabled] .. ".", 0XFFFFE380)
		return false
	end
end
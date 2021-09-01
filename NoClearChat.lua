local sampev = require "lib.samp.events"

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	wait(-1)
end

function sampev.onServerMessage(color, text)
	if text:find("^%s*$") then
		return false
	end
end
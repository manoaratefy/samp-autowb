require "moonloader"
require "sampfuncs"
local sampev = require "lib.samp.events"

local enabled = true
local short = false
local firstnameonly = true

-- Cache for logged out users time
local logged_out = {}
-- Don't re-wb people if they logged out in last 5 minutes
local logged_out_cooldown = 300

script_name("Auto Welcome Back")

function cmd_autowb_toogle()
	enabled = not enabled
	if enabled then
		sampAddChatMessage("{FFFFFF}Auto welcome back: {008000}ON", -1)
	else
		sampAddChatMessage("{FFFFFF}Auto welcome back: {800000}OFF", -1)
	end
end

function cmd_autowb_short()
	short = not short
	if short then
		sampAddChatMessage("{FFFFFF}Auto welcome back: {008000}short {FFFFFF}(wb [name])", -1)
	else
		sampAddChatMessage("{FFFFFF}Auto welcome back: {800000}long {FFFFFF}(Welcome back [name])", -1)
	end
end

function cmd_autowb_firstname()
	firstnameonly = not firstnameonly
	if firstnameonly then
		sampAddChatMessage("{FFFFFF}Auto welcome back only firstname: {008000}ON", -1)
	else
		sampAddChatMessage("{FFFFFF}Auto welcome back only firstname: {800000}OFF", -1)
	end
end

function cmd_autowb_help()
	sampAddChatMessage("{009000}Auto welcome back by {E84393}Laura A. Yamaguchi", -1)
	sampAddChatMessage("{FFFFFF}Based on the Auto welcome back by {FD79A8}Akagami Y. Sumiyoshi", -1)
	sampAddChatMessage("{FFFFFF}Available commands:", -1)
	sampAddChatMessage("{74B9FF}/autowb: {FFFFFF}toogle auto welcome back (enable or disable). Default: enabled", -1)
	sampAddChatMessage("{74B9FF}/autowbfn: {FFFFFF}welcome back only with first name instead of full name. Default: enabled", -1)
	sampAddChatMessage("{74B9FF}/autowbshort: {FFFFFF}tell wb [name] instead of Welcome back [name]", -1)
	sampAddChatMessage("{74B9FF}/autowbhelp: {FFFFFF}show this help message", -1)
end

function main()
	repeat wait(50) until isSampAvailable()
	repeat wait(50) until string.find(sampGetCurrentServerName(), "Horizon Roleplay")

	sampAddChatMessage("{FFFFFF}Auto welcome back. {74B9FF}/autowbhelp {FFFFFF}for commands list", -1)

	sampRegisterChatCommand("autowb", cmd_autowb_toogle)
	sampRegisterChatCommand("autowbfn", cmd_autowb_firstname)
	sampRegisterChatCommand("autowbshort", cmd_autowb_short)
	sampRegisterChatCommand("autowbhelp", cmd_autowb_help)
end

function sampev.onServerMessage(c, text)
	if not enabled then
		return
	end

	local message = text
	local name = message:match("^%*%*%* (.-) from your family has logged in%.$")
	
	if name then
		if logged_out[name] ~= nil then
			if (logged_out[name] + logged_out_cooldown) > os.time() then
				-- Don't welcome back because still on cooldown
				return
			end
		end

		sampAddChatMessage(text, c)

		if firstnameonly then
			name = name:match("^([%w]+)")
		end

		if short then
			sampSendChat("/f wb " .. name)
		else
			sampSendChat("/f Welcome back " .. name .. "!")
		end
	end

	local name = message:match("^%*%*%* (.-) from your family has disconnected %(.-%)%.$")
	if name then
		logged_out[name] = os.time()
	end
end

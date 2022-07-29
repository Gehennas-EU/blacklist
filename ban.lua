#!/usr/bin/lua

dofile(".github/lib/table.lua")
dofile("blacklist.lua")

local params = {...}
local blocklist = params[1]
if not blocklist then
	io.stderr:write("Blocklist is missing\n")
	os.exit(1)
end

if not params[2] then
	io.stderr:write("At least one name is required\n")
	os.exit(1)
end

if not GehennasBlacklist_Data[blocklist] then
	print("creating blocklist ".. blocklist)
	GehennasBlacklist_Data[blocklist] = {}
end

local anyBanned = false
for i = 2, #params do
	local char = params[i]
	if GehennasBlacklist_Data[blocklist][char] then
		print(char .. " already banned. Skipping...")
	else
		print("adding " .. char .. " to the " .. blocklist .." blocklist")
		GehennasBlacklist_Data[blocklist][char] = {
			["reason"] = os.getenv("BLACKLIST_REASON"),
			["discord_url"] = os.getenv("DISCORD_URL"),
		}
		anyBanned = true
	end
end

if anyBanned then
	save_table("blacklist.lua", GehennasBlacklist_Data);
else
	print("All name(s) are already banned. Doing nothing...")
end

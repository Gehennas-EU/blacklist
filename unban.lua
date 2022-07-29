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
	print("blacklist ".. blocklist .. " is missing. Skipping")
	return
end

local anyRemoved = false
for i = 2, #params do
	local char = params[i]
	if GehennasBlacklist_Data[blocklist][char] then
		print("removing " .. char .. " from the " .. blocklist .." blocklist")
		GehennasBlacklist_Data[blocklist][char] = nil
		anyRemoved = true
	end
end

if anyRemoved then
	save_table("blacklist.lua", GehennasBlacklist_Data);
else
	print("All name(s) are already removed. Doing nothing...")
end

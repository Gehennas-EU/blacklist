--[[
------------------------------------------------------------------------------------
--                      table (formerly TableTools)                               --
--                                                                                --
-- This module includes a number of functions for dealing with Lua tables.        --
-- It is a meta-module, meant to be called from other Lua modules, and should     --
-- not be called directly from #invoke.                                           --
------------------------------------------------------------------------------------
--]]

--[[
	Inserting new values into a table using a local "index" variable, which is
	incremented each time, is faster than using "table.insert(t, x)" or
	"t[#t + 1] = x". See the talk page.
]]


local function defaultKeySort(key1, key2)
	-- "number" < "string", so numbers will be sorted before strings.
	local type1, type2 = type(key1), type(key2)
	if type1 ~= type2 then
		return type1 < type2
	else
		return key1 < key2
	end
end

--[[
	Returns a list of the keys in a table, sorted using either the default
	table.sort function or a custom keySort function.
	If there are only numerical keys, numKeys is probably more efficient.
]]
function keysToList(t, keySort)
	local list = {}
	local index = 1
	for key, _ in pairs(t) do
		list[index] = key
		index = index + 1
	end

	-- Place numbers before strings, otherwise sort using <.
	if not keySort then
		keySort = defaultKeySort
	end

	table.sort(list, keySort)

	return list
end

--[[
	Iterates through a table, with the keys sorted using the keysToList function.
	If there are only numerical keys, sparseIpairs is probably more efficient.
]]
function sortedPairs(t, keySort)
	local list = keysToList(t, keySort, true)

	local i = 0
	return function()
		i = i + 1
		local key = list[i]
		if key ~= nil then
			return key, t[key]
		else
			return nil, nil
		end
	end
end


-- we want to have the list to always be sorted so
-- git history is clean pairs always returns items in undeterministic way
-- TODO: this should be re-written to use recursion instead
function save_table(path, tbl)
	file, e = io.open(path, "w");
	if not file then
		return error(e);
	end

	file:write("GehennasBlacklist_Data = {\n");

	for k,v in sortedPairs(tbl) do
		file:write(string.format('\t["%s"] = {\n', k))
		for banned, details in sortedPairs(v) do
			if not details or not details["reason"] or not details["discord_url"] then
				file:write(string.format('\t\t["%s"] = {},\n', banned))
			else
				file:write(string.format('\t\t["%s"] = {\n', banned))
				for k,v in sortedPairs(details) do
					file:write(string.format('\t\t\t["%s"] = [[%s]],\n', k,v))
				end
				file:write('\t\t},\n')
			end
		end
		file:write("\t},\n")
	end

	file:write("};\n");
end

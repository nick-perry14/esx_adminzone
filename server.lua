local ESX = nil
local zones = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('setzone', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifiers = GetPlayerIdentifiers(source)
    if isAuthed(xPlayer) then
	local zone = false
	for _, v in pairs(identifiers) do
		if string.find(v, "license") then
			for i, j in pairs(zones) do
				if j.id == v then
					zone = true
					break
				end
			end
			break
		end
	end
		if zone then
		TriggerClientEvent("chatMessage", source, "^*^1You already have an active zone!  Clear it before trying to create another!.")
		else
		TriggerClientEvent('adminzone:getCoords', source, 'setzone',Config.pass)
		end
    else
        TriggerClientEvent("chatMessage", source, "^*^1Insufficient Permissions.")
    end
end)

RegisterCommand('clearzone', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
    if isAuthed(xPlayer) then
		local identifiers = GetPlayerIdentifiers(source)
		local lic = nil
		for _, v in pairs(identifiers) do
			if string.find(v, "license") then
				for i, j in pairs(zones) do
					if j.id == v then
						table.remove(zones, i)
						break
					end
				end
				break
			end
		end
		TriggerClientEvent("adminzone:UpdateZones", -1, zones , Config.pass)
    else
        TriggerClientEvent("chatMessage", source, "^*^1Insufficient Permissions.")
    end
end)

AddEventHandler('playerDropped', function (reason)
	local identifiers = GetPlayerIdentifiers(source)
		for _, v in pairs(identifiers) do
			if string.find(v, "license") then
				for i, j in pairs(zones) do
					if j.id == v then
						table.remove(zones, i)
						break
					end
				end
				break
			end
		end
end)

RegisterNetEvent('adminzone:sendCoords')
AddEventHandler('adminzone:sendCoords', function(command, coords)
	local xPlayer = ESX.GetPlayerFromId(source)
	if  isAuthed(xPlayer) then
		if command == 'setzone' then
			local identifiers = GetPlayerIdentifiers(source)
			for _, v in pairs(identifiers) do
				if string.find(v, "license") then
					print(v)
					table.insert(zones, {id = v, coord = coords})
					TriggerClientEvent("chatMessage", source, "^*Added Zone!")
					TriggerClientEvent("adminzone:UpdateZones", -1, zones , Config.pass)
					break
				end
			end
		end
	end
end)

RegisterNetEvent('adminzone:ServerUpdateZone')
AddEventHandler('adminzone:ServerUpdateZone', function()
	TriggerClientEvent('adminzone:UpdateZones', source, zones, Config.pass)
end)

function isAuthed(xPlayer)
	for k, v in ipairs(Config.groups) do 
		if xPlayer.getGroup() == v then
			return true
		end
	end
		return false
end
local blip = nil
local radiusBlip = nil
local inZone = nil
local zones = {}

AddEventHandler("adminzone:inZone", function (coords, pass)
		if pass == Config.pass then
			inZone = coords
			RemoveBlip(blip)
			RemoveBlip(radiusBlip)
			blip = AddBlipForCoord(coords.x, coords.y, coords.z)
			radiusBlip = AddBlipForRadius(coords.x, coords.y, coords.z, Config.blipRadius)
			SetBlipSprite(blip, 487)
			SetBlipAsShortRange(blip, true)
			SetBlipColour(blip, Config.blipColor)
			SetBlipScale(blip, 1.0)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString('ADMIN ZONE')
			EndTextCommandSetBlipName(blip)
			SetBlipAlpha(radiusBlip, 80)
			SetBlipColour(radiusBlip, Config.blipColor)
			Citizen.CreateThread(function()
				while inZone ~= nil do 
				Citizen.Wait(0)
				SetTextFont(0)
				SetTextCentre(true)
				SetTextProportional(1)
				SetTextScale(0.7, 0.7)
				SetTextColour(128, 128, 128, 255)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				AddTextComponentString(Config.enterText)
				DrawText(.5, 0.73)
				
				if IsControlPressed(0, 106) then
					ShowNotif("~r~You are currently in an ADMIN ZONE. ~n~~s~You cannot shoot! Please remain clear of the situation")
				end
				SetPlayerCanDoDriveBy(PlayerPedId(), false)
				DisablePlayerFiring(PlayerPedId(), true)
				DisableControlAction(0, 140) -- Melee R\
				local veh = GetVehiclePedIsIn(PlayerPedId())
				if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
					if math.ceil(GetEntitySpeed(veh) * 2.23) > Config.maxSpeed then
						ShowNotif("~r~You are currently in an ADMIN ZONE. ~n~~s~Slow down and remain clear of the situation.")
					end
				end
			end
			SetPlayerCanDoDriveBy(PlayerPedId(), true)
			DisablePlayerFiring(PlayerPedId(), false)
		end)
	end
end)

function exitZone()
    RemoveBlip(blip)
    RemoveBlip(radiusBlip)
    ShowNotif("~g~You have exited the ADMIN ZONE!  You may resume regular RP!")
	inZone = nil
end

function ShowNotif(text)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandThefeedPostTicker(true, false)
end

function ZoneAdded()
	Citizen.CreateThread(function () 
		print (#zones)
		if #zones < 2 then
			while #zones > 0 do
				 for k,v in pairs(zones) do
					if GetDistanceBetweenCoords(v.coord, GetEntityCoords(GetPlayerPed(-1))) <= 100 then
						if inZone == nil then
							ShowNotif("~r~You have entered an ADMIN ZONE ~n~~s~ RP, Violence, and Speeding is not tolerated.")
							TriggerEvent('adminzone:inZone', v.coord, Config.pass)
							break
						end
					else
						if inZone == v.coord then
							exitZone()
							break
						end
					end
				 end
			Citizen.Wait(100)
			end
			if inZone ~= nil then
			    RemoveBlip(blip)
				RemoveBlip(radiusBlip)
				ShowNotif("~g~The ADMIN ZONE has been cleared!  You may resume regular RP!")
				inZone = nil
			end
		end
	end)
end
RegisterNetEvent('adminzone:UpdateZones')
AddEventHandler("adminzone:UpdateZones", function(zoneTable, pass)
	if pass == Config.pass then
		zones = zoneTable
		ZoneAdded()
	else
	--[[INSERT BAN Statement here.  The only time the password would be incorrect is if the user is injecting event calls]]
	end
end)

RegisterNetEvent('adminzone:getCoords')
AddEventHandler("adminzone:getCoords", function(command, pass)
	if pass == Config.pass then
		TriggerServerEvent('adminzone:sendCoords', command, GetEntityCoords(PlayerPedId()))
	else
		--[[INSERT BAN Statement here.  The only time the password would be incorrect is if the user is injecting event calls]]
	end
end)
    
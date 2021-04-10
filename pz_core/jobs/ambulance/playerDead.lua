local MenuOpen = false
isDead = false
appellistsql = {}
local DidCall = false

local earlySpawnTimer = 15 -- minutes

AddEventHandler("onClientMapStart", function()
	exports.spawnmanager:spawnPlayer()
	Citizen.Wait(5000)
	exports.spawnmanager:setAutoSpawn(false)
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	if deadPlayers[playerId] then
		deadPlayers[playerId] = nil
		TriggerClientEvent('ambulance:setDeadPlayers', -1, deadPlayers)
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	OnPlayerDeath()
end)

AddEventHandler('esx:onPlayerSpawn', function()
	isDead = false

	if firstSpawn then
		firstSpawn = false

		while not PlayerLoaded do
			Citizen.Wait(1000)
		end

		ESX.TriggerServerCallback('ambulance:getDeathStatus', function(shouldDie)
			if shouldDie then
				ESX.ShowNotification("~r~Remis dans le coma de force car vous avez quitter le server.")
				OnPlayerDeath()
			end
		end)		
	end
end)

function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)
	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('esx:onPlayerSpawn')
	TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon.
	isDead = false
end

function LoadAppel()
	appellistsql = {}
	ESX.TriggerServerCallback('ambulance:afficherapel', function(keys)
		appellistsql = keys
	end)
end

local function openMenuDeath()
	RMenu.Add('ambulance', 'death_call', RageUI.CreateMenu("Demande EMS", "~b~Demande de l'aide"))
	RMenu:Get('ambulance', 'death_call').Closable = false
	RMenu:Get('ambulance', 'death_call').Closed = function()
		MenuOpen = false
	end
	

    if not MenuOpen then 
        MenuOpen = true
    RageUI.Visible(RMenu:Get('ambulance', 'death_call'), not RageUI.Visible(RMenu:Get('ambulance', 'death_call')))
    Citizen.CreateThread(function()
        while MenuOpen do
            dynamicMenu4 = true
			DisableControlAction(0, 37, true) -- Tab
			--DisableControlAction(0, 38, true) -- E
			DisableControlAction(0, 168, true) -- F7
			DisableControlAction(0, 170, true) -- F3
			DisableControlAction(0, 344, true) -- F11
			DisableControlAction(0, 288, true) -- F1
			DisableControlAction(0, 289, true) -- F2
			DisableControlAction(0, 327, true) -- F5
			DisableControlAction(0, 167, true) -- F6
			RageUI.IsVisible(RMenu:Get('ambulance', 'death_call'), true, true, true, function()
				
				if not DidCall then
					RageUI.ButtonWithStyle("Demander un EMS.", nil, { }, true, function(Hovered, Active, Selected)
						if Selected then
							DidCall = true
							local coords = GetEntityCoords(GetPlayerPed(-1))
							TriggerServerEvent("ambulance:ajoutappel", coords)
							ESX.ShowNotification("~g~Appel envoyé.")
						end
					end)
				else
					RageUI.Separator("~r~Vous êtes dans le coma.")
					RageUI.Separator("")
					RageUI.Separator("~g~Appel envoyé aux secours.")
					RageUI.Separator("")
					if earlySpawnTimer > 0 then 
						RageUI.Separator("Respawn automatique dans ~r~"..earlySpawnTimer.."~s~ minutes")
					else 
						RageUI.Separator("Appuyez sur [~r~E~s~] pour réaparaître.")
					end
				end
			end, function()
			end)

			if earlySpawnTimer == 0 or earlySpawnTimer < 0 then 
				if IsControlJustPressed(1, 38) then 
					RemoveItemsAfterRPDeath()
				end
			end

            Citizen.Wait(0)
        end
        MenuOpen = false
        dynamicMenu4 = false
    end)
end
end

function OnPlayerDeath()
	isDead = true
	RageUI.GoBack()
	RageUI.CloseAll()
	TriggerServerEvent('ambulance:setDeathStatus', true)
	StartScreenEffect('DeathFailOut', 0, true)
	openMenuDeath()
	DisplayRadar(false)
	TriggerEvent('esx_status:setDisplay', 0.0)
	while isDead and earlySpawnTimer > 0 do 
		if earlySpawnTimer > 0 then
			earlySpawnTimer = earlySpawnTimer - 1
		end
		Citizen.Wait(60000)
	end
end

function RemoveItemsAfterRPDeath()
	TriggerServerEvent('ambulance:setDeathStatus', false)
	isDead = false
	DisplayRadar(true)
	TriggerEvent('esx_status:setDisplay', 1.0)
	RageUI.GoBack()
	RageUI.CloseAll()
	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end

		local formattedCoords = {
			x = 314.15,
			y = -568.82,
			z = 43.28
		} 

		RespawnPed(PlayerPedId(), formattedCoords, 157.96)
		StopScreenEffect('DeathFailOut')
		DoScreenFadeIn(800)
	end)
end

RegisterNetEvent('ambulance:revive')
AddEventHandler('ambulance:revive', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	TriggerServerEvent('ambulance:setDeathStatus', false)
	DisplayRadar(true)
	TriggerEvent('esx_status:setDisplay', 1.0)
	RageUI.GoBack()
	RageUI.CloseAll()
	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Citizen.Wait(50)
	end

	local formattedCoords = {
		x = ESX.Math.Round(coords.x, 1),
		y = ESX.Math.Round(coords.y, 1),
		z = ESX.Math.Round(coords.z, 1)
	}

	RespawnPed(playerPed, formattedCoords, 0.0)

	StopScreenEffect('DeathFailOut')
	DoScreenFadeIn(800)
	isDead = false
	MenuOpen = false
	DidCall = false
end)

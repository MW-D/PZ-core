isAmbulance = false 
inServiceAmbulance = false
local menuThread = false

RMenu.Add("ambulance_dynamicmenu", "ambulance_dynamicmenu_main", RageUI.CreateMenu("Tablette ambulance","Interactions possibles"))
RMenu:Get("ambulance_dynamicmenu", "ambulance_dynamicmenu_main").Closed = function()end

RMenu.Add('ambulance_dynamicmenu', 'ambulance_dynamicmenu_cit', RageUI.CreateSubMenu(RMenu:Get('ambulance_dynamicmenu', 'ambulance_dynamicmenu_main'), "Interactions citoyens", "Interactions avec un citoyens"))
RMenu:Get('ambulance_dynamicmenu', 'ambulance_dynamicmenu_cit').Closed = function()end

RMenu.Add('ambulance_dynamicmenu', 'ambulance_dynamicmenu_appel', RageUI.CreateSubMenu(RMenu:Get('ambulance_dynamicmenu', 'ambulance_dynamicmenu_main'), "Appelle EMS", "Voici les appelles:"))
RMenu:Get('ambulance_dynamicmenu', 'ambulance_dynamicmenu_appel').Closed = function()end

RMenu.Add('ambulance_dynamicmenu', 'ambulance_dynamicmenu_knowappel', RageUI.CreateSubMenu(RMenu:Get('ambulance_dynamicmenu', 'ambulance_dynamicmenu_main'), "Information", "Sélectionnez une action"))
RMenu:Get('ambulance_dynamicmenu', 'ambulance_dynamicmenu_knowappel').Closed = function()end

local ambulanceOpen = false
local function jobMenu()
	if menuThread then return end
	menuThread = true
	if not ambulanceOpen then 
		ambulanceOpen = true
	Citizen.CreateThread(function()
		while isAmbulance do
			if IsControlJustPressed(1, 167) then
				RageUI.Visible(RMenu:Get("ambulance_dynamicmenu",'ambulance_dynamicmenu_main'), not RageUI.Visible(RMenu:Get("ambulance_dynamicmenu",'ambulance_dynamicmenu_main')))
				LoadAppel()
			end
		
			Citizen.Wait(1)
		end
		menuThread = false
	end)
	end
end

function blipsForPayerDead(coord)
	Citizen.CreateThread(function()
		local blip = AddBlipForCoord(coord.x, coord.y, coord.z)
		local color = 59
		SetBlipSprite(blip, 42)
		SetBlipAsShortRange(blip, false)
		SetBlipColour(blip, color)
		SetBlipScale(blip, 0.5)
		SetBlipCategory(blip, 12)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Joueur")
		EndTextCommandSetBlipName(blip)
		
		local radius = AddBlipForCoord(coord.x, coord.y, coord.z)
		SetBlipSprite(radius, 161)
		SetBlipScale(radius, 2.0)
		SetBlipColour(radius, color)
		PulseBlip(radius)

		Citizen.Wait(60000)
		RemoveBlip(blip)
		RemoveBlip(radius)

	end)
end

local function jobChanged()

	if ESX.PlayerData.job.name == "ambulance" then
		isAmbulance = true
		inServiceAmbulance = false
		pzCore.mug("Statut de service","Ambulance","Vous êtes actuellement considéré comme étant ~r~hors service~s~. Vous pouvez changer ce statut avec votre menu ~o~[F6]") 
		jobMenu()
	else
		isAmbulance = false
		inServiceAmbulance = false
		menuThread = false 
	end
end

function revivePlayer(closestPlayer)
	isBusy = true

	ESX.TriggerServerCallback('ambulance:getItemAmount', function(quantity)
		if quantity > 0 then
			local closestPlayerPed = GetPlayerPed(closestPlayer)

			if IsPedDeadOrDying(closestPlayerPed, 1) then
				local playerPed = PlayerPedId()
				local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
				ESX.ShowNotification('~g~La réanimation commence...')
				RageUI.CloseAll()

				for i=1, 15 do
					Citizen.Wait(900)

					ESX.Streaming.RequestAnimDict(lib, function()
						TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
					end)
				end

				TriggerServerEvent('ambulance:removeItem', 'medikit')
				TriggerServerEvent('ambulance:revive', GetPlayerServerId(closestPlayer))
				
			else
				ESX.ShowNotification('~r~Aucun joueur inconscient à distance.')
			end
		else
            ESX.ShowNotification("~r~Vous n'avez pas de kit de réanimation.")
		end
		isBusy = false
	end, 'medikit')
end

RegisterNetEvent('ambulance:heal')
AddEventHandler('ambulance:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
    end

	if not quiet then
		ESX.ShowNotification("~r~Action terminé")
	end
end)

RegisterNetEvent('ambulance:useItem')
AddEventHandler('ambulance:useItem', function(itemName)
	RageUI.CloseAll()

	if itemName == 'medikit' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end

			TriggerEvent('ambulance:heal', 'big', true)
			ESX.ShowNotification('Vous avez utilisé un ~g~kit de réanimation~s~.')
		end)

	elseif itemName == 'bandage' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end

			TriggerEvent('ambulance:heal', 'small', true)
			ESX.ShowNotification('Vous avez utilisé un ~g~bandage~s~.')
		end)
	end
end)

local function spawnCar(ped, car)
	local hash = GetHashKey(car)
	local p = vector3(289.79, -610.00, 43.13)
	Citizen.CreateThread(function()
		RequestModel(hash)
		while not HasModelLoaded(hash) do Citizen.Wait(10) end

		local vehicle = CreateVehicle(hash, p.x, p.y, p.z, 89.99, true, false)

		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    end)
end

local function spawnHeli(heli, ped)
	local hash = GetHashKey(heli)
	local p = vector3(351.62, -588.19, 74.55)
	Citizen.CreateThread(function()
		RequestModel(hash)
		while not HasModelLoaded(hash) do Citizen.Wait(10) end

		local vehicle = CreateVehicle(hash, p.x, p.y, p.z, 90.00, true, false)

		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
	end)
end

local function init()
	menuThread = false
	isAmbulance = true
	inServiceAmbulance = false
	pzCore.mug("Statut de service","Ambulance","Vous êtes actuellement considéré comme étant ~r~hors service~s~. Vous pouvez changer ce statut avec votre menu ~o~[F6]")
	jobMenu()
end

local function createBlip()
    local blip = AddBlipForCoord(293.03, -582.71, 43.19)
	SetBlipSprite(blip, 61)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 43)
	SetBlipScale(blip, 0.5)
	SetBlipCategory(blip, 12)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Ambulance")
	EndTextCommandSetBlipName(blip)
end
 
local function setUniform(ped,id)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject

		if skin.sex == 0 then
			uniformObject = pzCore.jobs[ESX.PlayerData.job.name].config.clothes[id].male
		else
			uniformObject = pzCore.jobs[ESX.PlayerData.job.name].config.clothes[id].female
		end

		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
		else
			-- Rien
		end
	end)
end

local current = "ambulance"

pzCore.jobs[current].jobMenu = jobMenu
pzCore.jobs[current].init = init
pzCore.jobs[current].jobChanged = jobChanged
pzCore.jobs[current].spawnCar = spawnCar
pzCore.jobs[current].spawnHeli = spawnHeli
pzCore.jobs[current].createBlip = createBlip
pzCore.jobs[current].setUniform = setUniform
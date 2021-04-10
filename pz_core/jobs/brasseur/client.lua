local recolte,traitement,vente = nil,nil,nil
Isbrasseur = false
menuThread = false
local JobBlips = {}



RegisterNetEvent("StartRecolteAnimation")
AddEventHandler("StartRecolteAnimation", function(source)
	FreezeEntityPosition(PlayerPedId(), true)
	TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_KNEEL", 0, true)
end)

local function StopAction()
	Citizen.CreateThread(function()
		while Isbrasseur do
			if IsControlJustPressed(0, 73) then --X = Stop Action
				TriggerServerEvent("esx:brasseurjob:stopHarvest")
				ClearPedTasksImmediately(PlayerPedId())
				FreezeEntityPosition(PlayerPedId(), false)
				Wait(3000)
				pzCore.jobsMarkers.subscribe()
			end
			Citizen.Wait(1)
		end
		menuThread = false

	end)
end

local function jobblip()
	if ESX.PlayerData.job.name == "brasseur" then
		local blip1 = AddBlipForCoord(1886.309, 4858.142, 45.619)
		SetBlipSprite(blip1, 1)
		SetBlipAsShortRange(blip1, true)
		SetBlipColour(blip1, 10)
		SetBlipScale(blip1, 0.5)
		SetBlipCategory(blip1, 12)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Brasseur | Récolte 1/3")
		EndTextCommandSetBlipName(blip1)
		table.insert(JobBlips, blip1)

		local blip2 = AddBlipForCoord(407.70, 6496.10, 27.87)
		SetBlipSprite(blip1, 1)
		SetBlipAsShortRange(blip1, true)
		SetBlipColour(blip1, 10)
		SetBlipScale(blip1, 0.5)
		SetBlipCategory(blip1, 12)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Brasseur | Transformation 2/3")
		EndTextCommandSetBlipName(blip2)
		table.insert(JobBlips, blip2)

		local blip3 = AddBlipForCoord(543.76, 2663.20, 42.15)
		SetBlipSprite(blip1, 1)
		SetBlipAsShortRange(blip1, true)
		SetBlipColour(blip1, 10)
		SetBlipScale(blip1, 0.5)
		SetBlipCategory(blip1, 12)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Brasseur | Vente 3/3")
		EndTextCommandSetBlipName(blip3)
		table.insert(JobBlips, blip3)
	end
end

local function init()
	Isbrasseur = true
	menuThread = false
	jobblip()
	StopAction()
end

function deleteBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
		RemoveBlip(JobBlips[i])
		JobBlips[i] = nil
		end
	end
end

local function jobChanged()
	if ESX.PlayerData.job.name == "brasseur" then
        jobblip()
        Isbrasseur = true
	else
        deleteBlips()
        Isbrasseur = false
	end
	menuThread = false
	StopAction()
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
	jobChanged()

	init()
end)

local function createBlip()
	local blip = AddBlipForCoord(1959.88, 4646.54, 39.75)
	SetBlipSprite(blip, 106)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 10)
	SetBlipScale(blip, 0.5)
	SetBlipCategory(blip, 12)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Brasseur")
	EndTextCommandSetBlipName(blip)
end

local function spawnCar(car, ped)
	local hash = GetHashKey(car)
	local p = vector3(1959.88, 4646.54, 39.75)
	Citizen.CreateThread(function()
		RequestModel(hash)
		while not HasModelLoaded(hash) do Citizen.Wait(10) end

		local vehicle = CreateVehicle(hash, p.x, p.y, p.z, 190.0, true, false)

		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
	end)
end

RegisterNetEvent('stoptallbrasseur')
AddEventHandler('stoptallbrasseur', function(source)
	TriggerServerEvent("esx:brasseurjob:stopHarvest")
	ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(PlayerPedId(), false)
	Wait(5000)
	pzCore.jobsMarkers.subscribe()
end)



RegisterNetEvent("RemoveMarkerbrasseur")
AddEventHandler("RemoveMarkerbrasseur", function(source)
	pzCore.markers.unsubscribe("brasseur_recolte")
	pzCore.markers.unsubscribe("brasseur_transformation")
	pzCore.markers.unsubscribe("brasseur_vente")
end)


local current = "brasseur"

pzCore.jobs[current].init = init
pzCore.jobs[current].jobChanged = jobChanged
pzCore.jobs[current].createBlip = createBlip
pzCore.jobs[current].spawnCar = spawnCar
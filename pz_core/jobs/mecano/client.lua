isMecano = false 
inServiceMecano = false
local menuThread = false

RMenu.Add("mecano_dynamicmenu", "mecano_dynamicmenu_main", RageUI.CreateMenu("Tablette de mécano","Interactions possibles"))
RMenu:Get("mecano_dynamicmenu", "mecano_dynamicmenu_main").Closed = function()end

RMenu.Add('mecano_dynamicmenu', 'mecano_dynamicmenu_veh', RageUI.CreateSubMenu(RMenu:Get('mecano_dynamicmenu', 'mecano_dynamicmenu_main'), "Interactions véhicules", "Interactions avec un véhicule"))
RMenu:Get('mecano_dynamicmenu', 'mecano_dynamicmenu_veh').Closed = function()end


local mecanoOpen = false
local function jobMenu()
	if menuThread then return end
	menuThread = true
	if not mecanoOpen then 
		mecanoOpen = true
	Citizen.CreateThread(function()
		while isMecano do
			if IsControlJustPressed(1, 167) then
				RageUI.Visible(RMenu:Get("mecano_dynamicmenu",'mecano_dynamicmenu_main'), not RageUI.Visible(RMenu:Get("mecano_dynamicmenu",'mecano_dynamicmenu_main')))
			end
			Citizen.Wait(1)
		end
		menuThread = false
	end)
	end
end

local function jobChanged()

	if ESX.PlayerData.job.name == "mecano" then
		isMecano = true
		inServiceMecano = false
		pzCore.mug("Statut de service","Mécano","Vous êtes actuellement considéré comme étant ~r~hors service~s~. Vous pouvez changer ce statut avec votre menu ~o~[F6]") 
		jobMenu()
	else
		isMecano = false
		inServiceMecano = false
		menuThread = false 
	end
end

local function spawnCar(ped, car)
	local hash = GetHashKey(car)
	local p = vector3(-184.55, -1289.80, 30.66)
	Citizen.CreateThread(function()
		RequestModel(hash)
		while not HasModelLoaded(hash) do Citizen.Wait(10) end

		local vehicle = CreateVehicle(hash, p.x, p.y, p.z, 220.01, true, false)

		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    end)
end

local function init()
	menuThread = false
	isMecano = true
	inServiceMecano = false
	pzCore.mug("Statut de service","Mécano","Vous êtes actuellement considéré comme étant ~r~hors service~s~. Vous pouvez changer ce statut avec votre menu ~o~[F6]")
	jobMenu()
end

local function createBlip()
    local blip = AddBlipForCoord(-211.77, -1326.25, 30.89)
	SetBlipSprite(blip, 72)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 47)
	SetBlipScale(blip, 0.5)
	SetBlipCategory(blip, 12)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Mécano")
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

function GetPrice(price)
	local pVeh = GetVehiclePedIsIn(pPed, 0)
	local pClass = GetVehicleClass(pVeh)
	local multi = priceByClass[pClass].multi
	return price * multi
end

function UpdateVehProps()
	local pPed = GetPlayerPed(-1)
	local pVeh = GetVehiclePedIsIn(pPed, 0)
	VehProps = ESX.Game.GetVehicleProperties(pVeh)
end

local current = "mecano"

pzCore.jobs[current].jobMenu = jobMenu
pzCore.jobs[current].init = init
pzCore.jobs[current].jobChanged = jobChanged
pzCore.jobs[current].spawnCar = spawnCar
pzCore.jobs[current].createBlip = createBlip
pzCore.jobs[current].setUniform = setUniform
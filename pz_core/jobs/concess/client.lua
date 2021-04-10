local NumberCharset = {}
local Charset = {}
vehDansLeConcess = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

local function init()

end

function loadVehConcess()
    ESX.TriggerServerCallback('esx_vehicleshop:afficherVeh', function(result)
        vehDansLeConcess = result
    end)
end

function CreateLocalVeh(model, props, name, vip)
    RenderScriptCams(1, 0, 0, 0, 0)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1) end

    local veh = CreateVehicle(model, -45.13, -1098.05, 25.81, 250.94, false, true)
    SetVehicleOnGroundProperly(veh)
    FreezeEntityPosition(veh, 1)
    if props then
        ESX.Game.SetVehicleProperties(veh, props)
    end
    --TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
    local_veh.entity = veh
    local_veh.model = model
    local_veh.props = ESX.Game.GetVehicleProperties(veh)

    if name ~= nil then local_veh.name = name end
    SetModelAsNoLongerNeeded(model)
    rotate = false
    Wait(50)
end

function camConcessEnter()
    cam = CreateCam("DEFAULT_SCRIPTED_Camera", 1)	
    local ped = GetPlayerPed(-1)
    SetCamParams(cam, -37.36, -1105.42, 26.42, -10.6106, -0.5186, -80.0, 44.9959, 205.39122, 1, 1, 2)
    RenderScriptCams(true, false, 3000, 1, 1, 0)
    PointCamAtCoord(cam, -45.13, -1098.05, 25.81)
end

function destorycam() 	
    cam = CreateCam("DEFAULT_SCRIPTED_Camera", 1)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
end

local function createBlip()
    local blip = AddBlipForCoord(-45.13, -1098.05, 25.81)
	SetBlipSprite(blip, 225)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 4)
	SetBlipScale(blip, 0.5)
	SetBlipCategory(blip, 12)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Concessionnaire")
	EndTextCommandSetBlipName(blip)
end

function GetRandomNumber(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end



local current = "concess"

pzCore.jobs[current].init = init
pzCore.jobs[current].createBlip = createBlip
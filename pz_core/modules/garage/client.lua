local GaraOpen = false
local FourOpen = false
local RangOpen = false
local elements = {}
local elementsFouriere = {}

local this_Garage = {}

local function deleteMenus()
    RageUI.CloseAll()
end

local function SpawnVehicle(vehicle)

    ESX.Game.SpawnVehicle(vehicle.model, vector3(this_Garage.spawn.x, this_Garage.spawn.y, this_Garage.spawn.z), this_Garage.heading, function(callback_vehicle)
        ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
        SetVehRadioStation(callback_vehicle, "OFF")
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
    end)
    TriggerServerEvent('garage:modifystate', vehicle.plate, 1)
    
end

local function SpawnVehicleFouriere(vehicle)

    ESX.Game.SpawnVehicle(vehicle.model, vector3(this_Garage.spawn.x, this_Garage.spawn.y, this_Garage.spawn.z), this_Garage.heading, function(callback_vehicle)
        ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
        SetVehRadioStation(callback_vehicle, "OFF")
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
    end)

    TriggerServerEvent('garage:modifystate', vehicle.plate, 0)
    
end

local function RangeVehicle(vehicle)
	TriggerServerEvent('garage:modifystate', vehicle.plate, 0)
end

local function openMenuFouriere(infos, id)
    RMenu.Add("pz_core_four", "pz_core_four_main", RageUI.CreateMenu("Garage","Choisissez un véhicule"))
    RMenu:Get('pz_core_four', 'pz_core_four_main').Closed = function()
        FourOpen = false
    end

    if not FourOpen then 
        FourOpen = true
    RageUI.Visible(RMenu:Get('pz_core_four', 'pz_core_four_main'), not RageUI.Visible(RMenu:Get('pz_core_four', 'pz_core_four_main')))
    Citizen.CreateThread(function()
        local dist,actualItem = 0,{}
        while dist < 1.5 do
            dist = GetDistanceBetweenCoords(infos.loc, GetEntityCoords(PlayerPedId()), false)
            dynamicMenu4 = true

            RageUI.IsVisible(RMenu:Get("pz_core_four",'pz_core_four_main'),true,true,true,function()
                for k,v in pairs(elementsFouriere) do 
                    RageUI.ButtonWithStyle("[~b~"..v.plaque.."~s~] - "..v.name, nil, {RightLabel = "~o~En fourière"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnVehicleFouriere(v.model)
                            deleteMenus()
                            TriggerServerEvent("garage:buy", Garage_Config.priceFourire)
                            table.remove(elementsFouriere, k)
                            ESX.ShowNotification("Vous avez sortis votre ~b~"..v.name.."~s~.")
                        end
                    end)
                end
            end, function()    
            end, 1)

            Citizen.Wait(0)
        end
        FourOpen = false
        dynamicMenu4 = false
        deleteMenus()
    end)
end
end

local function openMenuGarage(infos, id)
    elements = {}
    RMenu.Add("pz_core_gara", "pz_core_gara_main", RageUI.CreateMenu("Garage","Choisissez un véhicule"))
    RMenu:Get('pz_core_gara', 'pz_core_gara_main').Closed = function()
        GaraOpen = false
    end
    
    ESX.TriggerServerCallback('garage:getVehicles', function(vehicles)
        for k,v in pairs(vehicles) do
            local hashVehicule = v.vehicle.model
            local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
            local stateGarage

            if (v.state) then
                stateGarage = '~r~Sortie'
            else
                stateGarage = '~g~Ranger'
            end	

            table.insert(elements, { label = vehicleName, model = v.vehicle, state = stateGarage, pouvoirSortir = v.state, plate = v.vehicle.plate})
        end

    end)

    if not GaraOpen then 
    GaraOpen = true
    RageUI.Visible(RMenu:Get('pz_core_gara', 'pz_core_gara_main'), not RageUI.Visible(RMenu:Get('pz_core_gara', 'pz_core_gara_main')))
    Citizen.CreateThread(function()
        local dist,actualItem = 0,{}
        while dist < 1.5 do
            dist = GetDistanceBetweenCoords(infos.loc, GetEntityCoords(PlayerPedId()), false)
            dynamicMenu4 = true

            RageUI.IsVisible(RMenu:Get("pz_core_gara",'pz_core_gara_main'),true,true,true,function()
                for k,v in pairs(elements) do 
                    RageUI.ButtonWithStyle("[~b~"..v.plate.."~s~] - "..v.label, nil, {RightLabel = v.state}, true, function(Hovered, Active, Selected)
                        if Selected then
                            if (v.pouvoirSortir) then 
                                ESX.ShowNotification("~r~Votre véhicule est déjà sortie ou est en fourière !")
                            else
                                SpawnVehicle(v.model)
                                deleteMenus()
                                ESX.ShowNotification("Vous avez sortis votre ~b~"..v.label.."~s~.")
                                table.insert(elementsFouriere, {name = v.label, model = v.model, plaque = v.plate})
                            end
                        end
                    end)
                end
            end, function()    
            end, 1)

            Citizen.Wait(0)
        end
        GaraOpen = false
        dynamicMenu4 = false
        deleteMenus()
    end)
end
end

local function openMenuRangeVeh(infos, id)
    RMenu.Add("pz_core_rang", "pz_core_rang_main", RageUI.CreateMenu("Garage","Ranger votre véhicule"))
    RMenu:Get('pz_core_rang', 'pz_core_rang_main').Closed = function()
        RangOpen = false
    end

    if not RangOpen then 
        RangOpen = true
    RageUI.Visible(RMenu:Get('pz_core_rang', 'pz_core_rang_main'), not RageUI.Visible(RMenu:Get('pz_core_rang', 'pz_core_rang_main')))
    Citizen.CreateThread(function()
        local dist,actualItem = 0,{}
        while dist < 1.5 do
            dist = GetDistanceBetweenCoords(infos.loc, GetEntityCoords(PlayerPedId()), false)
            dynamicMenu4 = true

            RageUI.IsVisible(RMenu:Get("pz_core_rang",'pz_core_rang_main'),true,true,true,function()
                RageUI.ButtonWithStyle("Ranger", nil, {RightLabel = "~b~Éxecuter ~s~→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local playerPed  = GetPlayerPed(-1)
                        local vehicle       = GetVehiclePedIsUsing(playerPed)
		                local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
                        ESX.TriggerServerCallback('garage:stockv',function(valid)
                            if (valid) then
                                TriggerServerEvent('garage:debug', vehicle)
                                DeleteVehicle(vehicle)
                                TriggerServerEvent('garage:modifystate', vehicleProps.plate, 0)
                                ESX.ShowNotification("~g~Votre véhicule est dans le garage !")
                            else
                                ESX.ShowNotification("~r~Ce n'est pas votre véhicule !")
                            end
                        end, vehicleProps)
                        RageUI.CloseAll()
                    end
                end)
            end, function()    
            end, 1)

            Citizen.Wait(0)
        end
        RangOpen = false
        dynamicMenu4 = false
        deleteMenus()
    end)
end
end

local function initializeMarkers()
    for k,v in pairs(pzCore.garage.config.sortir) do
        local markerID = "garageRange"..k
        local data = {
            position = vector3(v.loc.x, v.loc.y, v.loc.z),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 0, g = 255, b = 0},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder aux garage",
            interact = function()
                this_Garage = v
                if IsPedSittingInAnyVehicle(PlayerPedId(-1)) then
                    ESX.ShowNotification("~r~Sort de ton véhicule !")
                else 
                    openMenuGarage(v,k) 
                end
            end
        }
        pzCore.markers.add(markerID,data)
        pzCore.markers.subscribe(markerID)
    end

    for k,v in pairs(pzCore.garage.config.range) do
        local markerID = "garageSortir"..k
        local data = {
            position = vector3(v.loc.x, v.loc.y, v.loc.z),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 255, g = 0, b = 0},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour ranger votre véhicule",
            interact = function() 
                this_Garage = v
                if IsPedSittingInAnyVehicle(PlayerPedId(-1)) then
                    openMenuRangeVeh(v,k)
                else 
                    ESX.ShowNotification("~r~Tu dois être dans un véhicule !")
                end
            end
        }
        pzCore.markers.add(markerID,data)
        pzCore.markers.subscribe(markerID)
    end

    for k,v in pairs(pzCore.garage.config.fouriere) do
        local markerID = "fouriere"..k
        local data = {
            position = vector3(v.loc.x, v.loc.y, v.loc.z),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 255, g = 128, b = 0},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder à la fourière",
            interact = function() 
                this_Garage = v
                openMenuFouriere(v,k)
            end
        }
        pzCore.markers.add(markerID,data)
        pzCore.markers.subscribe(markerID)
        local blip = AddBlipForCoord(v.loc.x, v.loc.y, v.loc.z)
        SetBlipSprite(blip, 67)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 81)
        SetBlipScale(blip, 0.5)
        SetBlipCategory(blip, 12)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Fourière")
        EndTextCommandSetBlipName(blip)
    end
end

local function initGarage()
    for _,v in pairs(pzCore.garage.config.range) do 
        pzCore.garage.config.createBlip(v.loc) 
    end

    initializeMarkers()
end

pzCore.garage.init = initGarage
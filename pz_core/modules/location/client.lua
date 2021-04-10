local inMenu = false
local vehIndex = 1

local function openMenuLocation(infos, id)
    RMenu.Add("pz_core_loc", "pz_core_loc_main", RageUI.CreateMenu("Location","Voici nos véhicule :"))
    RMenu:Get('pz_core_loc', 'pz_core_loc_main').Closed = function()
        inMenu = false
    end

    if not inMenu then 
        inMenu = true
    RageUI.Visible(RMenu:Get('pz_core_loc', 'pz_core_loc_main'), not RageUI.Visible(RMenu:Get('pz_core_loc', 'pz_core_loc_main')))
    Citizen.CreateThread(function()
        local dist,actualItem = 0, {}
        while dist < 1.5 do
            dist = GetDistanceBetweenCoords(infos.loc, GetEntityCoords(PlayerPedId()), false)
            dynamicMenu4 = true
            local price 
            if pzCore.location.config.vehList[vehIndex] == 'Akuma' then 
                price = 300
            end
            if pzCore.location.config.vehList[vehIndex] == 'Blista' then 
                price = 500
            end
            RageUI.IsVisible(RMenu:Get("pz_core_loc",'pz_core_loc_main'),true,true,true,function()
                RageUI.List("Choissisez votre véhicule", pzCore.location.config.vehList, vehIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
                    vehIndex = Index
                end)
                RageUI.Separator("")
                RageUI.ButtonWithStyle("Faire apparaître : ~g~"..pzCore.location.config.vehList[vehIndex], nil, {RightLabel = "Prix : ~r~"..price.."$"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("location:buy", price, pzCore.location.config.vehList[vehIndex])
                        ESX.Game.SpawnVehicle(pzCore.location.config.vehList[vehIndex], vector3(-506.49, -668.23, 32.99), 291.14, function(callback_vehicle)
                            SetVehRadioStation(callback_vehicle, "OFF")
                            TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
                            SetVehicleNumberPlateText(callback_vehicle, "LOCATION")
                        end)
                        RageUI.CloseAll()
                    end
                end)
            end, function()    
            end, 1)

            Citizen.Wait(0)
        end
        inMenu = false
        dynamicMenu4 = false
    end)
end
end

local function initializeMarkers()
    for k,v in pairs(pzCore.location.config.pos) do
        local markerID = "locationVeh"..k
        local data = {
            position = vector3(v.loc.x, v.loc.y, v.loc.z),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 0, g = 0, b = 150},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder au location de véhicule",
            interact = function()
                openMenuLocation(v,k)
            end
        }
        pzCore.markers.add(markerID,data)
        pzCore.markers.subscribe(markerID)
    end
end

local function initLocation()
    for _,v in pairs(pzCore.location.config.pos) do 
        pzCore.location.config.createBlip(v.loc) 
    end

    initializeMarkers()
end

pzCore.location.init = initLocation
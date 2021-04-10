dynamicMenu,dynamicMenu2,dynamicMenu3,dynamicMenu4, rotate = false,false,false,false,true
local codesCooldown = false
local returnedPlayerData = nil
local colorVar = "~o~"
local closestPlayer, closestDistance
local currentTask = {}
-- CONCESS
local vehConcess = {}
local vehChoisis = 0
local vehDuConessChoisis = 0
local currentDisplayVehicle = nil
local sortieOuPas = true
local_veh = {
    props = nil,
    entity = nil,
    model = nil,
    price = nil,
}
-- MECANO
local VehProps = {}
local Upgrades = {}
local Comsetics = {}
local isBusy = false
-- EMS
local PlayerSelected = {}
local selected2 = nil

Menus = {
    

    menus = {
        {cat = "police_clothes", name = "police_clothes_main", title = "Vestiaires", desc = "Changez votre tenue", pos = vector3(461.83, -999.15, 30.68)},
        {cat = "police_armory", name = "police_armory_main", title = "Armurerie", desc = "Obtenez vos armes de service", pos = vector3(479.11, -996.80, 30.69)},
        {cat = "police_vehicle", name = "police_vehicle_main", title = "Garage", desc = "Sortez le véhicule de votre choix", pos = vector3(427.64, -973.83, 25.69)},
        {cat = "police_boat", name = "police_boat_main", title = "Garage Bateau", desc = "Sortez le bateau de votre choix", pos = vector3(678.26, -1524.35, 9.70)},
        {cat = "police_heli", name = "police_heli_main", title = "Héliport", desc = "Sortez l'hélicoptère de votre choix", pos = vector3(455.99, -985.68, 43.69)},
        {cat = "police_jail", name = "police_jail_main", title = "Cellules", desc = "Sélectionnez votre tenue", pos = vector3(480.39, -1009.33, 26.27)},
        {cat = "unicorn_barman", name = "unicorn_barman_main", title = "Bar", desc = "Bar de l'unicorn", pos = vector3(129.96, -1283.35, 29.27)},
        {cat = "unicorn_vehicle", name = "unicorn_vehicle_main", title = "Garage", desc = "Sortez le véhicule de votre choix", pos = vector3(147.68, -1294.79, 29.27)},
        {cat = "unicorn_clothes", name = "unicorn_clothes_main", title = "Vestiaires", desc = "Changez votre tenue", pos = vector3(105.48, -1303.11, 28.76)},
        
        

        {cat = "taxi_vehicle", name = "taxi_vehicle_main", title = "Garage", desc = "Sortez le véhicule de votre choix", pos = vector3(915.57, -173.87, 74.35)},
        {cat = "taxi_clothes", name = "taxi_clothes_main", title = "Vestiaires", desc = "Changez votre tenue", pos = vector3(914.05, -159.04, 74.83)},

        {cat = "taxi_clothes", name = "taxi_clothes_main", title = "Vestiaires", desc = "Changez votre tenue", pos = vector3(914.05, -159.04, 74.83)},

        {cat = "ammo_train", name = "ammo_train_main", title = "Entrainement", desc = "Améliorez vos réflexes", pos = vector3(816.94, -2161.91, 29.61)},
        
        {cat = "vigneron_vehicle", name = "vigneron_vehicle_main", title = "Garage", desc = "Sortez le véhicule de votre choix", pos = vector3(-1896.61, 2052.12, 140.89)},
        {cat = "vigneron_clothes", name = "vigneron_clothes_main", title = "Vestiaires", desc = "Changez votre tenue", pos = vector3(-1901.94, 2063.88, 140.88)},

        {cat = "brasseur_vehicle", name = "brasseur_vehicle_main", title = "Garage", desc = "Sortez le véhicule de votre choix", pos = vector3(-1896.61, 2052.12, 140.89)},
        {cat = "brasseur_clothes", name = "brasseur_clothes_main", title = "Vestiaires", desc = "Changez votre tenue", pos = vector3(-255.11, -2577.94, 6.00)},

        {cat = "bucheron_vehicle", name = "bucheron_vehicle_main", title = "Garage", desc = "Sortez le véhicule de votre choix", pos = vector3(-253.31, -2582.83, 6.0)},
{cat = "bucheron_clothes", name = "bucheron_clothes_main", title = "Vestiaires", desc = "Changez votre tenue", pos = vector3(-1901.94, 2063.88, 140.88)},

        {cat = "concess_actions", name = "concess_actions_main", title = "Concessionnaire", desc = "Choisissez une action", pos = vector3(-29.09, -1103.77, 26.42)},
        {cat = "concess_categories", name = "concess_categories_main", title = "Catégories", desc = "Choisissez une catégorie", pos = vector3(-29.09, -1103.77, 26.42)},
        --CATEGORIE
        {cat = "concess_compact", name = "concess_compact_main", title = "Compacts", desc = "Choisissez un véhicule", pos = vector3(-29.09, -1103.77, 26.42)},
        {cat = "concess_coupes", name = "concess_coupes_main", title = "Coupes", desc = "Choisissez un véhicule", pos = vector3(-29.09, -1103.77, 26.42)},
        {cat = "concess_muscle", name = "concess_muscle_main", title = "Muscle", desc = "Choisissez un véhicule", pos = vector3(-29.09, -1103.77, 26.42)},
        {cat = "concess_offroad", name = "concess_offroad_main", title = "Off-Road", desc = "Choisissez un véhicule", pos = vector3(-29.09, -1103.77, 26.42)},
        {cat = "concess_suv", name = "concess_suv_main", title = "SUVs", desc = "Choisissez un véhicule", pos = vector3(-29.09, -1103.77, 26.42)},
        {cat = "concess_sedans", name = "concess_sedans_main", title = "Sedans", desc = "Choisissez un véhicule", pos = vector3(-29.09, -1103.77, 26.42)},
        {cat = "concess_sport", name = "concess_sport_main", title = "Sport", desc = "Choisissez un véhicule", pos = vector3(-29.09, -1103.77, 26.42)},
        {cat = "concess_sportclass", name = "concess_sportclass_main", title = "Sport Classique", desc = "Choisissez un véhicule", pos = vector3(-29.09, -1103.77, 26.42)},
        {cat = "concess_super", name = "concess_super_main", title = "Super", desc = "Choisissez un véhicule", pos = vector3(-29.09, -1103.77, 26.42)},
        {cat = "concess_van", name = "concess_van_main", title = "Vans", desc = "Choisissez un véhicule", pos = vector3(-29.09, -1103.77, 26.42)},
        {cat = "concess_moto", name = "concess_moto_main", title = "Moto", desc = "Choisissez un véhicule", pos = vector3(-29.09, -1103.77, 26.42)},
        --FIN CATEGORIE
        {cat = "yesorno", name = "yesorno_main", title = "Confirmation", desc = "Choix définitif", pos = vector3(-29.09, -1103.77, 26.42)},
        {cat = "veh_concess", name = "veh_concess_main", title = "Vehicule", desc = "Véhicule dans le concessionnaire :", pos = vector3(-29.09, -1103.77, 26.42)},
        {cat = "action_vehConcess", name = "action_vehConcess_main", title = "Action", desc = "Que voulez-vous faire ?", pos = vector3(-29.09, -1103.77, 26.42)},
        -- CATALOGUE
        {cat = "catalogue", name = "catalogue_main", title = "Catalogue", desc = "Choisissez une catégorie", pos = vector3(-55.91, -1096.03, 26.42)},
        {cat = "concess2_compact", name = "concess_compact_main", title = "Compacts", desc = "Choisissez un véhicule", pos = vector3(-55.91, -1096.03, 26.42)},
        {cat = "concess2_coupes", name = "concess_coupes_main", title = "Coupes", desc = "Choisissez un véhicule", pos = vector3(-55.91, -1096.03, 26.42)},
        {cat = "concess2_muscle", name = "concess_muscle_main", title = "Muscle", desc = "Choisissez un véhicule", pos = vector3(-55.91, -1096.03, 26.42)},
        {cat = "concess2_offroad", name = "concess_offroad_main", title = "Off-Road", desc = "Choisissez un véhicule", pos = vector3(-55.91, -1096.03, 26.42)},
        {cat = "concess2_suv", name = "concess_suv_main", title = "SUVs", desc = "Choisissez un véhicule", pos = vector3(-55.91, -1096.03, 26.42)},
        {cat = "concess2_sedans", name = "concess_sedans_main", title = "Sedans", desc = "Choisissez un véhicule", pos = vector3(-55.91, -1096.03, 26.42)},
        {cat = "concess2_sport", name = "concess_sport_main", title = "Sport", desc = "Choisissez un véhicule", pos = vector3(-55.91, -1096.03, 26.42)},
        {cat = "concess2_sportclass", name = "concess_sportclass_main", title = "Sport Classique", desc = "Choisissez un véhicule", pos = vector3(-55.91, -1096.03, 26.42)},
        {cat = "concess2_super", name = "concess_super_main", title = "Super", desc = "Choisissez un véhicule", pos = vector3(-55.91, -1096.03, 26.42)},
        {cat = "concess2_van", name = "concess_van_main", title = "Vans", desc = "Choisissez un véhicule", pos = vector3(-55.91, -1096.03, 26.42)},
        {cat = "concess2_moto", name = "concess_moto_main", title = "Moto", desc = "Choisissez un véhicule", pos = vector3(-55.91, -1096.03, 26.42)},
        -- FIN CATALOGUE
        {cat = "mecano", name = "mecano_main", title = "LSCUSTOM", desc = "Customisation", pos = vector3(-211.77, -1326.25, 30.89)},
        {cat = "mecano_vestiaire", name = "mecano_vestiaire_main", title = "Vestiaire", desc = "Action disponible:", pos = vector3(-215.65, -1318.47, 30.89)},
        {cat = "mecano_vehicle", name = "mecano_vehicle_main", title = "Garage", desc = "Sortez le véhicule de votre choix", pos = vector3(-191.33, -1297.32, 31.29)},

        {cat = "cosmetic", name = "cosmetic_main", title = "Custom visuel du véhicule", desc = "Customisation", pos = vector3(-211.77, -1326.25, 30.89) and vector3(-223.02, -1330.89, 30.89)},
        {cat = "upgrade", name = "upgrade_main", title = "Custom interne du véhicule", desc = "Customisation", pos = vector3(-211.77, -1326.25, 30.89) and vector3(-223.02, -1330.89, 30.89)},
        {cat = "option", name = "option_main", title = "Custom visuel du véhicule", desc = "Customisation", pos = vector3(-211.77, -1326.25, 30.89) and vector3(-223.02, -1330.89, 30.89)},
        {cat = "peinture", name = "peinture_main", title = "Custom visuel du véhicule", desc = "Customisation", pos = vector3(-211.77, -1326.25, 30.89) and vector3(-223.02, -1330.89, 30.89)},
        {cat = "Choixcouleur", name = "Choixcouleur_main", title = "Custom visuel du véhicule", desc = "Customisation", pos = vector3(-211.77, -1326.25, 30.89) and vector3(-223.02, -1330.89, 30.89)},
        {cat = "roue", name = "roue_main", title = "Custom visuel du véhicule", desc = "Customisation", pos = vector3(-211.77, -1326.25, 30.89) and vector3(-223.02, -1330.89, 30.89)},
        {cat = "couleur", name = "couleur_main", title = "Custom visuel du véhicule", desc = "Customisation", pos = vector3(-211.77, -1326.25, 30.89) and vector3(-223.02, -1330.89, 30.89)},
        {cat = "neon", name = "neon_main", title = "Custom visuel du véhicule", desc = "Customisation", pos = vector3(-211.77, -1326.25, 30.89) and vector3(-223.02, -1330.89, 30.89)},
        
        {cat = "ambulance_vehicle", name = "ambulance_vehicle_main", title = "Garage", desc = "Sortez le véhicule de votre choix", pos = vector3(298.21, -605.31, 43.35)},
        {cat = "ambulance_vestiaire", name = "ambulance_vestiaire_main", title = "Vestiaire", desc = "Action disponible:", pos = vector3(301.55, -599.24, 43.28)},
        {cat = "ambulance_pharmacie", name = "ambulance_pharmacie_main", title = "Pharmacie", desc = "Action disponible:", pos = vector3(310.19, -565.86, 43.28)},
        {cat = "ambulance_heli", name = "ambulance_heli_main", title = "Héliport", desc = "Sortez l'hélicoptère de votre choix", pos = vector3(341.69, -591.30, 74.16)},
    },
    
    init = function()
        -- Creating menus
        pzCore.trace("Initializing menu thread")
        
        for _,menu in pairs(Menus.menus) do
            RMenu.Add(menu.cat, menu.name, RageUI.CreateMenu(menu.title,menu.desc))
            RMenu:Get(menu.cat, menu.name).Closed = function()
                local pPed = GetPlayerPed(-1)
                local pVeh = GetVehiclePedIsIn(pPed, 0)
                DeleteVehicle(local_veh.entity)
                destorycam()
                FreezeEntityPosition(pVeh, 0)
            end
            
        end

        Citizen.CreateThread(function()
            for k,v in ipairs(Interne) do
                RMenu.Add('mecano', v.name, RageUI.CreateSubMenu(RMenu:Get('upgrade', 'upgrade_main'), "", "~b~LS CUSTOMS", nil, nil, "shopui_title_carmod", "shopui_title_carmod"))
                RMenu:Get('mecano', v.name).Closed = function()
                    local pPed = GetPlayerPed(-1)
                    local pVeh = GetVehiclePedIsIn(pPed, 0)
                    ESX.Game.SetVehicleProperties(pVeh, VehProps)
                    SetVehicleEngineOn(pVeh, 0, 1, 1)
                end
            end
        
            for k,v in ipairs(Externe) do
                RMenu.Add('mecano', v.name, RageUI.CreateSubMenu(RMenu:Get('cosmetic', 'cosmetic_main'), "", "~b~LS CUSTOMS", nil, nil, "shopui_title_carmod", "shopui_title_carmod"))
                RMenu:Get('mecano', v.name).Closed = function()
                    local pPed = GetPlayerPed(-1)
                    local pVeh = GetVehiclePedIsIn(pPed, 0)
                    ESX.Game.SetVehicleProperties(pVeh, VehProps)
                    SetVehicleDoorsShut(pVeh, false)
                    SetVehicleEngineOn(pVeh, 0, 1, 1)
                end
            end
        
            for k,v in ipairs(weels) do
                RMenu.Add('mecano', v.name, RageUI.CreateSubMenu(RMenu:Get('roue', 'roue_main'), "", "~b~LS CUSTOMS", nil, nil, "shopui_title_carmod", "shopui_title_carmod"))
                RMenu:Get('mecano', v.name).Closed = function()
                    local pPed = GetPlayerPed(-1)
                    local pVeh = GetVehiclePedIsIn(pPed, 0)
                    ESX.Game.SetVehicleProperties(pVeh, VehProps)
                    SetVehicleDoorsShut(pVeh, false)
                    SetVehicleEngineOn(pVeh, 0, 1, 1)
                end
            end
        
            for k,v in ipairs(Colors) do
                RMenu.Add('mecano', v.value, RageUI.CreateSubMenu(RMenu:Get('Choixcouleur', 'Choixcouleur_main'), "", "~b~LS CUSTOMS", nil, nil, "shopui_title_carmod", "shopui_title_carmod"))
                RMenu:Get('mecano', v.value).Closed = function()
                    local pPed = GetPlayerPed(-1)
                    local pVeh = GetVehiclePedIsIn(pPed, 0)
                    ESX.Game.SetVehicleProperties(pVeh, VehProps)
                    SetVehicleDoorsShut(pVeh, false)
                    SetVehicleEngineOn(pVeh, 0, 1, 1)
                end
            end
        end)

        Citizen.CreateThread(function()
            while true do
                if colorVar == "~o~" then
                    colorVar = "~r~" 
                else
                    colorVar = "~o~"

                end
                Citizen.Wait(800)
            end
        end)

        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(500)
                local pos = GetEntityCoords(PlayerPedId())
                local needToCloseMenus = true
                for _,menu in pairs(Menus.menus) do 
                    if GetDistanceBetweenCoords(pos, menu.pos, true) < 1.5 then needToCloseMenus = false end
                end

                if needToCloseMenus and not dynamicMenu and not dynamicMenu2 and not dynamicMenu3 and not dynamicMenu4 then 
                    RageUI.CloseAll()
                end
            end
        end)

        Citizen.CreateThread(function()
            while true do
                local menu = false

                RageUI.IsVisible(RMenu:Get("ammo_train",'ammo_train_main'),true,true,true,function()
                    pzCore.armory.drawTraining()
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("taxi_vehicle",'taxi_vehicle_main'),true,true,true,function()
                    for k,v in pairs(pzCore.jobs["taxi"].config.vehicles) do
                        RageUI.ButtonWithStyle(v.label,nil, {RightLabel = "~b~Sortir~s~ →→"}, not codesCooldown, function(_,_,s)
                            if s then
                                RageUI.CloseAll()
                                pzCore.jobs["taxi"].spawnCar(PlayerPedId(),v.model)
                            end
                        end)
                    end
                end, function()    
                end, 1)
                
                RageUI.IsVisible(RMenu:Get("unicorn_dynamicmenu",'unicorn_dynamicmenu_main'),true,true,true,function()
                    menu = true
                    RageUI.ButtonWithStyle("Donner une facture",nil, {RightLabel = "~b~Facturer~s~ →→"}, true, function(_,_,s)
                        if s then
                            local raison = ""
                            local montant = 0
                            AddTextEntry("FMMC_MPM_NA", "Raison de la facture")
                            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez une raison de la facture:", "", "", "", "", 30)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0)
                                Wait(0)
                            end
                            if (GetOnscreenKeyboardResult()) then
                                local result = GetOnscreenKeyboardResult()
                                if result then
                                    raison = result
                                    result = nil
                                    AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le montant de la facture:", "", "", "", "", 30)
                                    while (UpdateOnscreenKeyboard() == 0) do
                                        DisableAllControlActions(0)
                                        Wait(0)
                                    end
                                    if (GetOnscreenKeyboardResult()) then
                                        result = GetOnscreenKeyboardResult()
                                        if result then
                                            montant = result
                                            result = nil
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_unicorn', raison, tonumber(montant))
                                            pzCore.mug("~r~Tablette Unicorn", "Facture envoyée","Vous avez envoyé une facture à la personne: ~b~\""..raison.."\"~s~: ~r~"..montant.."$")
                                        end
                                    end
                                    
                                end
                            end
                        end
                    end)


                    RageUI.ButtonWithStyle("Unicorn ~g~ouvert",nil, {RightLabel = "~b~Annoncer~s~ →→"}, not codesCooldown, function(_,_,s)
                        if s then
                            codesCooldown = true
                            TriggerServerEvent("pz_core:unicorn_state", true)
                            Citizen.SetTimeout(60000, function() codesCooldown = false end)
                        end
                    end)

                    RageUI.ButtonWithStyle("Unicorn ~r~fermé",nil, {RightLabel = "~b~Annoncer~s~ →→"}, not codesCooldown, function(_,_,s)
                        if s then
                            codesCooldown = true 
                            TriggerServerEvent("pz_core:unicorn_state", false)
                            Citizen.SetTimeout(60000, function() codesCooldown = false end)
                        end
                    end)
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("taxi_dynamicmenu",'taxi_dynamicmenu_main'),true,true,true,function()
                    menu = true
                    RageUI.ButtonWithStyle("Donner une facture",nil, {RightLabel = "~b~Facturer~s~ →→"}, true, function(_,_,s)
                        if s then
                            local raison = ""
                            local montant = 0



                            AddTextEntry("FMMC_MPM_NA", "Raison de la facture")
                            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez une raison de la facture:", "", "", "", "", 30)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0)
                                Wait(0)
                            end
                            if (GetOnscreenKeyboardResult()) then
                                local result = GetOnscreenKeyboardResult()
                                if result then
                                    raison = result
                                    result = nil
                                    AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le montant de la facture:", "", "", "", "", 30)
                                    while (UpdateOnscreenKeyboard() == 0) do
                                        DisableAllControlActions(0)
                                        Wait(0)
                                    end
                                    if (GetOnscreenKeyboardResult()) then
                                        result = GetOnscreenKeyboardResult()
                                        if result then
                                            montant = result
                                            result = nil
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_taxi', raison, tonumber(montant))
                                            pzCore.mug("~r~Tablette Taxi", "Facture envoyée","Vous avez envoyé une facture à la personne: ~b~\""..raison.."\"~s~: ~r~"..montant.."$")
                                        end
                                    end
                                    
                                end
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle("Missions",nil, {RightLabel = "~b~Commencer~s~ →→"}, true, function(_,_,s)
                        if s then
                            if missionTaxiStart then
                                StopTaxiJob()
                            else
                                if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'taxi' then
                                    local playerPed = PlayerPedId()
                                    local vehicle   = GetVehiclePedIsIn(playerPed, false)
                            
                                    missionTaxiStart = true
                            
                                    if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
                                        if tonumber(ESX.PlayerData.job.grade) >= 3 then
                                            StartTaxiJob()
                                        else
                                            if IsInAuthorizedVehicle() then
                                                StartTaxiJob()
                                                RageUI.CloseAll()
                                            else
                                                ESX.ShowNotification("Vous devez être dans un taxi pour commencer la mission")
                                            end
                                        end
                                    else
                                        if tonumber(ESX.PlayerData.job.grade) >= 3 then
                                            ESX.ShowNotification('Vous devez être dans un véhicule pour commencer la mission')
                                        else
                                            ESX.ShowNotification("Vous devez être dans un taxi pour commencer la mission")
                                        end
                                    end
                                end
                            end
                        end
                    end)

                end, function()    
                end, 1)  


                    
                RageUI.IsVisible(RMenu:Get("unicorn_barman",'unicorn_barman_main'),true,true,true,function()
                    RageUI.Separator("↓ ~b~Boissons avec alcool ↓")
                    
                    for k,v in pairs(pzCore.jobs["unicorn"].config.drinks.alcool) do
                        RageUI.ButtonWithStyle(v.label,"~b~Cette boisson est alcoolisé", {RightLabel = "~b~Prendre~s~ →→"}, true, function(_,_,s)
                            if s then
                                TriggerServerEvent("pz_core:giveDrink", v.item)
                            end
                        end)
                    end

                    RageUI.Separator("↓ ~b~Boissons sans alcool ↓")

                    for k,v in pairs(pzCore.jobs["unicorn"].config.drinks.noalcool) do
                        RageUI.ButtonWithStyle(v.label,"~b~Cette boisson ~g~ne contient pas~b~ d'alcool", {RightLabel = "~b~Prendre~s~ →→"}, true, function(_,_,s)
                            if s then
                                RageUI.CloseAll()
                                TriggerServerEvent("pz_core:giveDrink", v.item)
                            end
                        end)
                    end
                end, function()    
                end, 1)


                RageUI.IsVisible(RMenu:Get("unicorn_clothes",'unicorn_clothes_main'),true,true,true,function()

                    RageUI.ButtonWithStyle("Tenue de base",nil, {RightLabel = "~b~Changer~s~ →→"}, true, function(_,_,s)
                        if s then
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                            end)
                        end
                    end)

                    
                    for i = 1,#pzCore.jobs["unicorn"].config.clothes do
                        RageUI.ButtonWithStyle(pzCore.jobs["unicorn"].config.clothes[i].label,nil, {RightLabel = "~b~Changer~s~ →→"}, true, function(_,_,s)
                            if s then
                                pzCore.jobs["unicorn"].setUniform(PlayerPedId(),i)
                            end
                        end)
                    end
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("taxi_clothes",'taxi_clothes_main'),true,true,true,function()

                    RageUI.ButtonWithStyle("Tenue de base",nil, {RightLabel = "~b~Changer~s~ →→"}, true, function(_,_,s)
                        if s then
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                            end)
                        end
                    end)

                    
                    for i = 1,#pzCore.jobs["taxi"].config.clothes do
                        RageUI.ButtonWithStyle(pzCore.jobs["taxi"].config.clothes[i].label,nil, {RightLabel = "~b~Changer~s~ →→"}, true, function(_,_,s)
                            if s then
                                pzCore.jobs["unicorn"].setUniform(PlayerPedId(),i)
                            end
                        end)
                    end
                end, function()    
                end, 1)



                RageUI.IsVisible(RMenu:Get("brasseur_clothes",'brasseur_clothes_main'),true,true,true,function()

                    RageUI.ButtonWithStyle("Tenue de base",nil, {RightLabel = "~b~Changer~s~ →→"}, true, function(_,_,s)
                        if s then
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                            end)
                        end
                    end)
                
                    
                    for i = 1,#pzCore.jobs["brasseur"].config.clothes do
                        RageUI.ButtonWithStyle(pzCore.jobs["brasseur"].config.clothes[i].label,nil, {RightLabel = "~b~Changer~s~ →→"}, true, function(_,_,s)
                            if s then
                                pzCore.jobs["unicorn"].setUniform(PlayerPedId(),i)
                            end
                        end)
                    end
                end, function()    
                end, 1)
                
                RageUI.IsVisible(RMenu:Get("brasseur_vehicle",'brasseur_vehicle_main'),true,true,true,function()
                    RageUI.ButtonWithStyle("Sortir un 4x4",nil, {RightBadge = RageUI.BadgeStyle.Car}, true, function(_,_,s)
                        if s then
                            RageUI.CloseAll()
                            pzCore.jobs["brasseur"].spawnCar("sandking2",PlayerPedId())
                        end
                    end)
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("bucheron_clothes",'bucheron_clothes_main'),true,true,true,function()

                    RageUI.ButtonWithStyle("Tenue de base",nil, {RightLabel = "~b~Changer~s~ →→"}, true, function(_,_,s)
                        if s then
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                            end)
                        end
                    end)
                
                    
                    for i = 1,#pzCore.jobs["bucheron"].config.clothes do
                        RageUI.ButtonWithStyle(pzCore.jobs["bucheron"].config.clothes[i].label,nil, {RightLabel = "~b~Changer~s~ →→"}, true, function(_,_,s)
                            if s then
                                pzCore.jobs["unicorn"].setUniform(PlayerPedId(),i)
                            end
                        end)
                    end
                end, function()    
                end, 1)
                
                RageUI.IsVisible(RMenu:Get("bucheron_vehicle",'bucheron_vehicle_main'),true,true,true,function()
                    RageUI.ButtonWithStyle("Sortir un 4x4",nil, {RightBadge = RageUI.BadgeStyle.Car}, true, function(_,_,s)
                        if s then
                            RageUI.CloseAll()
                            pzCore.jobs["bucheron"].spawnCar("sandking2",PlayerPedId())
                        end
                    end)
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("vigneron_clothes",'vigneron_clothes_main'),true,true,true,function()

                    RageUI.ButtonWithStyle("Tenue de base",nil, {RightLabel = "~b~Changer~s~ →→"}, true, function(_,_,s)
                        if s then
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                            end)
                        end
                    end)

                    
                    for i = 1,#pzCore.jobs["vigne"].config.clothes do
                        RageUI.ButtonWithStyle(pzCore.jobs["vigne"].config.clothes[i].label,nil, {RightLabel = "~b~Changer~s~ →→"}, true, function(_,_,s)
                            if s then
                                pzCore.jobs["unicorn"].setUniform(PlayerPedId(),i)
                            end
                        end)
                    end
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("police_clothes",'police_clothes_main'),true,true,true,function()

                    RageUI.Separator("↓ ~b~Tenues de civil~s~ ↓")


                    RageUI.ButtonWithStyle("Tenue de civil","Vous permets d'équiper la tenue de civil", {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(_,_,s)
                        if s then
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                            end)
                        end
                    end)
                   

                    RageUI.Separator("↓ ~o~Tenues de service~s~ ↓")

                    for i = 1,6 do
                        RageUI.ButtonWithStyle("Tenue de "..pzCore.jobs["police"].config[i].label,"Vous permets d'équiper la tenue de "..pzCore.jobs["police"].config[i].label, {RightBadge = RageUI.BadgeStyle.Clothes}, ESX.PlayerData.job.grade_name == pzCore.jobs["police"].config[i].grade, function(_,_,s)
                            if s then
                                pzCore.jobs["police"].setUniform(i,PlayerPedId())
                            end
                        end)
                    end
                    RageUI.Separator("↓ ~o~Autre~s~ ↓")
                    RageUI.ButtonWithStyle("Gilet par balle","Vous permets d'équiper un gillet par balle", {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(_,_,s)
                        if s then
                            TriggerServerEvent("pz_core:giveBullet", 'bulletproof')
                        end
                    end)
                    for i = 7,7 do
                        RageUI.ButtonWithStyle(pzCore.jobs["police"].config[i].label,"Vous permets d'équiper un "..pzCore.jobs["police"].config[i].label, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(_,_,s)
                            if s then
                                pzCore.jobs["police"].setUniform(i,PlayerPedId())
                            end
                        end)
                    end

                    
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("police_armory",'police_armory_main'),true,true,true,function()
                    RageUI.Separator("↓ ~r~Options~s~ ↓")
                    RageUI.ButtonWithStyle("Ranger toutes mes armes.", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            PlaySound(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0);
                            RemoveAllPedWeapons(GetPlayerPed(-1), true)
                            TriggerEvent("esx:showAdvancedNotification", '~g~LSPD', 'Armurerie', '~g~Vos armes ont été rangées.', 'CHAR_CALL911', 'spawn', 8)
                        end
                    end)
                    RageUI.Separator("↓ ~r~Armes disponibles~s~ ↓")
                    for i = 1,#pzCore.jobs["police"].config.weapons do
                        RageUI.ButtonWithStyle("Obtenir un "..pzCore.jobs["police"].config.weapons[i].label,"Vous permets d'équiper un "..pzCore.jobs["police"].config.weapons[i].label, {RightBadge = RageUI.BadgeStyle.Gun}, ESX.PlayerData.job.grade >= pzCore.jobs["police"].config.weapons[i].minGrade, function(_,_,s)
                            if s then
                                pzCore.jobs["police"].getWeapon(pzCore.jobs["police"].config.weapons[i].weapon,PlayerPedId())
                            end
                        end)
                    end
                end, function()    
                end, 1)


                RageUI.IsVisible(RMenu:Get("police_vehicle",'police_vehicle_main'),true,true,true,function()
                    for i = 1,#pzCore.jobs["police"].config.vehicles do
                        RageUI.Separator("↓ ~b~"..pzCore.jobs["police"].config.vehicles[i].label.."~s~ ↓")
                        for k,v in pairs(pzCore.jobs["police"].config.vehicles[i].list) do
                            RageUI.ButtonWithStyle(v.name,"Vous permets de sortir ce véhicule", {RightBadge = RageUI.BadgeStyle.Car}, ESX.PlayerData.job.grade >= v.minGrade, function(_,_,s)
                                if s then
                                    RageUI.CloseAll()
                                    pzCore.jobs["police"].spawnCar(v.model,PlayerPedId())
                                end
                            end)
                        end
                    end
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("police_boat",'police_boat_main'),true,true,true,function()
                    for i = 1,#pzCore.jobs["police"].config.boat do
                        RageUI.Separator("↓ ~b~"..pzCore.jobs["police"].config.boat[i].label.."~s~ ↓")
                        for k,v in pairs(pzCore.jobs["police"].config.boat[i].list) do
                            RageUI.ButtonWithStyle(v.name,"Vous permets de sortir ce bateau", {RightBadge = RageUI.BadgeStyle.Boat}, ESX.PlayerData.job.grade >= v.minGrade, function(_,_,s)
                                if s then
                                    RageUI.CloseAll()
                                    pzCore.jobs["police"].spawnBoat(v.model,PlayerPedId())
                                end
                            end)
                        end
                    end
                end, function()    
                end, 1)



                RageUI.IsVisible(RMenu:Get("vigneron_vehicle",'vigneron_vehicle_main'),true,true,true,function()
                    RageUI.ButtonWithStyle("Sortir un 4x4",nil, {RightBadge = RageUI.BadgeStyle.Car}, true, function(_,_,s)
                        if s then
                            RageUI.CloseAll()
                            pzCore.jobs["vigne"].spawnCar("sandking2",PlayerPedId())
                        end
                    end)
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("unicorn_vehicle",'unicorn_vehicle_main'),true,true,true,function()
                    RageUI.ButtonWithStyle("Sortir une voiture normale", nil, {RightBadge = RageUI.BadgeStyle.Car}, true, function(_,_,s)
                        if s then
                            RageUI.CloseAll()
                            pzCore.jobs["unicorn"].spawnCar("sultanrs",PlayerPedId())
                        end
                    end)
                    RageUI.ButtonWithStyle("Sortir un SUV",nil, {RightBadge = RageUI.BadgeStyle.Car}, true, function(_,_,s)
                        if s then
                            RageUI.CloseAll()
                            pzCore.jobs["unicorn"].spawnCar("granger",PlayerPedId())
                        end
                    end)
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("police_heli",'police_heli_main'),true,true,true,function()
                    for i = 1,#pzCore.jobs["police"].config.helicopters do
                        RageUI.ButtonWithStyle(pzCore.jobs["police"].config.helicopters[i].name,"Vous permets de sortir cet hélicoptère", {RightBadge = RageUI.BadgeStyle.Heli}, ESX.PlayerData.job.grade >= pzCore.jobs["police"].config.helicopters[i].minGrade, function(_,_,s)
                            if s then
                                RageUI.CloseAll()
                                pzCore.jobs["police"].spawnHeli(pzCore.jobs["police"].config.helicopters[i].model,PlayerPedId())
                            end
                        end)
                    end
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("police_jail",'police_jail_main'),true,true,true,function()
                    RageUI.Separator("↓ ~b~Tenues de civil~s~ ↓")
                    RageUI.ButtonWithStyle("Tenue de civil","Vous permets d'équiper la tenue de civil", {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(_,_,s)
                        if s then
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                            end)
                        end
                    end)
                    RageUI.Separator("↓ ~o~Tenues de prisonnier~s~ ↓")
                    RageUI.ButtonWithStyle("Tenue de prisonnier","Vous permets d'équiper la tenue de prisonnier", {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(_,_,s)
                        if s then
                            pzCore.jobs["police"].setUniformJail(PlayerPedId())
                        end
                    end)
                    
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("police_dynamicmenu",'police_dynamicmenu_main'),true,true,true,function()
                    menu = true

                    RageUI.Separator("↓ ~b~Statut de service ~s~↓")
                    RageUI.Checkbox("Statut de service", nil, inServicePolice, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                        inServicePolice = Checked;
                    end, function()
                        inServicePolice = true
                        local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
                        TriggerServerEvent("pz_core:police:code", 4, 1,mugshot, mugshotStr, GetEntityCoords(PlayerPedId()), PlayerId())
                        pzCore.mug("Statut de service","~b~Dept. de la justice","Statut: ~g~en service~s~.")
                    end, function()
                        local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
                        TriggerServerEvent("pz_core:police:code", 5, 1,mugshot, mugshotStr, GetEntityCoords(PlayerPedId()), PlayerId())
                        pzCore.mug("Statut de service","~b~Dept. de la justice","Statut: ~r~hors service~s~.")
                        Citizen.SetTimeout(580, function()
                            inServicePolice = false
                        end)
                    end)

                    if inServicePolice then

                    RageUI.Separator("↓ ~o~Interactions ~s~↓")

                        RageUI.ButtonWithStyle("Interactions citoyens", "Vous permets d'accéder aux interactions citoyens", { RightLabel = "→→" }, true, function()
                        end, RMenu:Get('police_dynamicmenu', 'police_dynamicmenu_citizen'))
                        RageUI.ButtonWithStyle("Interactions véhicules", "Vous permets d'accéder aux interactions véhicules", { RightLabel = "→→" }, true, function()
                        end, RMenu:Get('police_dynamicmenu', 'police_dynamicmenu_veh'))
                        
                        RageUI.Separator("↓ ~g~Communication ~s~↓")

                        RageUI.ButtonWithStyle("Effectuer un code radio", "Vous permets d'effectuer un code radio", { RightLabel = "→→" }, true, function()
                        end, RMenu:Get('police_dynamicmenu', 'police_dynamicmenu_codes'))

                        if ESX.PlayerData.job.name == "fbi" then
                            RageUI.ButtonWithStyle("Consulter les avis de recherche", "Vous permets de consulter les avis de recherche", { RightLabel = "→→" }, true, function(_,_,s)
                                if s then
                                    fbiADRData = nil
                                    TriggerServerEvent("pz_core:adrGet")
                                end
                            end, RMenu:Get('police_dynamicmenu', 'police_dynamicmenu_adr'))

                            RageUI.ButtonWithStyle("Lancer un avis de recherche", "Vous permets de lancer un avis de recherche", { RightLabel = "→→" }, true, function()
                            end, RMenu:Get('police_dynamicmenu', 'police_dynamicmenu_adrlaunch'))
                        end
                    end

                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("police_dynamicmenu",'police_dynamicmenu_adr'),true,true,true,function()
                    menu = true
                    if fbiADRData == nil then
                        RageUI.Separator("")
                        RageUI.Separator("~c~Il n'y a aucun avis de recherche actif")
                        RageUI.Separator("")
                    else
                        RageUI.Separator("↓ ~r~Avis de recherche ~s~↓")

                        for index,adr in pairs(fbiADRData) do
                            RageUI.ButtonWithStyle(colorVar.."[NV."..adr.dangerosity.."] ~s~"..adr.firstname.." "..adr.lastname.." • "..adr.date, "~o~Motif~s~: "..adr.reason, { RightLabel = "~b~Consulter ~s~→→" }, true, function(_,_,s)
                                if s then
                                    fbiADRindex = index
                                end
                            end, RMenu:Get('police_dynamicmenu', 'police_dynamicmenu_adrcheck'))
                        end
                        
                    end
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("police_dynamicmenu",'police_dynamicmenu_adrlaunch'),true,true,true,function()
                    menu = true
                    RageUI.Separator("↓ ~b~Informations personnelles ~s~↓")

                    RageUI.ButtonWithStyle("Prénom: ~s~"..pzCore.notNil(fbiADRBuilder.firstname), "~r~Motif: ~s~"..pzCore.notNil(fbiADRBuilder.reason), { RightLabel = "~g~Définir ~s~→→" }, true, function(_,_,s)
                        if s then
                            fbiADRBuilder.firstname = pzCore.keyboard("Prénom","Prénom de l'individu:")
                        end
                    end)
                    RageUI.ButtonWithStyle("Nom: ~s~"..pzCore.notNil(fbiADRBuilder.lastname), "~r~Motif: ~s~"..pzCore.notNil(fbiADRBuilder.reason), { RightLabel = "~g~Définir ~s~→→" }, true, function(_,_,s)
                        if s then
                            fbiADRBuilder.lastname = pzCore.keyboard("Nom","Nom de l'individu:")
                        end
                    end)

                    RageUI.Separator("↓ ~b~Informations de l'avis ~s~↓")

                    --RageUI.ButtonWithStyle("~o~Date: ~s~"..os.date("*t", 906000490).day.."/"..os.date("*t", 906000490).month.."/"..os.date("*t", 906000490).year.." à "..os.date("*t", 906000490).hour.."h"..os.date("*t", 906000490).min, "~r~Motif: ~s~"..pzCore.notNil(fbiADRBuilder.reason), {}, true, function() end)

                    

                    RageUI.ButtonWithStyle("Définir le motif", "~r~Motif: ~s~"..pzCore.notNil(fbiADRBuilder.reason), { RightLabel = "~g~Définir ~s~→→" }, true, function(_,_,s)
                        if s then
                            fbiADRBuilder.reason = pzCore.bigKeyboard("Raison","Motif de l'avis de recherche:")
                        end
                    end)

                    RageUI.List("Dangerosité: ~s~", fbiADRDangerosities, fbiADRBuilder.dangerosity, "~r~Motif: ~s~"..pzCore.notNil(fbiADRBuilder.reason), {}, true, function(Hovered, Active, Selected, Index)
        
                        fbiADRBuilder.dangerosity = Index
                        
                    end)

                    RageUI.Separator("↓ ~b~Interactions ~s~↓")

                    RageUI.ButtonWithStyle("~g~Sauvegarder et envoyer", "~r~Motif: ~s~"..pzCore.notNil(fbiADRBuilder.reason), { RightLabel = "~g~Envoyer ~s~→→" }, fbiADRBuilder.firstname ~= nil and fbiADRBuilder.lastname ~= nil and fbiADRBuilder.reason ~= nil, function(_,_,s)
                        if s then
                            RageUI.CloseAll()
                            TriggerServerEvent("pz_core:adrAdd", fbiADRBuilder)
                            fbiADRBuilder = {dangerosity = 1}
                        end
                    end)

                    


                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("police_dynamicmenu",'police_dynamicmenu_adrcheck'),true,true,true,function()
                    menu = true

                    RageUI.Separator("↓ ~b~Informations ~s~↓")
                    RageUI.ButtonWithStyle("~g~Auteur: ~s~"..fbiADRData[fbiADRindex].author, "~r~Motif: ~s~"..fbiADRData[fbiADRindex].reason, {}, true, function()end)
                    RageUI.ButtonWithStyle("~g~Date: ~s~"..fbiADRData[fbiADRindex].date, "~r~Motif: ~s~"..fbiADRData[fbiADRindex].reason, {}, true, function()end)
                    RageUI.ButtonWithStyle("~o~Prénom: ~s~"..fbiADRData[fbiADRindex].firstname, "~r~Motif: ~s~"..fbiADRData[fbiADRindex].reason, {}, true, function()end)
                    RageUI.ButtonWithStyle("~o~Nom: ~s~"..fbiADRData[fbiADRindex].lastname, "~r~Motif: ~s~"..fbiADRData[fbiADRindex].reason, {}, true, function()end)
                    RageUI.ButtonWithStyle("~r~Dangerosité: ~s~"..pzCore.jobs["fbi"].getDangerosity(fbiADRData[fbiADRindex].dangerosity), "~r~Motif: ~s~"..fbiADRData[fbiADRindex].reason, {}, true, function()end)

                    if ESX.PlayerData.job.grade >= 1 then
                        RageUI.Separator("↓ ~o~Opérations ~s~↓")
                        RageUI.ButtonWithStyle("~r~Retirer cet avis de recherche", nil, {RightLabel = "~r~Supprimer ~s~→→"}, true, function(_,_,s)
                            if s then
                                RageUI.CloseAll()
                                TriggerServerEvent("pz_core:adrDel", fbiADRindex)
                            end
                        end)
                    end

                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("police_dynamicmenu",'police_dynamicmenu_carinfos'),true,true,true,function()
                    menu = true
                    if vehicleStats == nil then
                        RageUI.Separator("")
                        RageUI.Separator("~o~En attente des données...")
                        RageUI.Separator("")
                    else
                        local owner = ""
                        if not vehicleStats.owner then owner = "Jean Moldu" else owner = vehicleStats.owner end
                        RageUI.Separator("~o~Plaque: ~s~"..vehicleStats.plate)
                        RageUI.Separator("~o~Propriétaire: ~s~"..owner)
                    end
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("police_dynamicmenu",'police_dynamicmenu_identity'),true,true,true,function()
                    menu = true
                    if identityStats == nil then
                        RageUI.Separator("")
                        RageUI.Separator("~o~En attente des données...")
                        RageUI.Separator("")
                    else
                        --RageUI.Separator("~o~Nom: ~s~"..identityStats.firstname.." "..identityStats.lastname)
                        RageUI.Separator("~o~Nom: ~s~"..identityStats.firstname.." "..identityStats.lastname)
                        RageUI.Separator("~o~Sexe: ~s~"..identityStats.sex)
                        RageUI.Separator("")
                        RageUI.Separator("~g~Liquide: ~s~"..identityStats.m.."$")
                        RageUI.Separator("")
                        RageUI.Separator("~b~Emploi: ~s~"..identityStats.job.." - "..identityStats.grade)
                    end
                end, function()    
                end, 1)

                

                RageUI.IsVisible(RMenu:Get("police_dynamicmenu",'police_dynamicmenu_citizen'),true,true,true,function()
                    menu = true
                    closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                    RageUI.ButtonWithStyle("Fouiller l'individu", nil, { RightLabel = "→→" }, closestPlayer ~= -1 and closestDistance <= 3.0, function(_,_,s)
                        if s then
                            identityStats = nil
                            pzCore.jobs["police"].getIdentity(closestPlayer)
                        end
                    end, RMenu:Get('police_dynamicMenu', 'police_dynamicMenu_fouille'))
                    RageUI.ButtonWithStyle("Menotter/Démenotter", nil, { RightLabel = "→→" }, closestPlayer ~= -1 and closestDistance <= 3.0, function(_,_,s)
                        if s then
                            TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
                        end
                    end)
                    RageUI.ButtonWithStyle("Escoter/Arrêter l'escorte", nil, { RightLabel = "→→" }, closestPlayer ~= -1 and closestDistance <= 3.0, function(_,_,s)
                        if s then
                            TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
                        end
                    end)
                    RageUI.ButtonWithStyle("Mettre dans le véhicule", nil, { RightLabel = "→→" }, closestPlayer ~= -1 and closestDistance <= 3.0, function(_,_,s)
                        if s then
                            TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
                        end
                    end)
                    RageUI.ButtonWithStyle("Mettre hors du véhicule", nil, { RightLabel = "→→" }, closestPlayer ~= -1 and closestDistance <= 3.0, function(_,_,s)
                        if s then
                            TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
                        end
                    end)
                    RageUI.ButtonWithStyle("Amendes", nil, { RightLabel = "→→" }, closestPlayer ~= -1 and closestDistance <= 3.0, function(_,_,s)
                        if s then
                            local raison = ""
                            local montant = 0



                            AddTextEntry("FMMC_MPM_NA", "Raison de l'amende")
                            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez une raison de l'amende:", "", "", "", "", 30)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0)
                                Wait(0)
                            end
                            if (GetOnscreenKeyboardResult()) then
                                local result = GetOnscreenKeyboardResult()
                                if result then
                                    raison = result
                                    result = nil
                                    AddTextEntry("FMMC_MPM_NA", "Montant de l'amende")
                                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le montant de l'amende:", "", "", "", "", 30)
                                    while (UpdateOnscreenKeyboard() == 0) do
                                        DisableAllControlActions(0)
                                        Wait(0)
                                    end
                                    if (GetOnscreenKeyboardResult()) then
                                        result = GetOnscreenKeyboardResult()
                                        if result then
                                            montant = result
                                            result = nil
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', raison, tonumber(montant))
                                            pzCore.mug("~r~Tablette de police", "Amende envoyée","Vous avez envoyé une amende à cette personne: ~b~\""..raison.."\"~s~: ~r~"..montant.."$")
                                        end
                                    end
                                    
                                end
                            end
                        end
                        
                    end)
                    RageUI.ButtonWithStyle("Attribuer le PPA", nil, { RightLabel = "→→" }, closestPlayer ~= -1 and closestDistance <= 3.0, function(_,_,s)
                        if s then
                            TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(closestPlayer), 'weapon')
                        end
                    end)
                    RageUI.ButtonWithStyle("Enlever le permis", nil, { RightLabel = "→→" }, closestPlayer ~= -1 and closestDistance <= 3.0, function(_,_,s)
                        if s then
                            TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(closestPlayer), 'drive')
                        end
                    end)
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("police_dynamicMenu",'police_dynamicMenu_fouille'), true, true, true, function()
                    menu = true
                    RageUI.Separator("~b~Argents :")
                    for k,v in pairs(playerBlackMoney) do
                        RageUI.ButtonWithStyle("Argent sale :", nil, {RightLabel = "~r~"..v.label.."$"}, true, function(Hovered, Active, Selected)
                            if Active then 
                                if closestPlayer ~= -1 and closestDistance <= 2.0 then
                                    playerMarker(closestPlayer)
                                end
                            end
                            if Selected then 
                                local combien = KeyboardInput("Combien voulez vous prendre ?", '', '', 8)
                                if tonumber(combien) > v.amount then
                                    ESX.ShowNotification("~r~Quantité invalide")
                                else
                                    TriggerServerEvent('sIllegal:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                                end
                                RageUI.GoBack()
                            end
                        end)
                    end
                    RageUI.Separator("~b~Objet :")
                    for k,v in pairs(playerItem) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "~r~x"..v.right}, true, function(Hovered, Active, Selected)
                            if Active then 
                                if closestPlayer ~= -1 and closestDistance <= 2.0 then
                                    playerMarker(closestPlayer)
                                end
                            end
                            if Selected then 
                                local combien = KeyboardInput("Combien voulez vous prendre ?", '', '', 8)
                                if tonumber(combien) > v.amount then
                                    ESX.ShowNotification("~r~Quantité invalide")
                                else
                                    TriggerServerEvent('sIllegal:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                                end
                                RageUI.GoBack()
                            end
                        end)
                    end
                    RageUI.Separator("~b~Armes :")
                    for k,v in pairs(playerWeapon) do
                        RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "Avec ~r~"..v.right.."~s~ balle(s)"}, true, function(Hovered, Active, Selected)
                            if Active then 
                                if closestPlayer ~= -1 and closestDistance <= 2.0 then
                                    playerMarker(closestPlayer)
                                end
                            end
                            if Selected then 
                                TriggerServerEvent('sIllegal:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, v.amount)
                                RageUI.GoBack()
                            end
                        end)
                    end
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("police_dynamicmenu",'police_dynamicmenu_veh'),true,true,true,function()
                    menu = true
                    local coords  = GetEntityCoords(PlayerPedId())
                    local vehicle = ESX.Game.GetVehicleInDirection()
                    RageUI.ButtonWithStyle("Informations du véhicule", nil, { RightLabel = "→→" }, DoesEntityExist(vehicle), function(_,_,s)
                        if s then
                            vehicleStats = nil
                            local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
                            pzCore.jobs["police"].getVehicleInfos(vehicleData)
                        end
                    end,RMenu:Get('police_dynamicmenu', 'police_dynamicmenu_carinfos'))

                    RageUI.ButtonWithStyle("Crocheter le véhicule", nil, { RightLabel = "→→" }, DoesEntityExist(vehicle), function(_,_,s)
                        if s then
                            if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
                                TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_WELDING', 0, true)
                                Citizen.Wait(20000)
                                ClearPedTasksImmediately(PlayerPedId())
    
                                SetVehicleDoorsLocked(vehicle, 1)
                                SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                                ESX.ShowNotification("~o~Véhicule dévérouillé!")
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle("Mettre en fourrière", nil, { RightLabel = "→→" }, DoesEntityExist(vehicle), function(_,_,s)
                        if s then
                            if currentTask.busy then
                                return
                            end

                            TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
    
                            currentTask.busy = true
                            currentTask.task = ESX.SetTimeout(10000, function()
                                ClearPedTasks(playerPed)
                                ESX.Game.DeleteVehicle(vehicle)
                                ESX.ShowNotification("~o~Mise en fourrière effectuée")
                                currentTask.busy = false
                                Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
                            end)
    
                            -- keep track of that vehicle!
                            Citizen.CreateThread(function()
                                while currentTask.busy do
                                    Citizen.Wait(1000)
    
                                    vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
                                    if not DoesEntityExist(vehicle) and currentTask.busy then
                                        ESX.ShowNotification("~r~Le véhicule a bougé!")
                                        ESX.ClearTimeout(currentTask.task)
                                        ClearPedTasks(playerPed)
                                        currentTask.busy = false
                                        break
                                    end
                                end
                            end)
                        end
                    end)
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("police_dynamicmenu",'police_dynamicmenu_codes'),true,true,true,function()
                    menu = true
                    
                    RageUI.Separator("↓ ~r~Demandes de renfort ~s~↓")

                    RageUI.ButtonWithStyle("~g~Urgence légère", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                        if s then
                            
                            local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
                            TriggerServerEvent("pz_core:police:code", 11, 3,mugshot, mugshotStr, GetEntityCoords(PlayerPedId()), PlayerId())
                            codesCooldown = true
                            Citizen.SetTimeout(1500, function()
                                codesCooldown = false
                            end)
                        end
                    end)
                    RageUI.ButtonWithStyle("~o~Urgence moyenne", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                        if s then
                            local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
                            TriggerServerEvent("pz_core:police:code", 12, 3,mugshot, mugshotStr, GetEntityCoords(PlayerPedId()), PlayerId())
                            codesCooldown = true
                            Citizen.SetTimeout(1500, function()
                                codesCooldown = false
                            end)
                        end
                    end)
                    RageUI.ButtonWithStyle("~r~Urgence maximale", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                        if s then
                            local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
                            TriggerServerEvent("pz_core:police:code", 13, 3,mugshot, mugshotStr, GetEntityCoords(PlayerPedId()), PlayerId())
                            codesCooldown = true
                            Citizen.SetTimeout(1500, function()
                                codesCooldown = false
                            end)
                        end
                    end)

        
            
                    RageUI.Separator("↓ ~o~Codes d'interventions  ~s~↓")

                    RageUI.ButtonWithStyle("~r~10-13~s~: Officier blessé", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                        if s then
                            local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
                            TriggerServerEvent("pz_core:police:code", 7, 2,mugshot, mugshotStr, GetEntityCoords(PlayerPedId()), PlayerId())
                            codesCooldown = true
                            Citizen.SetTimeout(1500, function()
                                codesCooldown = false
                            end)
                        end
                    end)
                    RageUI.ButtonWithStyle("~r~10-14~s~: Prise d'otage", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                        if s then
                            local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
                            TriggerServerEvent("pz_core:police:code", 8, 2,mugshot, mugshotStr, GetEntityCoords(PlayerPedId()), PlayerId())
                            codesCooldown = true
                            Citizen.SetTimeout(1500, function()
                                codesCooldown = false
                            end)
                        end
                    end)
                    RageUI.ButtonWithStyle("~r~10-31~s~: Course poursuite", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                        if s then
                            local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
                            TriggerServerEvent("pz_core:police:code", 9, 2,mugshot, mugshotStr, GetEntityCoords(PlayerPedId()), PlayerId())
                            codesCooldown = true
                            Citizen.SetTimeout(1500, function()
                                codesCooldown = false
                            end)
                        end
                    end)
                    RageUI.ButtonWithStyle("~r~10-32~s~: Individu armé", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                        if s then
                            local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
                            TriggerServerEvent("pz_core:police:code", 10, 2,mugshot, mugshotStr, GetEntityCoords(PlayerPedId()), PlayerId())
                            codesCooldown = true
                            Citizen.SetTimeout(1500, function()
                                codesCooldown = false
                            end)
                        end
                    end)

                    RageUI.Separator("↓ ~g~Codes informatifs ~s~↓")

                    RageUI.ButtonWithStyle("~r~10-4~s~: Affirmatif/Reçu", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                        if s then
                            local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
                            TriggerServerEvent("pz_core:police:code", 1, 1,mugshot, mugshotStr, GetEntityCoords(PlayerPedId()), PlayerId())
                            codesCooldown = true
                            Citizen.SetTimeout(1500, function()
                                codesCooldown = false
                            end)
                        end
                    end)
                    RageUI.ButtonWithStyle("~r~10-5~s~: Négatif", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                        if s then
                            local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
                            TriggerServerEvent("pz_core:police:code", 2, 1,mugshot, mugshotStr, GetEntityCoords(PlayerPedId()), PlayerId())
                            codesCooldown = true
                            Citizen.SetTimeout(1500, function()
                                codesCooldown = false
                            end)
                        end
                    end)
                    RageUI.ButtonWithStyle("~r~10-6~s~: Pause de service", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                        if s then
                            local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
                            TriggerServerEvent("pz_core:police:code", 3, 1,mugshot, mugshotStr, GetEntityCoords(PlayerPedId()), PlayerId())
                            codesCooldown = true
                            Citizen.SetTimeout(1500, function()
                                codesCooldown = false
                            end)
                        end
                    end)
                    RageUI.ButtonWithStyle("~r~10-8~s~: Prise de service", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                        if s then
                            local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
                            TriggerServerEvent("pz_core:police:code", 4, 1,mugshot, mugshotStr, GetEntityCoords(PlayerPedId()), PlayerId())
                            codesCooldown = true
                            Citizen.SetTimeout(1500, function()
                                codesCooldown = false
                            end)
                        end
                    end)
                    RageUI.ButtonWithStyle("~r~10-10~s~: Fin de service", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                        if s then
                            local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
                            TriggerServerEvent("pz_core:police:code", 5, 1,mugshot, mugshotStr, GetEntityCoords(PlayerPedId()), PlayerId())
                            codesCooldown = true
                            Citizen.SetTimeout(1500, function()
                                codesCooldown = false
                            end)
                        end
                    end)
                    RageUI.ButtonWithStyle("~r~10-19~s~: Retour au poste", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                        if s then
                            local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
                            TriggerServerEvent("pz_core:police:code", 6, 1,mugshot, mugshotStr, GetEntityCoords(PlayerPedId()), PlayerId())
                            codesCooldown = true
                            Citizen.SetTimeout(1500, function()
                                codesCooldown = false
                            end)
                        end
                    end)
  
                end, function()    
                end, 1)

                -- Concess 

                RageUI.IsVisible(RMenu:Get("concess_actions",'concess_actions_main'),true,true,true,function()

                    RageUI.Checkbox("Prendre son service", nil, inServiceConcess, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                        inServiceConcess = Checked;
                    end, function()
                        inServiceConcess = true
                        pzCore.mug("Statut de service","Vous êtes désormais ~g~en service~s~.")
                    end, function()
                        pzCore.mug("Statut de service","Vous êtes désormais ~r~hors service~s~.")
                        Citizen.SetTimeout(580, function()
                            inServiceConcess = false
                        end)
                    end)

                    RageUI.Separator("~b~Actions véhicules")
                    RageUI.ButtonWithStyle("Acheter un véhicule", nil, { RightLabel = "→→" }, inServiceConcess, function(_,_,s)
                    end,RMenu:Get('concess_categories', 'concess_categories_main'))
                    RageUI.ButtonWithStyle("Véhicule acheté", nil, { RightLabel = "→→" }, inServiceConcess, function(_,_,s)
                        if s then 
                            loadVehConcess()
                        end
                    end, RMenu:Get('veh_concess', 'veh_concess_main'))
                    RageUI.Separator("~b~Actions divers")
                    RageUI.ButtonWithStyle("Annonce concessionnaire ouvert", nil, { RightLabel = "~g~Publier~s~ →→" }, inServiceConcess and not codesCooldown, function(_,_,s)
                        if s then 
                            codesCooldown = true
                            TriggerServerEvent("pz_core:concess_state", true)
                            Citizen.SetTimeout(5000, function() codesCooldown = false end)
                        end
                    end)
                    RageUI.ButtonWithStyle("Annonce concessionnaire fermer", nil, { RightLabel = "~g~Publier~s~ →→" }, inServiceConcess and not codesCooldown, function(_,_,s)
                        if s then 
                            codesCooldown = true
                            TriggerServerEvent("pz_core:concess_state", false)
                            Citizen.SetTimeout(5000, function() codesCooldown = false end)
                        end
                    end)
                    RageUI.ButtonWithStyle("Annonce personnalisé", nil, { RightLabel = "~g~Publier~s~ →→" }, inServiceConcess and not codesCooldown, function(_,_,s)
                        if s then 
                            codesCooldown = true
                            local text = KeyboardInput("Annonce", '', '', 100)
                            TriggerServerEvent("pz_core:concess_stateperso", text)
                            Citizen.SetTimeout(5000, function() codesCooldown = false end)
                        end
                    end)
                    RageUI.ButtonWithStyle("Donner une facture",nil, {RightLabel = "~r~Factuer~s~ →→"},  inServiceConcess, function(h,a,s)
                        if a then 
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer ~= -1 and closestDistance <= 2.0 then
                                playerMarker(closestPlayer)
                            end
                        end
                        if s then
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            local raison = ""
                            local montant = 0

                            AddTextEntry("FMMC_MPM_NA", "Nom de vehicule vendu")
                            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Nom de vehicule vendu", "", "", "", "", 30)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0)
                                Wait(0)
                            end
                            if (GetOnscreenKeyboardResult()) then
                                local result = GetOnscreenKeyboardResult()
                                if result then
                                    raison = result
                                    result = nil
                                    AddTextEntry("FMMC_MPM_NA", "Donnez le montant de vente du vehicule")
                                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le montant de vente du vehicule", "", "", "", "", 30)
                                    while (UpdateOnscreenKeyboard() == 0) do
                                        DisableAllControlActions(0)
                                        Wait(0)
                                    end
                                    if (GetOnscreenKeyboardResult()) then
                                        result = GetOnscreenKeyboardResult()
                                        if result then
                                            montant = result
                                            result = nil
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_concess', raison, tonumber(montant))
                                            pzCore.mug("~r~Véhicule Vendu", "Facture envoyée","Véhicule vendu ~b~"..raison.."~s~ pour ~r~"..montant.."$~s~.")
                                        end
                                    end
                                    
                                end
                            end
                        end
                    end)

                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("veh_concess",'veh_concess_main'),true,true,true,function()

                    for k,v in pairs(vehDansLeConcess) do
                        RageUI.ButtonWithStyle("[~b~"..v.plate.."~s~] - "..v.model, nil, {RightLabel = "~r~"..v.price.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Selected then 
                                vehDuConessChoisis = v
                            end
                        end, RMenu:Get('action_vehConcess', "action_vehConcess_main"))
                    end

                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("action_vehConcess",'action_vehConcess_main'),true,true,true,function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    local prixRevente = vehDuConessChoisis.price * 2
                    RageUI.Separator("~y~Information :")
                    RageUI.ButtonWithStyle("Véhicule :", nil, {RightLabel = "~b~"..vehDuConessChoisis.model}, true, function(Hovered, Active, Selected)end)
                    RageUI.ButtonWithStyle("Plaque :", nil, {RightLabel = "~b~"..vehDuConessChoisis.plate}, true, function(Hovered, Active, Selected)end)
                    RageUI.ButtonWithStyle("Prix d'usine :", nil, {RightLabel = "~b~"..vehDuConessChoisis.price.."$"}, true, function(Hovered, Active, Selected)end)
                    RageUI.ButtonWithStyle("Prix de revente :", nil, {RightLabel = "~b~"..prixRevente.."$"}, true, function(Hovered, Active, Selected)end)
                    RageUI.Separator("~y~Actions :")
                    RageUI.ButtonWithStyle("Faire apparaître le véhicule", nil, {RightLabel = "~r~Sortir~s~ →→"}, sortieOuPas, function(h,a,s)
                        if s then
                            ESX.Game.SpawnVehicle(vehDuConessChoisis.model, vector3(-45.13, -1098.05, 25.81), 250.94, function(vehicle)
                                currentDisplayVehicle = vehicle
                                SetVehicleNumberPlateText(currentDisplayVehicle, vehDuConessChoisis.plate)
                            end)
                            sortieOuPas = false
                        end
                    end)
                    RageUI.ButtonWithStyle("Supprimer le véhicule", nil, {RightLabel = "~r~Supprimer~s~ →→"}, not sortieOuPas, function(h,a,s)
                        if s then
                            DeleteEntity(currentDisplayVehicle)
                            currentDisplayVehicle = nil
                            vehDuConessChoisis = 0
                            sortieOuPas = true
                            RageUI.GoBack()
                        end
                    end)
                
                    RageUI.ButtonWithStyle("Attribuer le véhicule", "~r~Le véhicule doit être sortis", {RightLabel = "~r~Attribuer~s~ →→"}, currentDisplayVehicle, function(h,a,s)
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if a then 
                            if closestPlayer ~= -1 and closestDistance <= 2.0 then
                                playerMarker(closestPlayer)
                            end
                        end
                        if s then
				            if closestPlayer ~= -1 and closestDistance < 2.0 then
				            	local vehicleProps = ESX.Game.GetVehicleProperties(currentDisplayVehicle)
                                TriggerServerEvent('esx_vehicleshop:setVehicleOwnedPlayerId', GetPlayerServerId(closestPlayer), vehDuConessChoisis.plate, vehicleProps)
                                TriggerServerEvent("esx_vehicleshop:suppVeh", vehDuConessChoisis.plate)
                                currentDisplayVehicle = nil
                                vehDuConessChoisis = 0
                                sortieOuPas = true
                                RageUI.GoBack()
				            else
				            	ESX.ShowNotification("Pas de joueurs a distance")
				            end
                        end
                    end)
                    RageUI.ButtonWithStyle("Rendre le véhicule", nil, {RightLabel = "~r~Rendre~s~ →→"}, true, function(h,a,s)
                        if s then
                            TriggerServerEvent("esx_vehicleshop:suppVeh", vehDuConessChoisis.plate)
                            TriggerServerEvent('esx_vehicleshop:rendreVehicule', vehDuConessChoisis.price)
                            ESX.ShowNotification("Véhicule avec la plaque ~b~"..vehDuConessChoisis.plate.."~s~ ~r~rendu~s~ pour ~g~"..vehDuConessChoisis.price.."$~s~.")
                            currentDisplayVehicle = nil
                            vehDuConessChoisis = 0
                            sortieOuPas = true
                            RageUI.GoBack()
                        end
                    end)

                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess_categories",'concess_categories_main'),true,true,true,function()

                    RageUI.ButtonWithStyle("Compacts", nil, { RightLabel = "→→" }, true, function(_,_,s)   
                    end,RMenu:Get('concess_compact', 'concess_compact_main'))

                    RageUI.ButtonWithStyle("Coupes", nil, { RightLabel = "→→" }, true, function(_,_,s)
                    end,RMenu:Get('concess_coupes', 'concess_coupes_main'))

                    RageUI.ButtonWithStyle("Muscle", nil, { RightLabel = "→→" }, true, function(_,_,s)
                    end,RMenu:Get('concess_muscle', 'concess_muscle_main'))

                    RageUI.ButtonWithStyle("Off-Road", nil, { RightLabel = "→→" }, true, function(_,_,s)
                    end,RMenu:Get('concess_offroad', 'concess_offroad_main'))

                    RageUI.ButtonWithStyle("SUVs", nil, { RightLabel = "→→" }, true, function(_,_,s)
                    end,RMenu:Get('concess_suv', 'concess_suv_main'))

                    RageUI.ButtonWithStyle("Sedans", nil, { RightLabel = "→→" }, true, function(_,_,s)
                    end,RMenu:Get('concess_sedans', 'concess_sedans_main'))

                    RageUI.ButtonWithStyle("Sport", nil, { RightLabel = "→→" }, true, function(_,_,s)                       
                    end,RMenu:Get('concess_sport', 'concess_sport_main'))

                    RageUI.ButtonWithStyle("Sport Classique", nil, { RightLabel = "→→" }, true, function(_,_,s)                       
                    end,RMenu:Get('concess_sportclass', 'concess_sportclass_main'))

                    RageUI.ButtonWithStyle("Super", nil, { RightLabel = "→→" }, true, function(_,_,s)                       
                    end,RMenu:Get('concess_super', 'concess_super_main'))

                    RageUI.ButtonWithStyle("Vans", nil, { RightLabel = "→→" }, true, function(_,_,s)                       
                    end,RMenu:Get('concess_van', 'concess_van_main'))

                    RageUI.ButtonWithStyle("Moto", nil, { RightLabel = "→→" }, true, function(_,_,s)                       
                    end,RMenu:Get('concess_moto', 'concess_moto_main'))

                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess_compact",'concess_compact_main'),true,true,true,function()
                    for k,v in pairs(vehicleConcess[1]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                        local price = math.floor(v.prix / 100 * 60)
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..price.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                            
                            if Selected then
                                vehChoisis = v
                            end
                        end, RMenu:Get('yesorno', "yesorno_main"))
                    end

                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess_coupes",'concess_coupes_main'),true,true,true,function()
                    for k,v in pairs(vehicleConcess[2]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                        local price = math.floor(v.prix / 100 * 60)
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..price.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                            
                            if Selected then
                                vehChoisis = v
                            end
                        end, RMenu:Get('yesorno', "yesorno_main"))
                    end

                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess_muscle",'concess_muscle_main'),true,true,true,function()
                    for k,v in pairs(vehicleConcess[3]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                        local price = math.floor(v.prix / 100 * 60)
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..price.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                            
                            if Selected then
                                vehChoisis = v
                            end
                        end, RMenu:Get('yesorno', "yesorno_main"))
                    end

                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess_offroad",'concess_offroad_main'),true,true,true,function()
                    for k,v in pairs(vehicleConcess[4]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                        local price = math.floor(v.prix / 100 * 60)
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..price.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                            
                            if Selected then
                                vehChoisis = v
                            end
                        end, RMenu:Get('yesorno', "yesorno_main"))
                    end

                end, function()
                end, 1)
                
                RageUI.IsVisible(RMenu:Get("concess_suv",'concess_suv_main'),true,true,true,function()
                    for k,v in pairs(vehicleConcess[5]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                        local price = math.floor(v.prix / 100 * 60)
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..price.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                            
                            if Selected then
                                vehChoisis = v
                            end
                        end, RMenu:Get('yesorno', "yesorno_main"))
                    end

                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess_sedans",'concess_sedans_main'),true,true,true,function()
                    for k,v in pairs(vehicleConcess[6]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                        local price = math.floor(v.prix / 100 * 60)
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..price.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                            
                            if Selected then
                                vehChoisis = v
                            end
                        end, RMenu:Get('yesorno', "yesorno_main"))
                    end

                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess_sport",'concess_sport_main'),true,true,true,function()
                    for k,v in pairs(vehicleConcess[7]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                        local price = math.floor(v.prix / 100 * 60)
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..price.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                            
                            if Selected then
                                vehChoisis = v
                            end
                        end, RMenu:Get('yesorno', "yesorno_main"))
                    end

                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess_sportclass",'concess_sportclass_main'),true,true,true,function()
                    for k,v in pairs(vehicleConcess[8]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                        local price = math.floor(v.prix / 100 * 60)
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..price.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                            
                            if Selected then
                                vehChoisis = v
                            end
                        end, RMenu:Get('yesorno', "yesorno_main"))
                    end

                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess_super",'concess_super_main'),true,true,true,function()
                    for k,v in pairs(vehicleConcess[9]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                        local price = math.floor(v.prix / 100 * 60)
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..price.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                            
                            if Selected then
                                vehChoisis = v
                            end
                        end, RMenu:Get('yesorno', "yesorno_main"))
                    end

                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess_van",'concess_van_main'),true,true,true,function()
                    for k,v in ipairs(vehicleConcess[10]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                        local price = math.floor(v.prix / 100 * 60)
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..price.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                            
                            if Selected then
                                vehChoisis = v
                            end
                        end, RMenu:Get('yesorno', "yesorno_main"))
                    end

                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess_moto",'concess_moto_main'),true,true,true,function()
                    for k,v in ipairs(vehicleConcess[11]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                        local price = math.floor(v.prix / 100 * 60)
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..price.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                            
                            if Selected then
                                vehChoisis = v
                            end
                        end, RMenu:Get('yesorno', "yesorno_main"))
                    end

                end, function()
                end, 1)


                RageUI.IsVisible(RMenu:Get("yesorno",'yesorno_main'),true,true,true,function()
                    destorycam()
                    RageUI.ButtonWithStyle("Confirmer", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local price = math.floor(vehChoisis.prix / 100 * 60)
                            ESX.TriggerServerCallback('esx_vehicleshop:checkMoney', function(success)
                                if success then
                                    
                                    DeleteVehicle(local_veh.entity)
                                    local generatedPlate = string.upper(GetRandomLetter(3) .. ' ' .. GetRandomNumber(3))
                                    TriggerServerEvent("esx_vehicleshop:ajoutVeh", generatedPlate, price, vehChoisis.vehs)
                                    RageUI.CloseAll()
                                end
                            end,  price)
                        end
                    end)
                    RageUI.ButtonWithStyle("Annuler", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            DeleteVehicle(local_veh.entity)
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end, 1)

                -- CATALOGUE

                RageUI.IsVisible(RMenu:Get("catalogue",'catalogue_main'),true,true,true,function()

                    RageUI.ButtonWithStyle("Compacts", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)   
                    end,RMenu:Get('concess2_compact', 'concess_compact_main'))

                    RageUI.ButtonWithStyle("Coupes", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                    end,RMenu:Get('concess2_coupes', 'concess_coupes_main'))

                    RageUI.ButtonWithStyle("Muscle", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                    end,RMenu:Get('concess2_muscle', 'concess_muscle_main'))

                    RageUI.ButtonWithStyle("Off-Road", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                    end,RMenu:Get('concess2_offroad', 'concess_offroad_main'))

                    RageUI.ButtonWithStyle("SUVs", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                    end,RMenu:Get('concess2_suv', 'concess_suv_main'))

                    RageUI.ButtonWithStyle("Sedans", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)
                    end,RMenu:Get('concess2_sedans', 'concess_sedans_main'))

                    RageUI.ButtonWithStyle("Sport", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)                       
                    end,RMenu:Get('concess2_sport', 'concess_sport_main'))

                    RageUI.ButtonWithStyle("Sport Classique", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)                       
                    end,RMenu:Get('concess2_sportclass', 'concess_sportclass_main'))

                    RageUI.ButtonWithStyle("Super", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)                       
                    end,RMenu:Get('concess2_super', 'concess_super_main'))

                    RageUI.ButtonWithStyle("Vans", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)                       
                    end,RMenu:Get('concess2_van', 'concess_van_main'))

                    RageUI.ButtonWithStyle("Moto", nil, { RightLabel = "→→" }, not codesCooldown, function(_,_,s)                       
                    end,RMenu:Get('concess2_moto', 'concess_moto_main'))

                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess2_compact",'concess_compact_main'),true,true,true,function()
                    for k,v in pairs(vehicleConcess[1]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                    
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..v.prix.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                        end)
                    end

                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess2_coupes",'concess_coupes_main'),true,true,true,function()
                    for k,v in pairs(vehicleConcess[2]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                    
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..v.prix.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                        end)
                    end

                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess2_muscle",'concess_muscle_main'),true,true,true,function()
                    for k,v in pairs(vehicleConcess[3]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                    
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..v.prix.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                        end)
                    end

                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess2_offroad",'concess_offroad_main'),true,true,true,function()
                    for k,v in pairs(vehicleConcess[4]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                    
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..v.prix.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                        end)
                    end

                end, function()
                end, 1)
                
                RageUI.IsVisible(RMenu:Get("concess2_suv",'concess_suv_main'),true,true,true,function()
                    for k,v in pairs(vehicleConcess[5]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                    
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..v.prix.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                        end)
                    end

                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess2_sedans",'concess_sedans_main'),true,true,true,function()
                    for k,v in pairs(vehicleConcess[6]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                    
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..v.prix.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                        end)
                    end

                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess2_sport",'concess_sport_main'),true,true,true,function()
                    for k,v in pairs(vehicleConcess[7]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                    
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..v.prix.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                        end)
                    end

                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess2_sportclass",'concess_sportclass_main'),true,true,true,function()
                    for k,v in pairs(vehicleConcess[8]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                    
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..v.prix.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                        end)
                    end

                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess2_super",'concess_super_main'),true,true,true,function()
                    for k,v in pairs(vehicleConcess[9]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                    
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..v.prix.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                        end)
                    end

                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess2_van",'concess_van_main'),true,true,true,function()
                    for k,v in ipairs(vehicleConcess[10]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                    
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..v.prix.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                           
                        end)
                    end

                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("concess2_moto",'concess_moto_main'),true,true,true,function()
                    for k,v in ipairs(vehicleConcess[11]) do
                        camConcessEnter()
                        local displaytext = GetDisplayNameFromVehicleModel(v.vehs)
                        local veh_name
                        if v.label == nil then
                            veh_name = GetLabelText(displaytext)
                        else
                            veh_name = v.label
                        end
                    
                        RageUI.ButtonWithStyle(veh_name, nil, {RightLabel = "~r~"..v.prix.."$~w~ →→"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if local_veh.model ~= GetHashKey(v.vehs) then
                                    DeleteVehicle(local_veh.entity)
                                    CreateLocalVeh(GetHashKey(v.vehs))
                                end
                            end
                        
                        end)
                    end

                end, function()
                end, 1)

                -- MECANO
                RageUI.IsVisible(RMenu:Get("mecano",'mecano_main'),true,true,true,function()

                    RageUI.ButtonWithStyle("Changement externe", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)                        
                    end, RMenu:Get('cosmetic', "cosmetic_main"))

                    RageUI.ButtonWithStyle("Changement interne", nil, { RightLabel = "→→" }, true, function(_,_,s)
                    end, RMenu:Get('upgrade', 'upgrade_main'))

                    RageUI.ButtonWithStyle("Options du véhicule", nil, { RightLabel = "→→" }, true, function(_,_,s)
                    end, RMenu:Get('option', 'option_main'))

                    RageUI.ButtonWithStyle("Repeindre le véhicule", nil, { RightLabel = "→→" }, true, function(_,_,s)
                    end, RMenu:Get('peinture', 'peinture_main'))

                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("cosmetic",'cosmetic_main'),true,true,true,function()
                    for k,v in ipairs(Externe) do
                        RageUI.ButtonWithStyle(v.name, nil, { RightLabel = "→→" }, true, function()
                        end, RMenu:Get('mecano', v.name))
                    end
                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("upgrade",'upgrade_main'),true,true,true,function()
                    for k,v in ipairs(Interne) do
                        RageUI.ButtonWithStyle(v.name, nil, { RightLabel = "→→" }, true, function()
                        end, RMenu:Get('mecano', v.name))
                    end
                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("option",'option_main'),true,true,true,function()
                    RageUI.ButtonWithStyle("Phares xenon ~g~ON", nil, {}, true, function(_,_,selected)
                        if selected then
                            ESX.Game.SetVehicleProperties(pVeh, {modXenon = true})
                            UpdateVehProps()
                        end
                    end)
                    RageUI.ButtonWithStyle("Phares xenon ~r~OFF", nil, {}, true, function(_,_,selected)
                        if selected then
                            ESX.Game.SetVehicleProperties(pVeh, {modXenon = false})
                            UpdateVehProps()
                        end
                    end)
                    RageUI.Separator("Teinte des vitres")
                    for i=  1,5 do
                        local vitre = GetWindowName(i)
                        RageUI.ButtonWithStyle(vitre, nil, {}, true, function(_,_,selected)
                            if selected then
                                ESX.Game.SetVehicleProperties(pVeh, {windowTint = i})
                                UpdateVehProps()
                            end
                        end)
                    end
                    RageUI.Separator("Plaque de couleur")
                    for i = 0,4 do
                        local plaque = GetPlatesName(i)
                        RageUI.ButtonWithStyle(plaque, nil, {}, true, function(_,_,selected)
                            if selected then
                                ESX.Game.SetVehicleProperties(pVeh, {plateIndex = i})
                                UpdateVehProps()
                            end
                        end)
                    end
                    RageUI.Separator("Fumer des pneus")
                    RageUI.ButtonWithStyle("Fumer de couleur ~g~ON", nil, {}, true, function(_,_,selected)
                        if selected then
                            ESX.Game.SetVehicleProperties(pVeh, {modSmokeEnabled = true})
                            UpdateVehProps()
                        end
                    end)
                    RageUI.ButtonWithStyle("Fumer de couleur ~r~OFF", nil, {}, true, function(_,_,selected)
                        if selected then
                            ESX.Game.SetVehicleProperties(pVeh, {modSmokeEnabled = false})
                            UpdateVehProps()
                        end
                    end)
                    local couleur = GetNeons()
                    for _,i in pairs(couleur) do
                        RageUI.ButtonWithStyle(i.label, nil, {}, true, function(_,_,selected)
                            if selected then
                                ESX.Game.SetVehicleProperties(pVeh, {tyreSmokeColor = {i.r, i.g, i.b}})
                                UpdateVehProps()
                            end
                        end)
                    end
                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get("peinture",'peinture_main'),true,true,true,function()
                    RageUI.ButtonWithStyle("Changer des reflets", nil, { RightLabel = "→→" }, true, function(_,_,s)
                        if s then
                            PaintType = 1
                        end
                    end, RMenu:Get('Choixcouleur', "Choixcouleur_main"))

                    RageUI.ButtonWithStyle("Changer la couleur primaire", nil, { RightLabel = "→→" }, true, function(_,_,s)
                        if s then
                            PaintType = 2
                        end
                    end, RMenu:Get('Choixcouleur', "Choixcouleur_main"))

                    RageUI.ButtonWithStyle("Changer la couleur secondaire", nil, { RightLabel = "→→" }, true, function(_,_,s)
                        if s then
                            PaintType = 3
                        end
                    end, RMenu:Get('Choixcouleur', "Choixcouleur_main"))

                    RageUI.ButtonWithStyle("Changer la couleur des jantes", nil, { RightLabel = "→→" }, true, function(_,_,s)
                        if s then
                            PaintType = 4
                        end
                    end, RMenu:Get('Choixcouleur', "Choixcouleur_main"))

                    RageUI.ButtonWithStyle("Géstion des néons", nil, { RightLabel = "→→" }, true, function(_,_,s)
                        if s then
                            PaintType = 4
                        end
                    end, RMenu:Get('neon', "neon_main"))
                end, function()
                end, 1)

                RageUI.IsVisible(RMenu:Get('neon', "neon_main"), true, true, true, function()
                    local pPed = GetPlayerPed(-1)
                    local pVeh = GetVehiclePedIsIn(pPed, 0)
                    local neons = GetNeons()
                    SetVehicleEngineOn(pVeh, 1, 1, 0)

                    RageUI.Checkbox("Activé les néon", "Activer ou non les néons du véhicule", IsVehicleNeonLightEnabled(pVeh, 2), { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                        if (Active) then
                            if IsVehicleNeonLightEnabled(pVeh, 2) then
                                for i = 0,3 do
                                    SetVehicleNeonLightEnabled(pVeh, i, 0)
                                    UpdateVehProps()
                                end
                            else
                                for i = 0,3 do
                                    SetVehicleNeonLightEnabled(pVeh, i, 1)
                                    UpdateVehProps()
                                end
                            end
                        end
                    end, function()
                        -- check
                    end, function()
                        -- uncheck
                    end) 

                    RageUI.Separator("Liste des néons")
                    for k,v in ipairs(neons) do
                        RageUI.ButtonWithStyle(v.label, nil, { }, true, function(_,a,s)
                            if a then
                                SetVehicleNeonLightsColour(pVeh, v.r, v.g, v.b)
                            end
                            if s then
                                SetVehicleNeonLightsColour(pVeh, v.r, v.g, v.b)
                                UpdateVehProps()
                            end
                        end)
                    end
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('Choixcouleur', "Choixcouleur_main"), true, true, true, function()
                    for k,v in ipairs(Colors) do
                        RageUI.ButtonWithStyle(v.label, nil, { RightLabel = "→→" }, true, function(_,_,s)
                        end, RMenu:Get('mecano', v.value))
                    end
                end, function()
                end)

                for k,v in ipairs(Colors) do
                    RageUI.IsVisible(RMenu:Get('mecano', v.value), true, true, true, function()
                        local pPed = GetPlayerPed(-1)
                        local pVeh = GetVehiclePedIsIn(pPed, 0)
                        local colors = GetColors(v.value)
                        for _,i in pairs(colors) do
                            RageUI.ButtonWithStyle(i.label, nil, { }, true, function(_,a,s)
                                if a then
                                    if PaintType == 1 then
                                        ESX.Game.SetVehicleProperties(pVeh, {pearlescentColor = i.index})
                                    elseif PaintType == 2 then
                                        ESX.Game.SetVehicleProperties(pVeh, {color1 = i.index})
                                    elseif PaintType == 3 then
                                        ESX.Game.SetVehicleProperties(pVeh, {color2 = i.index})
                                    elseif PaintType == 4 then
                                        ESX.Game.SetVehicleProperties(pVeh, {wheelColor = i.index})
                                    end
                                end
                                if s then
                                    if PaintType == 1 then
                                        ESX.Game.SetVehicleProperties(pVeh, {pearlescentColor = i.index})
                                        UpdateVehProps()
                                    elseif PaintType == 2 then
                                        ESX.Game.SetVehicleProperties(pVeh, {color1 = i.index})
                                        UpdateVehProps()
                                    elseif PaintType == 3 then
                                        ESX.Game.SetVehicleProperties(pVeh, {color2 = i.index})
                                        UpdateVehProps()
                                    elseif PaintType == 4 then
                                        ESX.Game.SetVehicleProperties(pVeh, {wheelColor = i.index})
                                        UpdateVehProps()
                                    end
                                end
                            end)

                        end
                    end, function()
                    end)
                end

                for k,v in ipairs(Externe) do
                    RageUI.IsVisible(RMenu:Get('mecano', v.name), true, true, true, function()
                        local pPed = GetPlayerPed(-1)
                        local pVeh = GetVehiclePedIsIn(pPed, 0)
                        local num = GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), 0), v.modType)
                        local installed = GetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), 0), v.modType)
                        local currentMods = ESX.Game.GetVehicleProperties(GetVehiclePedIsIn(GetPlayerPed(-1), 0))

                        if v.modType == 36 or v.modType == 37 or v.modType == 38 or v.modType == 39 or v.modType == 40 or v.modType == 41 or v.modType == 42 or v.modType == 45 then
                            for i = 0,10 do
                                SetVehicleDoorOpen(pVeh, i, false)
                            end
                        end

                        if v.modType == 23 then
                            for _, j in pairs(weels) do
                                RageUI.ButtonWithStyle(j.name, nil, { RightLabel = "→→" }, true, function(_,_,s)
                                    if s then 
                                        SetVehicleWheelType(pVeh, j.type) 
                                    end
                                end, RMenu:Get('mecano', j.name))
                            end
                        end

                        RageUI.ButtonWithStyle("Stock", nil, {}, true, function(_,Active,Selected)
                            if Selected then
                                SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), 0), v.modType, -1, 0)
                                UpdateVehProps()
                            end
                            if Active then
                                SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), 0), v.modType, -1, 0)
                            end
                        end)

                        for i = 0, num-1 do 
                            local modName = GetModTextLabel(GetVehiclePedIsIn(GetPlayerPed(-1), 0), v.modType, i)

                            if v.modType == 14 then
                                RageUI.ButtonWithStyle(GetHornName(i), nil, { RightLabel = "~g~"..GetPrice(v.basePrice).."$" }, true, function(_,Active,Selected)
                                    if Selected then
                                        --ESX.TriggerServerCallback('mecano:buyCustom', function(success)
                                        --    if success then
                                                SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), 0), v.modType, i, 0)
                                                ESX.ShowNotification(v.name.." "..tostring(i+1).." installé")
                                                UpdateVehProps()
                                        --    else
                                        --        print("no")
                                        --    end
                                        --end, GetPrice(v.basePrice))
                                    end
                                    if Active then
                                        SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), 0), v.modType, i, 0)
                                    end
                                end)
                            elseif v.modType == 48 then
                                RageUI.ButtonWithStyle(GetLabelText(modName), nil, { RightLabel = "~g~"..GetPrice(v.basePrice).."$" }, true, function(_,Active,Selected)
                                    if Selected then
                                        --ESX.TriggerServerCallback('mecano:buyCustom', function(success)
                                            --if success then
                                                SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), 0), 48, i, 0)
                                                SetVehicleLivery(vehicle, i)
                                                ESX.ShowNotification(v.name.." "..tostring(i+1).." installé")
                                                ESX.Game.SetVehicleProperties(GetVehiclePedIsIn(GetPlayerPed(-1), 0), {modLivery = i})
                                                UpdateVehProps()
                                            --else
                                            --    print("no")
                                            --end
                                       -- end, GetPrice(v.basePrice))
                                    end
                                    if Active then
                                        SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), 0), 48, i, 0)
                                        SetVehicleLivery(vehicle, i)
                                    end
                                end)
                            elseif v.modType == 23 then
                                break
                            else
                                if installed == i then
                                    RageUI.ButtonWithStyle(GetLabelText(modName), nil, { RightLabel = "~g~"..GetPrice(v.basePrice).."$" }, true, function(_,Active,Selected)
                                        if Selected then
                                            --ESX.TriggerServerCallback('mecano:buyCustom', function(success)
                                            --    if success then
                                                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), 0), v.modType, i, 0)
                                                    ESX.ShowNotification(v.name.." "..tostring(i+1).." installé")
                                                    UpdateVehProps()
                                            --    else
                                            --        print("no")
                                            --    end
                                            --end, GetPrice(v.basePrice))
                                        end
                                        if Active then
                                            SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), 0), v.modType, i, 0)
                                        end
                                    end)
                                else
                                    RageUI.ButtonWithStyle(GetLabelText(modName), nil, { RightLabel = "~g~"..GetPrice(v.basePrice).."$" }, true, function(_,Active,Selected)
                                        if Selected then
                                            --ESX.TriggerServerCallback('mecano:buyCustom', function(success)
                                            --    if success then
                                                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), 0), v.modType, i, 0)
                                                    ESX.ShowNotification(v.name.." "..tostring(i+1).." installé")
                                                    UpdateVehProps()
                                            --    else
                                            --        print("no")
                                            --    end
                                            --end, GetPrice(v.basePrice))
                                        end
                                        if Active then
                                            SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), 0), v.modType, i, 0)
                                        end
                                    end)
                                end
                            end


                        end
                    end, function()
                    end)
                end

                for k,v in ipairs(weels) do
                    RageUI.IsVisible(RMenu:Get('mecano', v.name), true, true, true, function()
                        local pPed = GetPlayerPed(-1)
                        local pVeh = GetVehiclePedIsIn(pPed, 0)
                        SetVehicleWheelType(pVeh, v.type)
                        local num = GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), 0), 23)

                        for i = 0, num-1 do
                            local modName = GetModTextLabel(GetVehiclePedIsIn(GetPlayerPed(-1), 0), 23, i)
                            RageUI.ButtonWithStyle(GetLabelText(modName), nil, {}, true, function(_,Active,Selected)
                                if Selected then
                                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), 0), 23, i, 0)
                                    ESX.ShowNotification(v.name.." "..tostring(i+1).." installé")
                                    UpdateVehProps()
                                end
                                if Active then
                                    SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), 0), 23, i, 0)
                                end
                            end)
                        end

                    end, function()
                    end)
                end

                for k,v in ipairs(Interne) do
                    RageUI.IsVisible(RMenu:Get('mecano', v.name), true, true, true, function()
                        local num = GetNumVehicleMods(GetVehiclePedIsIn(GetPlayerPed(-1), 0), v.modType)
                        local installed = GetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), 0), v.modType)
                        local pPed = GetPlayerPed(-1)
                        local pVeh = GetVehiclePedIsIn(pPed, 0)

                        if v.modType == 17 then
                            RageUI.ButtonWithStyle("Turbo", nil, { RightLabel = "~g~"..GetPrice(v.basePrice).."$" }, true, function(_,Active,Selected)
                                if Selected then
                                    --ESX.TriggerServerCallback('mecano:buyCustom', function(success)
                                    --    if success then
                                            ToggleVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), 0), 17, 1)
                                            ESX.Game.SetVehicleProperties(pVeh, {modTurbo = true})
                                            ESX.ShowNotification("Turbo installé")
                                            UpdateVehProps()
                                    --    else
                                    --        print("no")
                                    --    end
                                    --end, GetPrice(v.basePrice))
                                end
                            end)
                        end

                        for i = 0, num-1 do 
                            if installed == i then
                                RageUI.ButtonWithStyle(v.name.." - "..i+1, nil, { RightBadge = RageUI.BadgeStyle.Tick }, true, function(_,Active,Selected)
                                    if Selected then
                                        SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), 0), v.modType, i, 0)
                                        ESX.ShowNotification("Turbo installé")
                                        UpdateVehProps()
                                    end
                                end)
                            else
                                RageUI.ButtonWithStyle(v.name.." - "..i+1, nil, { RightLabel = "~g~"..GetPrice(v.basePrice).."$" }, true, function(_,Active,Selected)
                                    if Selected then
                                       -- ESX.TriggerServerCallback('mecano:buyCustom', function(success)
                                       --     if success then
                                            SetVehicleMod(GetVehiclePedIsIn(GetPlayerPed(-1), 0), v.modType, i, 0)
                                            ESX.ShowNotification(v.name.." "..tostring(i+1).." installé")
                                            UpdateVehProps()
                                        --    else
                                        --        print("no")
                                        --    end
                                        --end, GetPrice(v.basePrice))
                                    end
                                end)
                            end
                        end

                    end, function()
                    end)
                end

                RageUI.IsVisible(RMenu:Get('mecano_vestiaire', "mecano_vestiaire_main"), true, true, true, function()
                    RageUI.ButtonWithStyle("Tenue de civil",nil, {RightLabel = "~b~Changer~s~ →→"}, true, function(_,_,s)
                        if s then
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                            end)
                        end
                    end)
  
                    for i = 1,#pzCore.jobs["mecano"].config.clothes do
                        RageUI.ButtonWithStyle(pzCore.jobs["mecano"].config.clothes[i].label,nil, {RightLabel = "~b~Changer~s~ →→"}, true, function(_,_,s)
                            if s then
                                pzCore.jobs["mecano"].setUniform(PlayerPedId(),i)
                            end
                        end)
                    end
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get("mecano_dynamicmenu",'mecano_dynamicmenu_main'),true,true,true,function()
                    menu = true

                    RageUI.Separator("↓ ~b~Statut de service ~s~↓")
                    RageUI.Checkbox("Statut de service", nil, inServiceMecano, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                        inServiceMecano = Checked;
                    end, function()
                        inServiceMecano = true
                        pzCore.mug("Statut de service","Mécano","Statut: ~g~en service~s~.")
                    end, function()
                        pzCore.mug("Statut de service","Mécano","Statut: ~r~hors service~s~.")
                        Citizen.SetTimeout(580, function()
                            inServiceMecano = false
                        end)
                    end)

                    if inServiceMecano then

                    RageUI.Separator("↓ ~o~Interactions ~s~↓")

                        RageUI.ButtonWithStyle("Interactions véhicules", "Vous permets d'accéder aux interactions véhicules", { RightLabel = "→→" }, true, function()
                        end, RMenu:Get('mecano_dynamicmenu', 'mecano_dynamicmenu_veh'))

                        RageUI.ButtonWithStyle("Donner une facture",nil, {RightLabel = "~b~Facturer~s~ →→"}, true, function(_,_,s)
                            if s then
                                local raison = ""
                                local montant = 0
                                local closestPlayer = ESX.Game.GetClosestPlayer()
    
                                AddTextEntry("FMMC_MPM_NA", "Raison de la facture")
                                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez une raison de la facture:", "", "", "", "", 30)
                                while (UpdateOnscreenKeyboard() == 0) do
                                    DisableAllControlActions(0)
                                    Wait(0)
                                end
                                if (GetOnscreenKeyboardResult()) then
                                    local result = GetOnscreenKeyboardResult()
                                    if result then
                                        raison = result
                                        result = nil
                                        AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le montant de la facture:", "", "", "", "", 30)
                                        while (UpdateOnscreenKeyboard() == 0) do
                                            DisableAllControlActions(0)
                                            Wait(0)
                                        end
                                        if (GetOnscreenKeyboardResult()) then
                                            result = GetOnscreenKeyboardResult()
                                            if result then
                                                montant = result
                                                result = nil
                                                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_mecano', raison, tonumber(montant))
                                                pzCore.mug("~r~Tablette Mécano", "Facture envoyée","Vous avez envoyé une facture à la personne: ~b~\""..raison.."\"~s~: ~r~"..montant.."$")
                                            end
                                        end
                                        
                                    end
                                end
                            end
                        end)
                    end

                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("mecano_dynamicmenu",'mecano_dynamicmenu_veh'),true,true,true,function()
                    menu = true
                    local coords  = GetEntityCoords(PlayerPedId())
                    local vehicle = ESX.Game.GetVehicleInDirection()
                    
                    RageUI.ButtonWithStyle("Réparer le véhicule", "Permet de réparer le véhicule le plus proche.", { RightLabel = "→→" }, DoesEntityExist(vehicle), function(Hovered, Active, Selected)
                        local pos = GetEntityCoords(PlayerPedId())
                        local veh, dst = ESX.Game.GetClosestVehicle({x = pos.x, y = pos.y, z = pos.z})
                        if Active then 
                            pos = GetEntityCoords(veh)
                            DrawMarker(2, pos.x, pos.y, pos.z+1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 170, 0, 1, 2, 0, nil, nil, 0)
                        end
                        if Selected then
                            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)
                            Citizen.CreateThread(function()
                                Citizen.Wait(20000)
                                ClearPedTasksImmediately(PlayerPedId())
                                SetVehicleFixed(veh)
                                SetVehicleDeformationFixed(veh)
                                SetVehicleDirtLevel(veh, 0.0)
                                SetVehicleEngineHealth(veh, 1000.0)
                            end)
                        end
                    end)

                    RageUI.ButtonWithStyle("Nettoyer le véhicule", "Permet de nettoyer le véhicule le plus proche.", { RightLabel = "→→" }, DoesEntityExist(vehicle), function(Hovered, Active, Selected)
                        local pos = GetEntityCoords(PlayerPedId())
                        local veh, dst = ESX.Game.GetClosestVehicle({x = pos.x, y = pos.y, z = pos.z})
                        local playerPed = PlayerPedId()
                        if Active then 
                            pos = GetEntityCoords(veh)
                            DrawMarker(2, pos.x, pos.y, pos.z+1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 170, 0, 1, 2, 0, nil, nil, 0)
                        end
                        if Selected then
                            TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
                            Citizen.CreateThread(function()
				            	Citizen.Wait(10000)
				            	SetVehicleDirtLevel(veh, 0)
				            	ClearPedTasksImmediately(playerPed)
                            
				            	ESX.ShowNotification('~g~Voiture nettoyer.')
				            end)
                        end
                    end)

                    RageUI.ButtonWithStyle("Crocheter le véhicule", nil, { RightLabel = "→→" }, DoesEntityExist(vehicle), function(_,_,s)
                        if s then
                            if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
                                TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_WELDING', 0, true)
                                Citizen.Wait(20000)
                                ClearPedTasksImmediately(PlayerPedId())
    
                                SetVehicleDoorsLocked(vehicle, 1)
                                SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                                ESX.ShowNotification("~o~Véhicule dévérouillé!")
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle("Mettre en fourrière", nil, { RightLabel = "→→" }, DoesEntityExist(vehicle), function(_,_,s)
                        if s then
                            if currentTask.busy then
                                return
                            end

                            TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
    
                            currentTask.busy = true
                            currentTask.task = ESX.SetTimeout(10000, function()
                                ClearPedTasks(playerPed)
                                ESX.Game.DeleteVehicle(vehicle)
                                ESX.ShowNotification("~o~Mise en fourrière effectuée")
                                currentTask.busy = false
                                Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
                            end)
    
                            -- keep track of that vehicle!
                            Citizen.CreateThread(function()
                                while currentTask.busy do
                                    Citizen.Wait(1000)
    
                                    vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
                                    if not DoesEntityExist(vehicle) and currentTask.busy then
                                        ESX.ShowNotification("~r~Le véhicule a bougé!")
                                        ESX.ClearTimeout(currentTask.task)
                                        ClearPedTasks(playerPed)
                                        currentTask.busy = false
                                        break
                                    end
                                end
                            end)
                        end
                    end)
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("mecano_vehicle",'mecano_vehicle_main'),true,true,true,function()
                    for k,v in pairs(pzCore.jobs["mecano"].config.vehicles) do
                        RageUI.ButtonWithStyle(v.label,nil, {RightLabel = "~b~Sortir~s~ →→"}, not codesCooldown, function(_,_,s)
                            if s then
                                RageUI.CloseAll()
                                pzCore.jobs["mecano"].spawnCar(PlayerPedId(),v.model)
                            end
                        end)
                    end
                end, function()    
                end, 1)

                -- Ambulance

                RageUI.IsVisible(RMenu:Get('ambulance_vestiaire', "ambulance_vestiaire_main"), true, true, true, function()
                    RageUI.ButtonWithStyle("Tenue de civil",nil, {RightLabel = "~b~Changer~s~ →→"}, true, function(_,_,s)
                        if s then
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                            end)
                        end
                    end)
  
                    for i = 1,#pzCore.jobs["ambulance"].config.clothes do
                        RageUI.ButtonWithStyle(pzCore.jobs["ambulance"].config.clothes[i].label,nil, {RightLabel = "~b~Changer~s~ →→"}, true, function(_,_,s)
                            if s then
                                pzCore.jobs["ambulance"].setUniform(PlayerPedId(),i)
                            end
                        end)
                    end
                end, function()
                end)
                
                RageUI.IsVisible(RMenu:Get("ambulance_vehicle",'ambulance_vehicle_main'),true,true,true,function()
                    for k,v in pairs(pzCore.jobs["ambulance"].config.vehicles) do
                        RageUI.ButtonWithStyle(v.label,nil, {RightLabel = "~b~Sortir~s~ →→"}, not codesCooldown, function(_,_,s)
                            if s then
                                RageUI.CloseAll()
                                pzCore.jobs["ambulance"].spawnCar(PlayerPedId(),v.model)
                            end
                        end)
                    end
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("ambulance_pharmacie",'ambulance_pharmacie_main'),true,true,true,function()
                    for k,v in pairs(pzCore.jobs["ambulance"].config.item) do
                        RageUI.ButtonWithStyle(v.label,"~r~Maximum 5 sur vous.",{RightLabel = "~b~Prendre~s~ →→"}, true, function(_,_,s)
                            if s then
                                TriggerServerEvent("pz_core:givePharamacie", v.item)
                            end
                        end)
                    end
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("ambulance_heli",'ambulance_heli_main'),true,true,true,function()
                    for i = 1,#pzCore.jobs["ambulance"].config.helicopters do
                        RageUI.ButtonWithStyle(pzCore.jobs["ambulance"].config.helicopters[i].name,"Vous permets de sortir cet hélicoptère", {RightBadge = RageUI.BadgeStyle.Heli}, ESX.PlayerData.job.grade >= pzCore.jobs["ambulance"].config.helicopters[i].minGrade, function(_,_,s)
                            if s then
                                RageUI.CloseAll()
                                pzCore.jobs["ambulance"].spawnHeli(pzCore.jobs["ambulance"].config.helicopters[i].model,PlayerPedId())
                            end
                        end)
                    end
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("ambulance_dynamicmenu",'ambulance_dynamicmenu_main'),true,true,true,function()
                    menu = true
                    RageUI.Separator("↓ ~b~Statut de service ~s~↓")
                    RageUI.Checkbox("Statut de service", nil, inServiceAmbulance, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                        inServiceAmbulance = Checked;
                    end, function()
                        inServiceAmbulance = true
                        pzCore.mug("Statut de service","Ambulance","Statut: ~g~en service~s~.")
                    
                    end, function()
                        pzCore.mug("Statut de service","Ambulance","Statut: ~r~hors service~s~.")
                        Citizen.SetTimeout(580, function()
                            inServiceAmbulance = false
                        end)
                    end)

                    if inServiceAmbulance then

                    RageUI.Separator("↓ ~o~Interactions ~s~↓")

                        RageUI.ButtonWithStyle("Interactions citoyens", "Vous permets d'accéder aux interactions citoyens", { RightLabel = "→→" }, true, function()
                        end, RMenu:Get('ambulance_dynamicmenu', 'ambulance_dynamicmenu_cit'))
                        RageUI.ButtonWithStyle("Liste des appels", "Gestion des appels", { RightLabel = "→→" }, true, function(Hovered, Selected, Active, Checked)
                            if Selected then 
                                LoadAppel()
                            end
                        end, RMenu:Get('ambulance_dynamicmenu', 'ambulance_dynamicmenu_appel'))

                    end
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("ambulance_dynamicmenu",'ambulance_dynamicmenu_cit'),true,true,true,function()
                    menu = true
                    RageUI.ButtonWithStyle("Réanimer", nil, {RightLabel = "~b~Soignez~s~ →→"}, true, function(Hovered, Active, Selected)
                        local closestPlayer = ESX.Game.GetClosestPlayer()
                        if Selected then
                            revivePlayer(closestPlayer)
                        end
                    end)
                    RageUI.ButtonWithStyle("Soignez blessure", nil, {RightLabel = "~b~Soignez~s~ →→"}, true, function(Hovered, Active, Selected)
                        local closestPlayer = ESX.Game.GetClosestPlayer()
                        if Selected then
                            ESX.TriggerServerCallback('ambulance:getItemAmount', function(quantity)
                                if quantity > 0 then
                                    local closestPlayerPed = GetPlayerPed(closestPlayer)
                                    local health = GetEntityHealth(closestPlayerPed)
    
                                    if health > 0 then
                                        local playerPed = PlayerPedId()
    
                                        isBusy = true
                                        ESX.ShowNotification("~g~Vous êtes entrein de le soingez")
                                        TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                                        Citizen.Wait(10000)
                                        ClearPedTasks(playerPed)
    
                                        TriggerServerEvent('ambulance:removeItem', 'bandage')
                                        TriggerServerEvent('ambulance:heal', GetPlayerServerId(closestPlayer), 'small')
                                        ESX.ShowNotification('~r~Vous avez soignez '..GetPlayerName(closestPlayer))
                                        isBusy = false
                                    else
                                        ESX.ShowNotification('~r~Aucun joueur inconscient à distance.')
                                    end
                                else
                                    ESX.ShowNotification("~r~Vous n'avez pas de bandage.")
                                end
                            end, 'bandage')
                        end
                    end)
                    RageUI.ButtonWithStyle("Donner une facture",nil, {RightLabel = "~b~Facturer~s~ →→"}, true, function(_,_,s)
                        if s then
                            local raison = ""
                            local montant = 0
                            local closestPlayer = ESX.Game.GetClosestPlayer()

                            AddTextEntry("FMMC_MPM_NA", "Raison de la facture")
                            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez une raison de la facture:", "", "", "", "", 30)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0)
                                Wait(0)
                            end
                            if (GetOnscreenKeyboardResult()) then
                                local result = GetOnscreenKeyboardResult()
                                if result then
                                    raison = result
                                    result = nil
                                    AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                                    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le montant de la facture:", "", "", "", "", 30)
                                    while (UpdateOnscreenKeyboard() == 0) do
                                        DisableAllControlActions(0)
                                        Wait(0)
                                    end
                                    if (GetOnscreenKeyboardResult()) then
                                        result = GetOnscreenKeyboardResult()
                                        if result then
                                            montant = result
                                            result = nil
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_ambulance', raison, tonumber(montant))
                                            pzCore.mug("~r~Tablette Ambulance", "Facture envoyée","Vous avez envoyé une facture à la personne: ~b~\""..raison.."\"~s~: ~r~"..montant.."$")
                                        end
                                    end
                                    
                                end
                            end
                        end
                    end)
                end, function()    
                end, 1)
                
                RageUI.IsVisible(RMenu:Get("ambulance_dynamicmenu",'ambulance_dynamicmenu_appel'),true,true,true,function()
                
                    menu = true
                    
                    for k,v in pairs(appellistsql) do
                        local label
                        if v.state then
                            label = "~g~EN COURS"
                        else
                            label = "~r~EN ATTENTE"
                        end
                        RageUI.ButtonWithStyle("["..k.."] - "..v.name, nil, {RightLabel = label}, true, function(Hovered, Active, Selected)
                            if Selected then 
                                PlayerSelected = v
                                --selected2 = {s = GetPlayerServerId(v.src)}
                                --TriggerServerEvent("sAmbulance:priseDeLapelleNotif", selected2.s)
                                TriggerServerEvent("ambulance:updtateStatu", PlayerSelected.name, 1)
                                print(PlayerSelected.name)
                            end
                        end, RMenu:Get('ambulance_dynamicmenu', 'ambulance_dynamicmenu_knowappel'))
        
                        
                    end
                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get('ambulance_dynamicmenu', 'ambulance_dynamicmenu_knowappel'), true, true, true, function()
                    menu = true
                    RageUI.Separator("~b~Nom du joueur : ~s~"..PlayerSelected.name)
                    RageUI.Separator("~b~Date : ~s~"..PlayerSelected.date)
					RageUI.Separator("~r~Action")
					RageUI.ButtonWithStyle("Mettre un point sur le GPS", nil, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
							blipsForPayerDead(PlayerSelected.coord)
						end
                    end)
                    RageUI.ButtonWithStyle("Envoyé un message", "BIENTOT FIX DESOULER", {}, false, function(Hovered, Active, Selected)
                        if (Selected) then
                            local message = Pz_admin.utils.keyboard("Message","Entrez un message:")
                            TriggerServerEvent("ambulance:sendMess", selected2.s, message)
						end
                    end)
                    RageUI.ButtonWithStyle("~r~Supprimer", nil, {RightLabel = "~b~Éxecuter ~s~→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            for k,v in ipairs(appellistsql) do
                                table.remove(appellistsql, k)
                                TriggerServerEvent("ambulance:suppappel", PlayerSelected.name)
								RageUI.GoBack()
							end
						end
					end)
				end, function()
				end)

                dynamicMenu = menu
                
                Citizen.Wait(0)
            end
        end)
    end
}

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
  
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
      Citizen.Wait(0)
    end
  
    if UpdateOnscreenKeyboard() ~= 2 then
      local result = GetOnscreenKeyboardResult()
      Citizen.Wait(500)
      return result
    else
      Citizen.Wait(500)
      return nil
    end
end

pzCore.menus = Menus
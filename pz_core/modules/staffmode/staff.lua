Pz_admin = {
    
    utils = {
        keyboard = function(title,mess)
            AddTextEntry("FMMC_MPM_NA", title)
            DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", mess, "", "", "", "", 30)
            while (UpdateOnscreenKeyboard() == 0) do
                DisableAllControlActions(0)
                Wait(0)
            end
            if (GetOnscreenKeyboardResult()) then
                local result = GetOnscreenKeyboardResult()
                if result then
                    return result
                end
            end
        end
    },

    functions = {

        [1] = {
            cat = "player",
            sep = "↓ ~b~Téleportations ~s~↓",
            toSub = false,
            label = "Téléportation sur le joueur",
            press = function(selectedPlayer)
                local ped = GetPlayerPed(selectedPlayer.c)
                local pos = GetEntityCoords(ped)
                SetEntityCoords(PlayerPedId(), pos.x, pos.y, pos.z)
                TriggerServerEvent("sLogs:goto", selectedPlayer.s)
            end
        },

        [2] = {
            cat = "player",
            sep = nil,
            toSub = false,
            label = "Téleportation sur moi",
            press = function(selectedPlayer)
                local pos = GetEntityCoords(PlayerPedId())
                TriggerServerEvent("pz_admin:bring", selectedPlayer.s, pos)
            end
        },

        [3] = {
            cat = "player",
            sep = "↓ ~o~Actions diverses ~s~↓",
            toSub = false,
            label = "Voir l'inventaire",
            press = function(selectedPlayer)
                TriggerEvent("pz_admin:inv", selectedPlayer.c)
                --TriggerServerEvent("sLogs:fouillesinventaire", GetPlayerServerId(selected.c))
            end
        },

        [4] = {
            cat = "player",
            sep =  nil,
            toSub = false,
            label = "Réanimer le joueur",
            press = function(selectedPlayer)
                TriggerServerEvent("pz_admin:revive", selectedPlayer.s)
            end
        },

        [5] = {
            cat = "player",
            sep =  nil,
            toSub = false,
            label = "Setjob le joueur",
            press = function(selectedPlayer)
                local job = Pz_admin.utils.keyboard("Job", "Quel job voulez-vous setjob")
                if job ~= nil then 
                    local grade = Pz_admin.utils.keyboard("Grade", "Entrer un grade")
                    if grade ~= nil then 
                        TriggerServerEvent("pz_admin:setJobPlayer", selectedPlayer.s, job, grade)
                    end
                end
            end
        },

        [6] = {
            cat = "player",
            sep =  nil,
            toSub = false,
            label = "Setjob2 le joueur",
            press = function(selectedPlayer)
                local job2 = Pz_admin.utils.keyboard("Job2", "Quel job voulez-vous setjob2")
                if job2 ~= nil then 
                    local grade = Pz_admin.utils.keyboard("Grade", "Entrer un grade")
                    if grade ~= nil then 
                        TriggerServerEvent("pz_admin:setJob2Player", selectedPlayer.s, job2, grade)
                    end
                end
            end
        },
        
        [7] = {
            cat = "player",
            sep =  nil,
            toSub = false,
            label = "Wipe le joueur",
            press = function(selectedPlayer)
                TriggerServerEvent("pz_admin:wipe", selectedPlayer.s)
                TriggerServerEvent("sLogs:wipe", selectedPlayer.s)
            end
        },
    
        [8] = {
            cat = "player",
            sep = nil,
            toSub = false,
            label = "Envoyer un message",
            press = function(selectedPlayer)
                local message = KeyboardInput("Message :", '', '', 100)
                TriggerServerEvent("pz_admin:message", selectedPlayer.s, message)
            end
        },

        [9] = {
            cat = "player",
            sep = nil,
            toSub = false,
            label = "Rembourser le joueur",
            press = function(selectedPlayer)
                TriggerEvent("pz_admin:remb", selectedPlayer.s)
            end
        },

        [10] = {
            cat = "player",
            sep =  "↓ ~r~Sanctions ~s~↓",
            toSub = false,
            label = "Expulser le joueur",
            press = function(selectedPlayer)
                local message = Pz_admin.utils.keyboard("Raison","Entrez une raison:")
                if message ~= nil then
                    TriggerServerEvent("pz_admin:kick", selectedPlayer.s, message)
                    ESX.ShowNotification("~g~Kick effectué!")
                end
            end
        },

        -- Partie moi même

        [11] = {
            cat = "self",
            sep = nil,
            toSub = true,
            label = "Paramètres",
            press = function()
                TriggerEvent("pz_admin:options")
            end
        },

        [12] = {
            cat = "self",
            sep = nil,
            toSub = false,
            label = "Se réanimer",
            press = function()
                TriggerServerEvent("pz_admin:revive", GetPlayerServerId(PlayerId()))
            end
        },

        [13] = {
            cat = "self",
            sep = nil,
            toSub = false,
            label = "Téleportation markeur",
            press = function()
                local playerPed = PlayerPedId()
                local WaypointHandle = GetFirstBlipInfoId(8)
                if DoesBlipExist(WaypointHandle) then
                    local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, WaypointHandle, Citizen.ResultAsVector())
                    SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, -199.9, false, false, false, true)
                end
                TriggerServerEvent("sLogs:gotoMarker")
            end
        },

        [14] = {
            cat = "self",
            sep = nil,
            toSub = false,
            label = "Print les coordonnées",
            press = function()
                local pos = GetEntityCoords(PlayerPedId())
                pzCore.trace(pos.x..", "..pos.y..", "..pos.z)
            end
        },

        [15] = {
            cat = "self",
            sep = nil,
            toSub = false,
            label = "Se give une armes",
            press = function()
                local armes = Pz_admin.utils.keyboard("Armes","Entrez le nom de l'armes :")
                TriggerServerEvent("pz_admin:giveweapon", GetPlayerServerId(PlayerId()), armes)
                TriggerServerEvent("sLogs:giveweapon", armes)
            end
        }, 			
        [16] = {
            cat = "self",
            sep = nil,
            toSub = false,
            label = "S'octroyer de l'argent",
            press = function()
                local cb = Pz_admin.utils.keyboard("Give","Combien voulez-vous vous give d'argent :")
                TriggerServerEvent("pz_admin:giveMoney", cb)
                TriggerServerEvent("sLogs:giveMoney", cb)
            end
        },

        [17] = {
            cat = "self",
            sep = nil,
            toSub = false,
            label = "S'octroyer de l'argent en banque",
            press = function()
                local cb = Pz_admin.utils.keyboard("Give","Combien voulez-vous vous give d'argent en banque :")
                TriggerServerEvent("pz_admin:giveMoneyBank", cb)
                TriggerServerEvent("sLogs:giveMoneyBank", cb)
            end
        },

        [18] = {
            cat = "self",
            sep = nil,
            toSub = false,
            label = "S'octroyer de l'argent sale",
            press = function()
                local cb = Pz_admin.utils.keyboard("Give","Combien voulez-vous vous give d'argent sale :")
                TriggerServerEvent("pz_admin:giveMoneySale", cb)
                TriggerServerEvent("sLogs:giveMoneySale", cb)
            end
        },

        [19] = {
            cat = "self",
            sep = nil,
            toSub = false,
            label = "Chager d'apparence",
            press = function()
                RageUI.CloseAll()
                Citizen.Wait(100)
                TriggerEvent('esx_skin:openSaveableMenu')
            end
        },

        [20] = {
            cat = "veh",
            sep = nil,
            toSub = false,
            label = "Faire apparaître un vehicule",
            press = function()
                local model = Pz_admin.utils.keyboard("Modèle","Entrez un modèle:")
                TriggerServerEvent("sLogs:spawnCar", model)
                if model ~= nil then
                    model = GetHashKey(model)
                    if IsModelValid(model) then
                        RequestModel(model)
                        local co = GetEntityCoords(PlayerPedId())
                        while not HasModelLoaded(model) do Citizen.Wait(10) end

                        local veh = CreateVehicle(model, co.x, co.y, co.z, GetEntityHeading(PlayerPedId()), true, false)
                        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                    end
                end
            end
        },

        [21] = {
            cat = "veh",
            sep = nil,
            toSub = false,
            label = "Réparer le véhicule proche",
            press = function(closestVeh)
                if closestVeh ~= nil then 
                    SetVehicleEngineHealth(closestVeh, 1000)
                    SetVehicleEngineOn(closestVeh, true, true)
                    SetVehicleFixed(closestVeh)
                    SetVehicleDirtLevel(closestVeh, 0.0)
                end
                TriggerServerEvent("sLogs:reparCar")
            end
        },

        [22] = {
            cat = "veh",
            sep = nil,
            toSub = false,
            label = "Supprimer le véhicule proche",
            press = function(closestVeh)
                if closestVeh ~= nil then DeleteEntity(closestVeh) end
                TriggerServerEvent("sLogs:dvCar")
            end
        },
        
        [23] = {
            cat = "veh",
            sep = nil,
            toSub = false,
            label = "Customiser le véhicule",
            press = function(closestVeh)
                openMenuCustom()
            end
        }
    },

    ranks = {
        [2] = {
            label = "Admin", 
            color = "~r~",
            outfit = 4,
            permissions = {
                1,2,4,5,8,6,3,7, -- Interactions civiles -- ADD : 7,11
                
                9,10,14,15,16,17,18,19,20,21,22, -- Interactions sur soit mêmee

                11,12,13 -- Interactions avec un véhicule
            },
        },

        [1] = {
            label = "Modérateur", 
            color = "~o~",
            outfit = 2,
            permissions = {
                1,2,4,5,8,6,3, -- Interactions civiles -- ADD : 7,11
                
                9,10,14,19,20,21,22, -- Interactions sur soit mêmee

                11,12,13 -- Interactions avec un véhicule
            },
        },
        [0] = {
            label = "Support", 
            color = "~b~",
            outfit = 2,
            permissions = {
                1,2,4,8,10,12, -- Interactions civiles -- ADD : 11
                
                9,11,14,19,20,21, -- Interactions sur soit mêmee
            },
        }
    },

    staffList ={
        --Fondateur 
        ["license:e90bdd1f1c540b392b75d4e8bb25e0a78e83af17"] = 2, -- Tonnio
        ["license:b3f3687e35488dbaef9f0f2d578d204e1dd74887"] = 2, -- SneaX
        ["license:cc1b111908108c3e75ea6348d0cfe5cbe88f625f"] = 2, -- Nelson



    }
}

local function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
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
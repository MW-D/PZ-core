local staffService = false
local NoClip = false
local ShowName = false
local invisible = false
local staffRank = nil
local colorVar = nil
local selected = nil
local isSubMenu = {[false] = { RightLabel = "~b~Éxecuter ~s~→→" },[true] = { RightLabel = "~s~→→" }}
local stringText = {[true] = "~g~ON~s~",[false] = "~r~OFF~s~"}
local staffActions = {}
local possiblesQty = {}
local gamerTags = {}
local items = {}
local qty = 1
local NoClipSpeed =  2.0
local playerItem = {}
local playerWeapon = {}
local playerMoney = {}
local playerBlackMoney = {}
local playerBankMoney = {}

local function init()
    TriggerServerEvent("pz_admin:canUse")
end

local function mug(title, subject, msg)
    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
    ESX.ShowAdvancedNotification(title, subject, msg, mugshotStr, 1)
    UnregisterPedheadshot(mugshot)
end

function playerMarker(player)
    local ped = GetPlayerPed(player)
    local pos = GetEntityCoords(ped)
    DrawMarker(2, pos.x, pos.y, pos.z+1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 170, 0, 1, 2, 0, nil, nil, 0)
end

function getPlayerInvStaff(player)
    playerItem = {}
    playerWeapon = {}
    playerMoney = {}
    playerBlackMoney = {}
    playerBankMoney = {}

    ESX.TriggerServerCallback('pz_admin:getOtherPlayerData', function(data)
        for i=1, #data.accounts, 1 do
            
			if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
				table.insert(playerBlackMoney, {
					amount   = data.accounts[i].money
				})
				break
			elseif data.accounts[i].name == 'bank' and data.accounts[i].money > 0 then
				table.insert(playerBankMoney, {
					label    = ESX.Math.Round(data.accounts[i].money),
					value    = 'bank',
					itemType = 'item_account',
					amount   = data.accounts[i].money
				})

                break
            end
        end
        
		for i=1, #data.weapons, 1 do
			table.insert(playerWeapon, {
				label    = ESX.GetWeaponLabel(data.weapons[i].name),
                value    = data.weapons[i].name,
                right    = data.weapons[i].ammo,
				itemType = 'item_weapon',
				amount   = data.weapons[i].ammo
			})
        end
        
        table.insert(playerMoney, {
            amount   = data.monney
        })
		for i=1, #data.inventory, 1 do
			if data.inventory[i].count > 0 then
				table.insert(playerItem, {
                    label    = data.inventory[i].label,
                    right    = data.inventory[i].count,
					value    = data.inventory[i].name,
					itemType = 'item_standard',
					amount   = data.inventory[i].count
				})
			end
		end
	end, GetPlayerServerId(player))
end

local function getItems()
    TriggerServerEvent("pz_admin:getItems")
end

local function alterMenuVisibility()
    RageUI.Visible(RMenu:Get("pz_admin",'pz_admin_main'), not RageUI.Visible(RMenu:Get("pz_admin",'pz_admin_main')))
end

local function registerMenus()
    RMenu.Add("pz_admin", "pz_admin_main", RageUI.CreateMenu("Menu d'administration","Rang: "..Pz_admin.ranks[staffRank].color..Pz_admin.ranks[staffRank].label))
    RMenu:Get('pz_admin', 'pz_admin_main').Closed = function()end

    RMenu.Add('pz_admin', 'pz_admin_self', RageUI.CreateSubMenu(RMenu:Get('pz_admin', 'pz_admin_main'), "Interactions personnelle", "Interactions avec votre joueur"))
    RMenu:Get('pz_admin', 'pz_admin_self').Closed = function()end

    RMenu.Add('pz_admin', 'pz_admin_players', RageUI.CreateSubMenu(RMenu:Get('pz_admin', 'pz_admin_main'), "Interactions citoyens", "Interactions avec un citoyen"))
    RMenu:Get('pz_admin', 'pz_admin_players').Closed = function()end

    RMenu.Add('pz_admin', 'pz_admin_veh', RageUI.CreateSubMenu(RMenu:Get('pz_admin', 'pz_admin_main'), "Interactions véhicules", "Interactions avec un véhicule proche"))
    RMenu:Get('pz_admin', 'pz_admin_veh').Closed = function()end

    RMenu.Add('pz_admin', 'pz_admin_param', RageUI.CreateSubMenu(RMenu:Get('pz_admin', 'pz_admin_self'), "Interactions personnelle", "Paramètres perso"))
    RMenu:Get('pz_admin', 'pz_admin_param').Closed = function()end

    RMenu.Add('pz_admin', 'pz_admin_players_interact', RageUI.CreateSubMenu(RMenu:Get('pz_admin', 'pz_admin_players'), "Interactions citoyens", "Interagir avec ce joueur"))
    RMenu:Get('pz_admin', 'pz_admin_players_interact').Closed = function()end

    RMenu.Add('pz_admin', 'pz_admin_players_remb', RageUI.CreateSubMenu(RMenu:Get('pz_admin', 'pz_admin_players_interact'), "Interactions citoyens", "Interagir avec ce joueur"))
    RMenu:Get('pz_admin', 'pz_admin_players_remb').Closed = function()end

    RMenu.Add('pz_admin', 'pz_admin_players_inv', RageUI.CreateSubMenu(RMenu:Get('pz_admin', 'pz_admin_players_interact'), "Inventaire", "Voici l'inventaire de ce joueur :"))
    RMenu:Get('pz_admin', 'pz_admin_players_inv').Closed = function()end
end

local function getCamDirection()
	local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(GetPlayerPed(-1))
	local pitch = GetGameplayCamRelativePitch()
	local coords = vector3(-math.sin(heading * math.pi / 180.0), math.cos(heading * math.pi / 180.0), math.sin(pitch * math.pi / 180.0))
	local len = math.sqrt((coords.x * coords.x) + (coords.y * coords.y) + (coords.z * coords.z))

	if len ~= 0 then
		coords = coords / len
	end

	return coords
end

local function initializeNoclip()
    Citizen.CreateThread(function()
        while NoClip and staffService do
            HideHudComponentThisFrame(19)
            local pCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local camCoords = getCamDirection()
            SetEntityVelocity(GetPlayerPed(-1), 0.01, 0.01, 0.01)
            SetEntityCollision(GetPlayerPed(-1), 0, 1)

            if IsControlPressed(0, 32) then
                pCoords = pCoords + (NoClipSpeed * camCoords)
            end

            if IsControlPressed(0, 269) then
                pCoords = pCoords - (NoClipSpeed * camCoords)
            end

            if IsControlPressed(1, 15) then
                NoClipSpeed = NoClipSpeed + 0.5
            end
            if IsControlPressed(1, 16) then
                NoClipSpeed = NoClipSpeed - 0.5
                if NoClipSpeed < 0 then
                    NoClipSpeed = 0
                end
            end
            SetEntityCoordsNoOffset(GetPlayerPed(-1), pCoords, true, true, true)
            Citizen.Wait(0)
        end
    end)
end

local function initializeInvis()
    Citizen.CreateThread(function()
        while invisible and staffService do
            SetEntityVisible(GetPlayerPed(-1), 0, 0)
            NetworkSetEntityInvisibleToNetwork(GetPlayerPed(-1), 1)
            Citizen.Wait(1)
        end
    end)
end


local function initializeNames()
    Citizen.CreateThread(function()
        local pPed = PlayerPedId()
        while ShowName and staffService do
            local pCoords = GetEntityCoords(GetPlayerPed(-1), false)
            for _, v in pairs(GetActivePlayers()) do
                local otherPed = GetPlayerPed(v)
                if otherPed ~= pPed then
                    if #(pCoords - GetEntityCoords(otherPed, false)) < 250.0 then
                        gamerTags[v] = CreateFakeMpGamerTag(otherPed, ('[%s] %s'):format(GetPlayerServerId(v), GetPlayerName(v)), false, false, '', 0)
                        SetMpGamerTagVisibility(gamerTags[v], 4, 1)
                    else
                        RemoveMpGamerTag(gamerTags[v])
                        gamerTags[v] = nil
                    end
                end
                Citizen.Wait(1)
            end
        end
    end)
end

local function initializeText()
    Citizen.CreateThread(function()
        while staffService do 
            Citizen.Wait(1)
            RageUI.Text({message = colorVar.."Mode administration actif~n~~s~Noclip: "..stringText[NoClip].." | Invisible: "..stringText[invisible].." | Noms: "..stringText[ShowName],time_display = 1})
        end
    end)
end


local openM = false
local function initializeThread(rank,license)
    mug("Administration","~b~Statut du mode staff","Votre mode staff est pour le moment désactivé, vous pouvez l'activer au travers du ~o~[F11]")

    staffRank = rank
    colorVar = "~r~"

    for i = 1,100 do 
        table.insert(possiblesQty, tostring(i))
    end

    getItems()
    registerMenus()

    local actualRankPermissions = {}

    for perm,_ in pairs(Pz_admin.functions) do
        actualRankPermissions[perm] = false
    end

    for _,perm in pairs(Pz_admin.ranks[staffRank].permissions) do 
        actualRankPermissions[perm] = true
    end
    if not openM then 
        openM = false
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)
            if IsControlJustPressed(1, 344) then alterMenuVisibility() end
        end
    end)

    Citizen.CreateThread(function()
         while true do 
            Citizen.Wait(800)
            if colorVar == "~r~" then colorVar = "~o~" else colorVar = "~r~" end 
        end 
    end)


    

    Citizen.CreateThread(function()
        while true do
            local menu = false
            RageUI.IsVisible(RMenu:Get("pz_admin",'pz_admin_main'),true,true,true,function()
                menu = true
                RageUI.Checkbox("Mode administration", nil, staffService, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                    staffService = Checked;
                end, function()
                    staffService = true
                    mug("Administration","~b~Statut du mode staff","Vous êtes désormais: ~g~en administration~s~.")
                    TriggerServerEvent("sLogs:initLogON")
                    initializeText()
                end, function()
                    staffService = false
                    NoClip = false
                    ShowName = false
                    invisible = false
                    FreezeEntityPosition(GetPlayerPed(-1), false)
                    SetEntityCollision(GetPlayerPed(-1), 1, 1)
                    SetEntityVisible(GetPlayerPed(-1), 1, 0)
                    NetworkSetEntityInvisibleToNetwork(GetPlayerPed(-1), 0)
                    for _,v in pairs(GetActivePlayers()) do
                        RemoveMpGamerTag(gamerTags[v])
                    end
                    mug("Administration","~b~Statut du mode staff","Vous êtes désormais ~r~hors administration~s~.")
                    TriggerServerEvent("sLogs:initLogOFF")
                    --ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        --TriggerEvent('skinchanger:loadSkin', skin)
                    --end)
                end)

                if staffService then
                    RageUI.Separator(colorVar.."/!\\ Mode administration actif /!\\")
                    RageUI.ButtonWithStyle("Interactions personnelle", "Intéragir avec votre ped", { RightLabel = "→→" }, true, function()
                    end, RMenu:Get('pz_admin', 'pz_admin_self'))
                    RageUI.ButtonWithStyle("Interactions joueurs", "Intéragir avec les joueurs du serveur", { RightLabel = "→→" }, true, function()
                    end, RMenu:Get('pz_admin', 'pz_admin_players'))
                    RageUI.ButtonWithStyle("Interactions véhicules", "Intéragir avec les véhicules du serveur", { RightLabel = "→→" }, true, function()
                    end, RMenu:Get('pz_admin', 'pz_admin_veh'))

                end
            end, function()    
            end, 1)

            RageUI.IsVisible(RMenu:Get("pz_admin",'pz_admin_players'),true,true,true,function()
                menu = true
                for k,v in pairs(GetActivePlayers()) do 

                    RageUI.ButtonWithStyle("["..GetPlayerServerId(v).."] "..GetPlayerName(v), "Intéragir avec ce joueur", { RightLabel = "~b~Intéragir ~s~→→" }, true, function(_,a,s)
                        if a then playerMarker(v) end
                        if s then
                            selected = {c = v, s = GetPlayerServerId(v)}
                        end
                    end, RMenu:Get('pz_admin', 'pz_admin_players_interact'))

                end
            end, function()    
            end, 1)

            RageUI.IsVisible(RMenu:Get("pz_admin",'pz_admin_players_interact'),true,true,true,function()
                menu = true 
                for i = 1,#Pz_admin.functions do
                    if Pz_admin.functions[i].cat == "player" then
                        if Pz_admin.functions[i].sep ~= nil then RageUI.Separator(Pz_admin.functions[i].sep) end
                        RageUI.ButtonWithStyle(Pz_admin.functions[i].label, "Appuyez pour faire cette action", isSubMenu[Pz_admin.functions[i].toSub], actualRankPermissions[i] == true, function(_,a,s)
                            if a then playerMarker(selected.c) end
                            if s then
                                Pz_admin.functions[i].press(selected)
                            end
                        end)
                    end
                end
            end, function()    
            end, 1)

            RageUI.IsVisible(RMenu:Get("pz_admin",'pz_admin_self'),true,true,true,function()
                menu = true
                for i = 1,#Pz_admin.functions do
                    if Pz_admin.functions[i].cat == "self" then
                        if Pz_admin.functions[i].sep ~= nil then RageUI.Separator(Pz_admin.functions[i].sep) end
                        RageUI.ButtonWithStyle(Pz_admin.functions[i].label, "Appuyez pour faire cette action", isSubMenu[Pz_admin.functions[i].toSub], actualRankPermissions[i] == true, function(_,a,s)
                            if s then
                                Pz_admin.functions[i].press()
                            end
                        end)
                    end
                end
            end, function()    
            end, 1)

            RageUI.IsVisible(RMenu:Get("pz_admin",'pz_admin_veh'),true,true,true,function()
                menu = true
                local pos = GetEntityCoords(PlayerPedId())
                local veh, dst = ESX.Game.GetClosestVehicle({x = pos.x, y = pos.y, z = pos.z})
                if dst ~= nil then RageUI.Separator("~s~Distance: ~b~"..math.floor(dst+0.5).."m") end
                for i = 1,#Pz_admin.functions do
                    if Pz_admin.functions[i].cat == "veh" then
                        if Pz_admin.functions[i].sep ~= nil then RageUI.Separator(Pz_admin.functions[i].sep) end
                        RageUI.ButtonWithStyle(Pz_admin.functions[i].label, "Appuyez pour faire cette action", isSubMenu[Pz_admin.functions[i].toSub], actualRankPermissions[i] == true, function(_,a,s)
                            
                            if a then 
                                pos = GetEntityCoords(veh)
                                DrawMarker(2, pos.x, pos.y, pos.z+1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 170, 0, 1, 2, 0, nil, nil, 0)
                            end
                            if s then
                                local co = GetEntityCoords(PlayerPedId())
                                local veh, dst = ESX.Game.GetClosestVehicle({x = co.x, y = co.y, z = co.z})
                                Pz_admin.functions[i].press(veh)
                            end
                        end)
                    end
                end
            end, function()    
            end, 1)
            

            RageUI.IsVisible(RMenu:Get("pz_admin",'pz_admin_players_remb'),true,true,true,function()
                menu = true
                RageUI.Separator("↓ ~b~Paramètrage ~s~↓")

                RageUI.List("Quantité: ~s~", possiblesQty, qty, nil, {}, true, function(Hovered, Active, Selected, Index)
                    qty = Index
                end)
                RageUI.Separator("↓ ~o~Liste d'items ~s~↓")

                for k,v in pairs(items) do
                    RageUI.ButtonWithStyle(v.label, "Appuyez pour donner cet item", { RightLabel = "~b~Donner ~s~→→" }, true, function(_,a,s)
                        if s then
                            TriggerServerEvent("pz_admin:remb", selected.s, v.name, v.label, qty)
                        end
                    end)
                end
            end, function()    
            end, 1)

            RageUI.IsVisible(RMenu:Get("pz_admin",'pz_admin_param'),true,true,true,function()
                menu = true
                RageUI.Checkbox("NoClip", nil, NoClip, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                    NoClip = Checked;
                end, function()
                    FreezeEntityPosition(GetPlayerPed(-1), true)
                    NoClip = true
                    invisible = true
                    initializeNoclip()
                    initializeInvis()
                    TriggerServerEvent("sLogs:noclipON")
                end, function()
                    FreezeEntityPosition(GetPlayerPed(-1), false)
                    SetEntityCollision(GetPlayerPed(-1), 1, 1)
                    SetEntityVisible(GetPlayerPed(-1), 1, 0)
                    NetworkSetEntityInvisibleToNetwork(GetPlayerPed(-1), 0)
                    invisible = false
                    NoClip = false
                    TriggerServerEvent("sLogs:noclipOFF")
                end)

                RageUI.Checkbox("Invisibilité", nil, invisible, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                    invisible = Checked;
                end, function()
                    invisible = true
                    initializeInvis()
                    TriggerServerEvent("sLogs:invisibleON")
                end, function()
                    invisible = false
                    SetEntityVisible(GetPlayerPed(-1), 1, 0)
                    NetworkSetEntityInvisibleToNetwork(GetPlayerPed(-1), 0)
                    TriggerServerEvent("sLogs:invisibleOFF")
                end)

                RageUI.Checkbox("Afficher les noms", nil, ShowName, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                    ShowName = Checked;
                end, function()
                    ShowName = true
                    initializeNames()
                    TriggerServerEvent("sLogs:nomON")
                end, function()
                    ShowName = false
                    for _,v in pairs(GetActivePlayers()) do
                        RemoveMpGamerTag(gamerTags[v])
                    end
                    TriggerServerEvent("sLogs:nomOFF")
                end)
            end, function()    
            end, 1)

            RageUI.IsVisible(RMenu:Get("pz_admin",'pz_admin_players_inv'),true,true,true,function()
                menu = true

                RageUI.Separator("~b~Argent :")
                for k,v in pairs(playerBlackMoney) do
                    RageUI.ButtonWithStyle("Argent sale :", nil, {RightLabel = "~r~"..v.amount.."$"}, true, function(Hovered, Active, Selected)
                        if Active then 
                            playerMarker(selected.c)
                        end
                        if Selected then 
                            local combien = KeyboardInput("Combien voulez vous prendre ?", '', '', 8)
                            if tonumber(combien) > v.amount then
                                ESX.ShowNotification("~r~Quantité invalide")
                            else
                                TriggerServerEvent('pz_core:confiscatePlayerItem', GetPlayerServerId(selected.c), v.itemType, v.value, tonumber(combien))
                                TriggerServerEvent("sLogs:priseinventory", GetPlayerServerId(selected.c), v.itemType, v.value)
                            end
                            RageUI.GoBack()
                        end
                    end)
                end
                for k,v in pairs(playerMoney) do
                    RageUI.ButtonWithStyle("Argent liquide :", nil, {RightLabel = "~r~"..v.amount.."$"}, true, function(Hovered, Active, Selected)
                        if Active then 
                            playerMarker(selected.c)
                        end
                        if Selected then 
                            local combien = KeyboardInput("Combien voulez vous prendre ?", '', '', 8)
                            if tonumber(combien) > v.amount then
                                ESX.ShowNotification("~r~Quantité invalide")
                            else
                                TriggerServerEvent("pz_core:confisquMoney", GetPlayerServerId(selected.c), tonumber(combien))
                            end
                            RageUI.GoBack()
                        end
                    end)
                end
                for k,v in pairs(playerBankMoney) do
                    RageUI.ButtonWithStyle("Argent en banque :", nil, {RightLabel = "~r~"..v.label.."$"}, true, function(Hovered, Active, Selected)
                        if Active then 
                            playerMarker(selected.c)
                        end
                    end)
                end
                RageUI.Separator("~b~Objet :")
                for k,v in pairs(playerItem) do
                    RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "~r~x"..v.right}, true, function(Hovered, Active, Selected)
                        if Active then 
                            playerMarker(selected.c)
                        end
                        if Selected then 
                            local combien2 = KeyboardInput("Combien voulez vous prendre ?", '', '', 8)
                            if tonumber(combien2) > v.amount then
                                ESX.ShowNotification("~r~Quantité invalide")
                            else
                                TriggerServerEvent('pz_core:confiscatePlayerItem', GetPlayerServerId(selected.c), v.itemType, v.value, tonumber(combien2))
                                TriggerServerEvent("sLogs:priseinventory", GetPlayerServerId(selected.c), v.value, tonumber(combien2))
                            end
                            RageUI.GoBack()
                        end
                    end)
                end
                RageUI.Separator("~b~Armes :")
                for k,v in pairs(playerWeapon) do
                    RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "Avec ~r~"..v.right.."~s~ balle(s)"}, true, function(Hovered, Active, Selected)
                        if Active then 
                            playerMarker(selected.c)
                        end
                        if Selected then 
                            TriggerServerEvent('pz_core:confiscatePlayerItem', GetPlayerServerId(selected.c), v.itemType, v.value, v.amount)
                            TriggerServerEvent("sLogs:priseinventory", GetPlayerServerId(selected.c), v.value, v.amount)
                            RageUI.GoBack()
                        end
                    end)
                end
            end, function()    
            end, 1)
            
            Citizen.Wait(0)
            dynamicMenu2 = menu
        end
    end)
end
end

RegisterNetEvent("pz_admin:remb")
AddEventHandler("pz_admin:remb", function(id)
    if colorVar == nil then return end
    RageUI.CloseAll()
    Citizen.Wait(100)
    RageUI.Visible(RMenu:Get("pz_admin",'pz_admin_players_remb'), not RageUI.Visible(RMenu:Get("pz_admin",'pz_admin_players_remb')))
end)

RegisterNetEvent("pz_admin:inv")
AddEventHandler("pz_admin:inv", function(target)
    if colorVar == nil then return end
    RageUI.CloseAll()
    Citizen.Wait(100)
    getPlayerInvStaff(target)
    RageUI.Visible(RMenu:Get("pz_admin",'pz_admin_players_inv'), not RageUI.Visible(RMenu:Get("pz_admin",'pz_admin_players_inv')))
end)


RegisterNetEvent("pz_admin:teleport")
AddEventHandler("pz_admin:teleport", function(pos)
    SetEntityCoords(PlayerPedId(), pos.x, pos.y, pos.z, false, false, false, false)
end)

RegisterNetEvent("pz_admin:getItems")
AddEventHandler("pz_admin:getItems", function(table)
    items = table
end)

RegisterNetEvent("pz_admin:canUse")
AddEventHandler("pz_admin:canUse", function(ok, rank, license)
    if ok then initializeThread(rank,license) end
end)

RegisterNetEvent("pz_admin:options")
AddEventHandler("pz_admin:options", function()
    if colorVar == nil then return end
    RageUI.CloseAll()
    Citizen.Wait(100)
    RageUI.Visible(RMenu:Get("pz_admin",'pz_admin_param'), not RageUI.Visible(RMenu:Get("pz_admin",'pz_admin_param')))
end)

RegisterNetEvent("TuCheatMek")
AddEventHandler("TuCheatMek", function(reason, id)
    TriggerServerEvent('BanSql:ICheat', reason, id)
end)

pzCore.staff = {}
pzCore.staff.init = init
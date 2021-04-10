local items = {}

local function getLicense(source)
    local license = nil
    for k,v in pairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        end
    end
    return license
end

local function canUse(source)
    local license = getLicense(source)
    if license == nil then 
        return 
    end
    return Pz_admin.staffList[license] ~= nil
end

local function getDate()
    local date = os.date('*t')
	if date.day < 10 then date.day = '0' .. tostring(date.day) end
	if date.month < 10 then date.month = '0' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
    if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

    return(date.day ..'/'.. date.month ..'/'.. date.year ..' - '.. date.hour ..':'.. date.min ..':'.. date.sec)
end

local function getRank(source)
    local license = getLicense(source)
    if license == nil then return end
    return Pz_admin.staffList[license], license
end

local function getItems()
    MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
        return result
    end)
end

RegisterNetEvent("pz_admin:message")
AddEventHandler("pz_admin:message", function(id,mess)
    TriggerClientEvent("esx:showNotification", id, "~r~Message du staff : ~s~"..mess)
end)

RegisterNetEvent("pz_admin:bring")
AddEventHandler("pz_admin:bring", function(id,pos)
    TriggerClientEvent("pz_admin:teleport", id, pos)

end)

RegisterNetEvent("pz_admin:remb")
AddEventHandler("pz_admin:remb", function(id,item,label,qty)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    xPlayer.addInventoryItem(item,qty)

end)

RegisterNetEvent("pz_admin:revive")
AddEventHandler("pz_admin:revive", function(id)
    TriggerClientEvent("ambulance:revive", id)
end)

--[[RegisterNetEvent("pz_admin:ban")
AddEventHandler("pz_admin:ban", function(initial,id,reason,time)
    local _src = source
    local n = GetPlayerName(_src)
    time = tonumber(time)
    local license,identifier,liveid,xblid,discord,playerip
    local targetplayername = GetPlayerName(id)
        for k,v in ipairs(GetPlayerIdentifiers(id))do
            if string.sub(v, 1, string.len("license:")) == "license:" then
                license = v
            elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
                identifier = v
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                liveid = v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                xblid  = v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                discord = v
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                playerip = v
            end
        end
    if time > 0 then
        --TriggerEvent("fivemban", initial,license,identifier,liveid,xblid,discord,playerip,targetplayername,n,time,reason,0) --Timed ban here
        --ExecuteCommand("sqlban "..id.." "..time.." "..reason)
        TriggerClientEvent("pz_admin:ban", initial, time, reason)
        DropPlayer(id, "Vous avez été banni(e) temporairement: | Raison : "..reason.." | Par "..n.." | Date du ban : "..getDate().." | Durée du ban : "..time.. " secondes")
    else
        --TriggerEvent("fivemban", initial,license,identifier,liveid,xblid,discord,playerip,targetplayername,n,time,reason,1)
        --ExecuteCommand("sqlban "..id.." "..time.." "..reason)
        TriggerClientEvent("pz_admin:banPerm", initial, time, reason)
        DropPlayer(id, "Vous avez été banni(e) à vie: | Date du ban : "..getDate().." | Raison : "..reason.." | Banni(e) par "..n)
    end
end)]]

RegisterNetEvent("pz_admin:kick")
AddEventHandler("pz_admin:kick", function(id,mess)
    local _src = source
    DropPlayer(id, "Vous avez été expulsé: \""..mess.."\", par "..GetPlayerName(_src))
end)

RegisterNetEvent("pz_admin:getItems")
AddEventHandler("pz_admin:getItems", function()
    local _src = source
    TriggerClientEvent("pz_admin:getItems", _src, items)
end)

RegisterNetEvent("pz_admin:canUse")
AddEventHandler("pz_admin:canUse", function()
    local _src = source
    local state,license = canUse(_src)
    local rank = -1
    if state then rank = getRank(_src) end
    TriggerClientEvent("pz_admin:canUse", _src, state, rank, license)
end)

Citizen.CreateThread(function()
    MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
        items = result
    end)
end)

RegisterNetEvent("pz_admin:giveweapon")
AddEventHandler("pz_admin:giveweapon", function(id, weaponName)
    local xPlayer = ESX.GetPlayerFromId(id)
    xPlayer.addWeapon(weaponName, 999)
end)

RegisterServerEvent('pz_admin:giveMoney')
AddEventHandler('pz_admin:giveMoney', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "user" then
        TriggerEvent("BanSql:ICheat", "Le cheat n'est pas autorisé sur Vice-Blue.",_source)
    else
        xPlayer.addMoney(money)
        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~GIVE de ' .. money .. '$')
    end
end)

RegisterServerEvent('pz_admin:giveMoneyBank')
AddEventHandler('pz_admin:giveMoneyBank', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "user" then
        TriggerEvent("BanSql:ICheat", "Le cheat n'est pas autorisé sur Vice-Blue.",_source)
    else
    xPlayer.addAccountMoney('bank', money)
	TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~GIVE de ' .. money .. '$ en baque')
    end
end)

RegisterServerEvent('pz_admin:giveMoneySale')
AddEventHandler('pz_admin:giveMoneySale', function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "user" then
        TriggerEvent("BanSql:ICheat", "Le cheat n'est pas autorisé sur Vice-Blue.",_source)
    else
    xPlayer.addAccountMoney('black_money', money)
    TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~GIVE de ' .. money .. '$ en argent sale')
    end
end)

RegisterServerEvent('pz_admin:wipe')
AddEventHandler('pz_admin:wipe', function(target)
    local xPlayer = ESX.GetPlayerFromId(target)
    local steam = xPlayer.getIdentifier()

    DropPlayer(target, "Vous vous êtes fait wipe !")

    MySQL.Async.execute([[
		DELETE FROM billing WHERE identifier = @wipeID;
		DELETE FROM billing WHERE sender = @wipeID;
		DELETE FROM open_car WHERE identifier = @wipeID;
		DELETE FROM owned_vehicles WHERE owner = @wipeID;
        DELETE FROM user_accounts WHERE identifier = @wipeID;
        DELETE FROM user_accessories WHERE identifier = @wipeID;
		DELETE FROM phone_users_contacts WHERE identifier = @wipeID;
		DELETE FROM user_inventory WHERE identifier = @wipeID;
        DELETE FROM user_licenses WHERE owner = @wipeID;
        DELETE FROM user_tenue WHERE identifier = @wipeID;
 		DELETE FROM users WHERE identifier = @wipeID;	]], {
		['@wipeID'] = steam,
    }, function(rowsChanged)
        print("^5Wipe effectuer ! SteamID :"..steam.."^0")
    end)
    --DELETE FROM owned_properties WHERE owner = @wipeID;
    --DELETE FROM playerstattoos WHERE identifier = @wipeID;
    --DELETE FROM owned_boats WHERE owner = @wipeID;
end)

RegisterServerEvent('pz_admin:setJobPlayer')
AddEventHandler('pz_admin:setJobPlayer', function(id, job, grade)
    local xPlayer = ESX.GetPlayerFromId(id)
    xPlayer.setJob(job, grade)
end)

RegisterServerEvent('pz_admin:setJob2Player')
AddEventHandler('pz_admin:setJob2Player', function(id, job2, grade)
	local xPlayer = ESX.GetPlayerFromId(id)
    xPlayer.setJob2(job2, grade)	
end)

ESX.RegisterServerCallback('pz_admin:getOtherPlayerData', function(source, cb, target, notify)
	local xPlayer = ESX.GetPlayerFromId(target)


	if xPlayer then
		local data = {
			name = xPlayer.getName(),
			job = xPlayer.job.label,
			grade = xPlayer.job.grade_label,
			inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            monney = xPlayer.getMoney(),
			weapons = xPlayer.getLoadout()
		}

		cb(data)
    end
end)

RegisterNetEvent('pz_core:confiscatePlayerItem')
AddEventHandler('pz_core:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		if targetItem.count > 0 and targetItem.count <= amount then
			targetXPlayer.removeInventoryItem(itemName, amount)
			sourceXPlayer.addInventoryItem   (itemName, amount)
            TriggerClientEvent("esx:showNotification", source, "Vous avez pris ~b~"..amount..' '..sourceItem.label.."~s~.")
            TriggerClientEvent("esx:showNotification", target, "Un staff vous a pris ~b~"..amount..' '..sourceItem.label.."~s~.")
		else
            TriggerClientEvent("esx:showNotification", source, "~r~Quantité invalide")
        end
        
	elseif itemType == 'item_account' then
		targetXPlayer.removeAccountMoney(itemName, amount)
        sourceXPlayer.addAccountMoney   (itemName, amount)
        
        TriggerClientEvent("esx:showNotification", source, "Vous avez pris ~b~"..amount.." d'argent sale~s~.")
        TriggerClientEvent("esx:showNotification", target, "Un staff vous a pris ~b~"..amount.." d'argent sale ~s~.")
        
	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		targetXPlayer.removeWeapon(itemName, amount)
		sourceXPlayer.addWeapon   (itemName, amount)

        TriggerClientEvent("esx:showNotification", source, "Vous avez pris ~b~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~b~"..amount.."~s~ balle(s).")
        TriggerClientEvent("esx:showNotification", target, "Un staff vous a pris ~b~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~b~"..amount.."~s~ balle(s).")
	end
end)

RegisterNetEvent('pz_core:confisquMoney')
AddEventHandler('pz_core:confisquMoney', function(target, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	targetXPlayer.removeMoney(amount)
    sourceXPlayer.addMoney(amount)
    
    TriggerClientEvent("esx:showNotification", source, "Vous avez pris ~b~"..amount.."$~s~ d'argent liquide.")
    TriggerClientEvent("esx:showNotification", target, "Un staff vous a pris ~b~"..amount.."$~s~ d'argent liquide.")    
end)
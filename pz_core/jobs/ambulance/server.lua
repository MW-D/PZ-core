local deadPlayers = {}

local function getDate()
    local date = os.date('*t')
	if date.day < 10 then date.day = '0' .. tostring(date.day) end
	if date.month < 10 then date.month = '0' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
    if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

    return(date.day ..'/'.. date.month ..'/'.. date.year ..' - '.. date.hour ..':'.. date.min ..':'.. date.sec)
end

ESX.RegisterServerCallback('ambulance:afficherapel', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local keys = {}

    MySQL.Async.fetchAll('SELECT * FROM appel_ems', {}, 
		function(data)

		for _,v in pairs(data) do
			local coordtable = json.decode(v.coord)
			table.insert(keys, {
				name = v.name,
				src = source,
                coord = coordtable,
				date = v.date,
				state = v.state
            })
		end
        cb(keys)

    end)
end)

RegisterServerEvent('ambulance:ajoutappel')
AddEventHandler('ambulance:ajoutappel', function(coord)
	local name = GetPlayerName(source)
	local coordsql = json.encode(coord)
    MySQL.Async.execute('INSERT INTO appel_ems (name, coord, date, state) VALUES (@name, @coord, @date, @state)', {
        ['@name'] = name,
        ['@coord'] = coordsql,
		['@date'] = getDate(),
		['@state'] = 0
    })
end)

RegisterServerEvent('ambulance:suppappel')
AddEventHandler('ambulance:suppappel', function(name)
    MySQL.Async.execute('DELETE FROM appel_ems WHERE name = @name', {
        ['@name'] = name
	})
end)

RegisterNetEvent('ambulance:updtateStatu')
AddEventHandler('ambulance:updtateStatu', function(name, state)
	local state = state

	MySQL.Async.execute("UPDATE appel_ems SET `state`=@state WHERE name=@name",{
		['@state'] = state,
		['@name'] = name
	})
end)


RegisterNetEvent("ambulance:sendMess")
AddEventHandler("ambulance:sendMess", function(id, mess)
    TriggerClientEvent("esx:showNotification", id, "~r~Message d'un EMS : ~s~"..mess)
end)

ESX.RegisterServerCallback('ambulance:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count
	cb(quantity)
end)

ESX.RegisterServerCallback('ambulance:getDeathStatus', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(isDead)
				
		if isDead then
			print(isDead)
		end

		cb(isDead)
	end)
end)

RegisterNetEvent('ambulance:setDeathStatus')
AddEventHandler('ambulance:setDeathStatus', function(isDead)
	local xPlayer = ESX.GetPlayerFromId(source)

	if type(isDead) == 'boolean' then
		MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
			['@isDead'] = isDead
		})
	end
end)

RegisterNetEvent('ambulance:removeItem')
AddEventHandler('ambulance:removeItem', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		TriggerClientEvent('esx:showNotification', xPlayer, "Vous avez utilisé un ~g~bandage~s~.", "", 1)
	elseif item == 'medikit' then
		TriggerClientEvent('esx:showNotification', xPlayer, "Vous avez utilisé un ~g~kit de réanimation~s~.", "", 1)
	end
end)

RegisterNetEvent("pz_core:givePharamacie")
AddEventHandler("pz_core:givePharamacie", function(item)
  local _src = source
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.job.name == 'ambulance' then
	xPlayer.addInventoryItem(item,1)
  end
end)

RegisterNetEvent('ambulance:heal')
AddEventHandler('ambulance:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('ambulance:heal', target, type)
	end
end)

RegisterNetEvent('ambulance:revive')
AddEventHandler('ambulance:revive', function(playerId)
	  local xPlayer = ESX.GetPlayerFromId(source)

	  if xPlayer and xPlayer.job.name == 'ambulance' then
		  local xTarget = ESX.GetPlayerFromId(playerId)

		  if xTarget then
			if deadPlayers[playerId] then
				xTarget.TriggerEvent('ambulance:revive')
				deadPlayers[playerId] = nil
			else
				TriggerClientEvent('esx:showNotification', source, "~g~La réanimation à fonctionné.\nPenser à lui dire de faire attention !", "", 1)
			end
		else
			TriggerClientEvent('esx:showNotification', source, "~r~Ce joueur n\'est plus en ligne.", "", 1)
		end
	  end
end)

RegisterServerEvent('ambulance:revive')
AddEventHandler('ambulance:revive', function(target)
    TriggerClientEvent('ambulance:revive', target)
end)


AddEventHandler('onMySQLReady', function()
	MySQL.Sync.execute("TRUNCATE TABLE appel_ems", {})
end)

RegisterServerEvent('sAmbulance:priseDeLapelleNotif')
AddEventHandler('sAmbulance:priseDeLapelleNotif', function(target)
	local playerName = GetPlayerName(source)
	local xTarget = ESX.GetPlayerFromId(target)
	TriggerClientEvent('esx:showNotification', target, "~g~L'ambulancier "..playerName.." viens de prendre votre appel.", "", 1)
end)

TriggerEvent('es:addGroupCommand', 'revive', 'superadmon', function(source, args, user)
	if args[1] ~= nil then
		TriggerClientEvent('ambulance:revive', tonumber(args[1]))
	else
		TriggerClientEvent('ambulance:revive', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)
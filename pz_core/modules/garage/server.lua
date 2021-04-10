function getPlayerVehicles(identifier)
	local vehicles = {}
	local data = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier",{['@identifier'] = identifier})	
	for _,v in pairs(data) do
		local vehicle = json.decode(v.vehicle)
		table.insert(vehicles, {id = v.id, plate = vehicle.plate})
	end
	return vehicles
end

ESX.RegisterServerCallback('garage:getVehicles', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier",{
        ['@identifier'] = xPlayer.getIdentifier()
	}, function(data) 

		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(vehicules, {vehicle = vehicle, state = v.stored})
		end
		cb(vehicules)
	end)
end)

ESX.RegisterServerCallback('garage:stockv',function(source,cb, vehicleProps)
	local isFound = false
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = getPlayerVehicles(xPlayer.getIdentifier())
	local plate = vehicleProps.plate

	
		for _,v in pairs(vehicules) do
			if(plate == v.plate)then
				local idveh = v.id
				local vehprop = json.encode(vehicleProps)
				MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle=@vehprop WHERE plate=@plate",{
					['@vehprop'] = vehprop, 
					['@plate'] = plate
				})
				isFound = true
				break
			end		
		end
		cb(isFound)
end)

RegisterServerEvent('garage:modifystate')
AddEventHandler('garage:modifystate', function(plate, stored)
	local stored = stored
	MySQL.Async.execute("UPDATE owned_vehicles SET `stored` =@stored WHERE plate=@plate",{
		['@stored'] = stored,
		['@plate'] = plate
	})
end)

RegisterNetEvent("garage:buy")
AddEventHandler("garage:buy", function(price)
    local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	
	if xPlayer.getMoney() >= price then 
		xPlayer.removeMoney(price)
		TriggerClientEvent('esx:showNotification', source, "Vous avez payer : ~r~"..price.."$~s~.", "", 1)
	else
		TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez d'argent.", "", 1)
	end
end)

--Debug
AddEventHandler('eden_garage:debug', function(var)
	print(to_string(var))
end)

function table_print (tt, indent, done)
  done = done or {}
  indent = indent or 0
  if type(tt) == "table" then
    local sb = {}
    for key, value in pairs (tt) do
      table.insert(sb, string.rep (" ", indent)) -- indent it
      if type (value) == "table" and not done [value] then
        done [value] = true
        table.insert(sb, "{\n");
        table.insert(sb, table_print (value, indent + 2, done))
        table.insert(sb, string.rep (" ", indent)) -- indent it
        table.insert(sb, "}\n");
      elseif "number" == type(key) then
        table.insert(sb, string.format("\"%s\"\n", tostring(value)))
      else
        table.insert(sb, string.format(
            "%s = \"%s\"\n", tostring (key), tostring(value)))
       end
    end
    return table.concat(sb)
  else
    return tt .. "\n"
  end
end

function to_string( tbl )
    if  "nil"       == type( tbl ) then
        return tostring(nil)
    elseif  "table" == type( tbl ) then
        return table_print(tbl)
    elseif  "string" == type( tbl ) then
        return tbl
    else
        return tostring(tbl)
    end
end
--Fin Debug

MySQL.ready(function()
	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = 0 WHERE `stored` = @stored', {
		['@stored'] = 1
	}, function(rowsChanged)
		if rowsChanged > 0 then
			print("Garage reset !")
		end
	end)
end)

AddEventHandler('esx:playerLoaded', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = 0 WHERE `owner` = @identifier', {
		['@identifier'] = xPlayer.getIdentifier()
	}, function(rowsChanged)
		if rowsChanged > 0 then
			print("This vehicle of "..xPlayer.getIdentifier()..' a good reset.')
		end
	end)
end)
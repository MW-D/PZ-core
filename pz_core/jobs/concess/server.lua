local societyName = 'society_concess'

ESX.RegisterServerCallback('esx_vehicleshop:checkMoney', function(source, cb, price)
	TriggerEvent('esx_addonaccount:getSharedAccount', societyName, function(account)
        if account.money >= price then
            account.removeMoney(price)
            TriggerClientEvent('esx:showNotification', source, "Votre entreprise à payé ~g~"..price.."$~s~.", "", 1)
            cb(true)
        else
            TriggerClientEvent('esx:showNotification', source, "~r~L'entreprise n'a pas assez d'argent.", "", 1)
            cb(false)
        end
    end)
end)

ESX.RegisterServerCallback('esx_vehicleshop:afficherVeh', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local vehConcess = {}

    MySQL.Async.fetchAll('SELECT * FROM veh_concess', {}, 
		function(data)

		for _,v in pairs(data) do
			table.insert(vehConcess, {
                id = v.id,
                plate = v.plate,
                price = v.price,
                model = v.veh
            })
		end
        cb(vehConcess)
    end)
end)

RegisterServerEvent('esx_vehicleshop:rendreVehicule')
AddEventHandler('esx_vehicleshop:rendreVehicule', function(price)
    TriggerEvent('esx_addonaccount:getSharedAccount', societyName, function(account)
        account.addMoney(price)
    end)
end)

RegisterServerEvent('esx_vehicleshop:ajoutVeh')
AddEventHandler('esx_vehicleshop:ajoutVeh', function(plate, price, veh)
    local vehCode = json.encode(veh)
    MySQL.Async.execute('INSERT INTO veh_concess (plate, price, veh) VALUES (@plate, @price, @veh)', {
        ['@plate'] = plate,
        ['@price'] = price,
        ['@veh'] = veh
    })
end)

RegisterServerEvent('esx_vehicleshop:suppVeh')
AddEventHandler('esx_vehicleshop:suppVeh', function(plate)
    MySQL.Async.execute('DELETE FROM veh_concess WHERE plate = @plate', {
        ['@plate'] = plate
    })
end)

RegisterNetEvent('esx_vehicleshop:setVehicleOwnedPlayerId')
AddEventHandler('esx_vehicleshop:setVehicleOwnedPlayerId', function(playerId, plate, vehicleProps)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(playerId)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
        ['@owner']   = xTarget.identifier,
        ['@plate']   = plate,
        ['@vehicle'] = json.encode(vehicleProps)
    })
end)

RegisterNetEvent("pz_core:concess_state")
AddEventHandler("pz_core:concess_state", function(open)
    if open then
        TriggerClientEvent("esx:showNotification", -1, "~b~Concessionnaire~s~ \nLe ~p~concessionnaire~s~ est désormais ~g~ouvert ~s~!")
    else
        TriggerClientEvent("esx:showNotification", -1, "~b~Concessionnaire~s~ \nLe ~p~concessionnaire~s~ est désormais ~r~fermé ~s~!")
    end
end)

RegisterNetEvent("pz_core:concess_stateperso")
AddEventHandler("pz_core:concess_stateperso", function(text)
    TriggerClientEvent("esx:showNotification", -1, "~b~Concessionnaire~s~ \n"..text)
end)
RegisterNetEvent("location:buy")
AddEventHandler("location:buy", function(price, veh)
    local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	
	if xPlayer.getMoney() >= price then 
		xPlayer.removeMoney(price)
        TriggerClientEvent('esx:showNotification', source, "Vous avez payer : ~r~"..price.."$~s~.", "", 1)
        TriggerClientEvent('esx:showNotification', source, "Tu en est ~b~responsable~s~ ne te fait pas attraper par la police !", "", 1)
        TriggerClientEvent('esx:showNotification', source, "Tien ton véhicule ! Bonne route !", "", 1)
        TriggerClientEvent('location:spawnVeh', veh)
	else
		TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez d'argent.", "", 1)
	end
end)
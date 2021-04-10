RegisterNetEvent("pz_core:taxi_state")
AddEventHandler("pz_core:taxi_state", function(open)
    if open then
        TriggerClientEvent("esx:showNotification", -1, "~s~Le taxi est désormais ~g~ouvert ~s~!")
    else
        TriggerClientEvent("esx:showNotification", -1, "~s~Le taxi est désormais ~r~fermé ~s~!")
    end
end)

local lastPlayerSuccess = {}
RegisterNetEvent('esx_taxijob:success')
AddEventHandler('esx_taxijob:success', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local timeNow = os.clock()

	if xPlayer.job.name == 'taxi' then
		if not lastPlayerSuccess[source] or timeNow - lastPlayerSuccess[source] > 5 then
			lastPlayerSuccess[source] = timeNow

			math.randomseed(os.time())
			local total = math.random(300, 600)

			if xPlayer.job.grade >= 3 then
				total = total * 2
			end

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_taxi', function(account)
				if account then
					local playerMoney  = ESX.Math.Round(total / 100 * 30)
					local societyMoney = ESX.Math.Round(total / 100 * 70)

					xPlayer.addMoney(playerMoney)
					account.addMoney(societyMoney)

					xPlayer.showNotification("Votre societé à gagné ~b~"..societyMoney..", ~s~vous avez gagné ~b~"..playerMoney)
				else
					xPlayer.addMoney(total)
					xPlayer.showNotification("Vous avez gagné ~b~"..total)
				end
			end)
		end
	else
		print(('[esx_taxijob] [^3WARNING^7] %s attempted to trigger success (cheating)'):format(xPlayer.identifier))
	end
end)
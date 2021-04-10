local PlayersTransforming = {}
local PlayersSelling = {}
local PlayersHarvesting = {}
local jusr = 1

TriggerEvent('esx_society:registerSociety', 'brasseur', 'brasseur', 'society_brasseur', 'society_brasseur', 'society_brasseur', {type = 'private'})



local function Harvest(source, zone)
	if PlayersHarvesting[source] == true then
		local xPlayer = ESX.GetPlayerFromId(source)

		if zone == "RaisinFarm" then

			local itemQuantity = xPlayer.getInventoryItem('houblon').count
			if itemQuantity >= 100 then
				TriggerClientEvent("stoptallbrasseur",source)
				TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas de place")
			else
				SetTimeout(1800, function()
					TriggerClientEvent('esx:showNotification', source, "Appuyez sur ~b~X ~w~pour annuler l'action")
					xPlayer.addInventoryItem('houblon', 1)
					Harvest(source, zone)
				end)
			end
		end
	end
end

RegisterServerEvent('esx:brasseurjob:stopHarvest')
AddEventHandler('esx:brasseurjob:stopHarvest', function()
	local _source = source
	PlayersHarvesting[_source] = false
	PlayersTransforming[_source] = false
	PlayersSelling[_source] = false
end)

RegisterServerEvent('esx:brasseurjob:startHarvest')
AddEventHandler('esx:brasseurjob:startHarvest', function(zone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent("RemoveMarkerbrasseur",_source)
	TriggerClientEvent('esx:showNotification', _source,"Vous êtes en train de récolté des houblon")
	TriggerClientEvent("StartRecolteAnimation", _source)
	PlayersHarvesting[_source] = true
	Harvest(_source, zone)
end)

local function Transform(source, zone)
	if PlayersTransforming[source] == true then
		local xPlayer = ESX.GetPlayerFromId(source)

		if zone == "TraitementVin" then
			local itemQuantity = xPlayer.getInventoryItem('houblon').count

			if itemQuantity >= 100 then
				TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas de place")
				TriggerClientEvent("stoptallbrasseur",source)
			else

				local itemQuantity = xPlayer.getInventoryItem('houblon').count
				
				if itemQuantity <= 0 then
					TriggerClientEvent("stoptallbrasseur",source)
					TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas de houblon")
					return
				else
					SetTimeout(3000, function()
						xPlayer.removeInventoryItem('houblon', 1)
						xPlayer.addInventoryItem('blonde', 1)		
						TriggerClientEvent('esx:showNotification', source, "Appuyez sur ~b~X ~w~pour annuler l'action")			
						Transform(source, zone)
					end)
				end
			end
		end
	end	
end


RegisterServerEvent('brasseurjob:startTrans')
AddEventHandler('brasseurjob:startTrans', function(zone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent("RemoveMarkerbrasseur",_source)
	TriggerClientEvent('esx:showNotification', _source,"Vous êtes en train de traité vos houblon")
	TriggerClientEvent("StartRecolteAnimation", _source)
	PlayersTransforming[_source] = true
	Transform(_source, zone)
end)



local function Sell(source, zone)
	if PlayersSelling[source] == true then
		local xPlayer = ESX.GetPlayerFromId(source)
		if zone == 'SellFarm' then
			if xPlayer.getInventoryItem('blonde').count <= 0 then
				jusr = 0
			else
				jusr = 1
			end

			if jusr == 0 then
				TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas de produit a vendre")
				TriggerClientEvent("stoptallbrasseur",source)

				return
			elseif xPlayer.getInventoryItem('blonde').count <= 0 then
				TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas de produit a vendre")
				TriggerClientEvent("stoptallbrasseur",source)
				jusr = 0
				return
			else
				if (jusr == 1) then
					SetTimeout(3000, function()
						TriggerClientEvent('esx:showNotification', source, "Appuyez sur ~b~X ~w~pour annuler l'action")
						local money = math.random(50, 80)
						xPlayer.removeInventoryItem('blonde', 1)
						local societyAccount = nil
						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_brasseur', function(account)
							societyAccount = account
						end)

						if societyAccount ~= nil then
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, "Votre société à gagné ~g~"..money.."$")
						end

						Sell(source,zone)
					end)
				end
			end
		end
	end
end

RegisterServerEvent('esx:brasseurjob:startVente')
AddEventHandler('esx:brasseurjob:startVente', function(zone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if PlayersSelling[_source] == false then
		PlayersSelling[_source] = false
	else
		PlayersSelling[_source] = true
		TriggerClientEvent("RemoveMarkerbrasseur",_source)
		TriggerClientEvent('esx:showNotification', _source,"Vous êtes en train de vendre vos bierre")
		TriggerClientEvent("StartRecolteAnimation", _source)
		Sell(_source, zone)
	end
end)
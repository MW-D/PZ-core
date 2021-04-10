local societyName = 'society_mecano'

ESX.RegisterServerCallback('mecano:buyCustom', function(source, cb, price)
	TriggerEvent('esx_addonaccount:getSharedAccount', societyName, function(account)
        if account.money >= price then
            account.removeMoney(price)
            TriggerClientEvent('esx:showNotification', source, "Votre entreprise à payé ~g~"..price.."$~s~.", "", 1)
        else
            TriggerClientEvent('esx:showNotification', source, "~r~L'entreprise n'a pas assez d'argent.", "", 1)
        end

    end)
end)
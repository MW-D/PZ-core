local jobs = {}
local saveID = 0

TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})
TriggerEvent('esx_society:registerSociety', 'concess', 'Concess', 'society_concess', 'society_concess', 'society_concess', {type = 'public'})
TriggerEvent('esx_society:registerSociety', 'mecano', 'Mecano', 'society_mecano', 'society_mecano', 'society_mecano', {type = 'public'})
TriggerEvent('esx_society:registerSociety', 'police', 'Police', 'society_police', 'society_police', 'society_police', {type = 'public'})
TriggerEvent('esx_society:registerSociety', 'taxi', 'Taxi', 'society_taxi', 'society_taxi', 'society_taxi', {type = 'public'})
TriggerEvent('esx_society:registerSociety', 'unicorn', 'Unicorn', 'society_unicorn', 'society_unicorn', 'society_unicorn', {type = 'public'})

TriggerEvent('esx_phone:registerNumber', 'ambulance', "Alerte Ambulance", true, true)
TriggerEvent('esx_phone:registerNumber', 'mecano', "Custom mécano", true, true)
TriggerEvent('esx_phone:registerNumber', 'police', "Alerte police", true, true)
TriggerEvent('esx_phone:registerNumber', 'taxi', "Client taxi", true, true)

local function initializeSavingScheduler()
    Citizen.CreateThread(function()
        pzCore.trace("Save scheduler initialized")
        while true do
            Citizen.Wait(60000)
            pzCore.jobs.func.saveAll()
        end
    end)
end

local function loadItems()
    local wait = true
    MySQL.Async.fetchAll('SELECT * FROM jobs', {}, function(result)
        for k,v in pairs(result) do
            table.insert(jobs, v)
        end
        pzCore.trace("Found "..#result.." jobs in database, adding them to store table..")
        wait = false
    end)

    while wait do Citizen.Wait(1) end
    wait = true
    for k,v in pairs(jobs) do
        wait = true
        MySQL.Async.fetchAll('SELECT * FROM entreprises_data WHERE label = @a', {['a'] = v.name}, function(result)
            if result[1] then
                pzCore.jobs.items[v.name] = json.decode(result[1].items)
                wait = false
            else
                pzCore.jobs.items[v.name] = {}
                MySQL.Async.execute('INSERT INTO entreprises_data (label,items) VALUES (@a,@b)', {['a'] = v.name, ['b'] = json.encode({})}, function(affectedRows)
                    wait = false
                end)
            end
            
        end)
        while wait do Citizen.Wait(1) end
    end
    pzCore.trace("Finished loading jobs data")
    initializeSavingScheduler()
    pzCore.trace("Save scheduler sould be active")
end

local function getItems(job)
    return pzCore.jobs.items[job]
end

local function addItem(job, item, qty)
    if pzCore.jobs.items[job][item] == nil then pzCore.jobs.items[job][item] = qty else pzCore.jobs.items[job][item] = pzCore.jobs.items[job][item] + qty end
end

local function removeItem(job, item, qty)
    if pzCore.jobs.items[job][item] == nil or qty > pzCore.jobs.items[job][item] or pzCore.jobs.items[job][item] - qty < 0 then return end
    pzCore.jobs.items[job][item] = pzCore.jobs.items[job][item] - qty
end

--if qty > pzCore.jobs.items[job][item] then return end
--if pzCore.jobs.items[job][item] - qty < 0 then return end

local function saveAll()
    saveID = saveID + 1
    local wait
    for k,v in pairs(jobs) do
        wait = true
        MySQL.Async.fetchAll('UPDATE entreprises_data SET items=@a WHERE label=@b', {['a'] = json.encode(pzCore.jobs.items[v.name]), ['b'] = v.name}, function(result)
            local total = 0
            for k,v in pairs(pzCore.jobs.items[v.name]) do total = total + 1 end
            wait = false
        end)
        while wait do Citizen.Wait(1) end
    end
    pzCore.trace("Saving "..#jobs.." jobs inventory to DB (SaveID:"..saveID..")")
end

RegisterNetEvent("pz_core:openEntrepriseInventory")
AddEventHandler("pz_core:openEntrepriseInventory", function(inventory,from)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local playerItems = xPlayer.getInventory()
    local items = {}
    for k,v in pairs(pzCore.jobs.items[inventory]) do
        items[k] = {count = v, label = ESX.GetItemLabel(k), name = k}
    end
    TriggerClientEvent("pz_core:getInventoryData", _src , items,playerItems,from,inventory)
end)



RegisterNetEvent("pz_core:take")
AddEventHandler("pz_core:take", function(name,qty,job)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    xPlayer.addInventoryItem(name, qty)
    removeItem(job,name,qty)
    TriggerClientEvent("pz_core:callbackTake", _src, name, qty, qty, xPlayer.getInventoryItem(name))
end)

RegisterNetEvent("pz_core:deposit")
AddEventHandler("pz_core:deposit", function(name,qty,job)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local final = xPlayer.getInventoryItem(name).count - qty
    local toRemove = qty
    if xPlayer.getInventoryItem(name).count < qty then return end
    xPlayer.removeInventoryItem(name, qty)
    addItem(job,name,qty)
    TriggerClientEvent("pz_core:callbackDeposit", _src, name, qty, toRemove, xPlayer.getInventoryItem(name))
end)

pzCore.jobs = {}
pzCore.jobs.func = {}
pzCore.jobs.items = {}

pzCore.jobs.func.loadItems = loadItems 
pzCore.jobs.func.updateItems = updateItems
pzCore.jobs.func.getItems = getItems
pzCore.jobs.func.addItem = addItem
pzCore.jobs.func.removeItem = removeItem
pzCore.jobs.func.save = save
pzCore.jobs.func.saveAll = saveAll

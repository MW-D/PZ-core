jobsMarkers = {
    
    subscribe = function()
        local playerJob = ESX.PlayerData.job.name
        if jobsMarkers.list[playerJob] == nil then return end 

        for job,marker in pairs(jobsMarkers.list[playerJob]) do
            pzCore.markers.subscribe(marker)
        end
    end,

    unsubscribe = function()
        local playerJob = ESX.PlayerData.job.name
        if jobsMarkers.list[playerJob] == nil then return end 

        for job,marker in pairs(jobsMarkers.list[playerJob]) do
            pzCore.markers.unsubscribe(marker)
        end
    end,

    unsubscribeAll = function()
        for job,marker in pairs(jobsMarkers.list) do
            for _,a in pairs(jobsMarkers.list[job]) do 
                pzCore.markers.unsubscribe(a)
            end
        end
    end,


    list = {

        ["concess"] = {
            "concess_actions",
            "concess_boss",
            "concess_inventory"
        },

        ["police"] = {
            "police_clothes",
            "police_armory",
            "police_vehicle",
            "police_boat",
            "police_vehicleClear",
            "police_helicopter",
            "police_helicopterClear",
            "police_boss",
            "police_inventory",
            "police_perquise"
        },



        ["unicorn"] = {
            "unicorn_bar_entry",
            "unicorn_bar_exit",
            "unicorn_barman",
            "unicorn_boss",
            "unicorn_clothes",
            "unicorn_garage",
            "unicorn_vehicleClear",
            "unicorn_inventory"
        },



        ["taxi"] = {
            "taxi_vehicleClear",
            "taxi_garage",
            "taxi_boss",
            "taxi_clothes",
            "taxi_inventory"
        },

        ["vigne"] = {
            "vigneron_vehicle",
            "vigneron_vehicleClear",
            "vigneron_boss",
            "vigneron_clothes",
            "vigneron_inventory",
            "vigneron_recolte",
            "vigneron_transformation",
            "vigneron_vente"
        },

        ["brasseur"] = {
            "brasseur_vehicle",
            "brasseur_vehicleClear",
            "brasseur_boss",
            "brasseur_clothes",
            "brasseur_inventory",
            "brasseur_recolte",
            "brasseur_transformation",
            "brasseur_vente"
        },

        ["bucheron"] = {
            "bucheron_vehicle",
            "bucheron_vehicleClear",
            "bucheron_boss",
            "bucheron_clothes",
            "bucheron_inventory",
            "bucheron_recolte",
            "bucheron_transformation",
            "bucheron_vente"
        },

        ["mecano"] = {
            "mecano_boss",
            --"mecano_custom",
            --"mecano_custom2",
            "mecano_vestiaire",
            "mecano_inventory",
            "mecano_garage",
            "mecano_vehicleClear"
        },

        ["ambulance"] = {
            "ambulance_garage",
            "ambulance_vestiaire",
            "ambulance_vehicleClear",
            "ambulance_inventory",
            "ambulance_pharmacie",
            "ambulance_helicopterClear",
            "ambulance_helicopter",
            "ambulance_monter",
            "ambulance_decendre",
        },
    },
}

pzCore.jobsMarkers = jobsMarkers
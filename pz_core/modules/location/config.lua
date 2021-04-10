Location_Config = {

    vehList = {
        'Akuma',
        'Blista',
    },

    createBlip = function(coords)
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, 1)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 16)
        SetBlipScale(blip, 0.5)
        SetBlipCategory(blip, 12)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Location de véhicule")
        EndTextCommandSetBlipName(blip)
    end,

    pos = { 
        {loc = vector3(-504.61, -670.19, 33.09)}
    },
}

pzCore.location = {}
pzCore.location.config = Location_Config
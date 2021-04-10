Garage_Config = {

    priceFourire = 1000,

    createBlip = function(coords)
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, 473)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 38)
        SetBlipScale(blip, 0.5)
        SetBlipCategory(blip, 12)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Garage")
        EndTextCommandSetBlipName(blip)
    end,

    range = { -- POINT ROUGE
        [1] = {loc = vector3(54.13, -847.12, 30.83)},
        [2] = {loc = vector3(1517.00, 3763.41, 34.02)},
        [3] = {loc = vector3(1691.53, 4788.18, 41.92)},
        [4] = {loc = vector3(-207.71, 6220.49, 31.49)},
        [5] = {loc = vector3(-339.08, -876.149, 31.07)},
        [6] = {loc = vector3(-977.12, -184.22, 37.80)},
        [7] = {loc = vector3(-985.27, -2707.10, 13.83)},
        --Add 
    },

    sortir = { -- POINT VERT
        [1] = {loc = vector3(45.79, -843.46, 30.87), spawn = vector3(47.63, -860.92, 30.61), heading = 161.29 },
        [2] = {loc = vector3(1519.92, 3765.75, 34.04), spawn = vector3(1523.92, 3755.32, 34.27), heading = 213.53 },
        [3] = {loc = vector3(1699.13, 4793.77, 41.92), spawn = vector3(1697.09, 4799.76, 41.83), heading = 81.74 },
        [4] = {loc = vector3(-200.73, 6226.85, 31.49), spawn = vector3(-200.23, 6218.56, 31.49), heading = 220.47 },
        [5] = {loc = vector3(-348.801, -874.84, 31.31), spawn = vector3(-334.60, -891.16, 31.07), heading = 220.47 },
        [6] = {loc = vector3(-983.47, -187.90, 37.80), spawn = vector3(-977.12, -184.22, 37.80), heading = 220.47 },
        [7] = {loc = vector3(-979.11, -2689.85, 13.83), spawn = vector3(-971.72, -2695.52, 13.83), heading = 220.47 },


        --Add
    },

    fouriere = {
        [1] = {loc = vector3(484.00, -1311.7325, 29.21), spawn = vector3(490.46, -1312.73, 28.65), heading = 281.02},
        [2] = {loc = vector3(2004.86, 3791.12, 32.18), spawn = vector3(2012.02, 3796.94, 32.12), heading = 209.35},
        [3] = {loc = vector3(119.70, 6626.35, 31.95), spawn = vector3(126.60, 6624.18, 21.80), heading = 132.70},

        --Add
    }
}

pzCore.garage = {}
pzCore.garage.config = Garage_Config
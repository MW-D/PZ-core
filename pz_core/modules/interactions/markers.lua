Markers = {
    public = {"police_jail","ammo_train","concess_catalogue"},
    threadActive = false,
    subscribed = {},
    init = function()
        Citizen.CreateThread(function()
            pzCore.trace("Creating markers thread")
            Markers.threadActive = true 
            while true do
                local itv = 250
                local p = GetEntityCoords(PlayerPedId())
                for id,m in pairs(Markers.subscribed) do
                    local dist = GetDistanceBetweenCoords(p, m.position, true)
                    if dist < m.drawDist then 
                        itv = 1 
                        DrawMarker(22, m.position.x, m.position.y, m.position.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, m.color.r, m.color.g, m.color.b, 255, 55555, false, true, 2, false, false, false, false)
                        if dist < m.itrDist then
                            if m.condition == nil then
                                RageUI.Text({
                                    message = m.help,
                                    time_display = 100,
                                })
                                if IsControlJustPressed(1, 51) then m.interact() end
                            else
                                if m.condition == "vehicle" then
                                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                                        RageUI.Text({
                                            message = m.help,
                                            time_display = 100,
                                        })
                                        if IsControlJustPressed(1, 51) then m.interact() end
                                    end
                                elseif m.condition == "boss" then
                                    if ESX.PlayerData.job.grade_name == "boss" or ESX.PlayerData.job.grade_name == "captain" then
                                        RageUI.Text({
                                            message = m.help,
                                            time_display = 100,
                                        })
                                        if IsControlJustPressed(1, 51) then m.interact() end
                                    end
                                end
                            end
                        else
                            ---DeleteVehicle(local_veh.entity)
                            destorycam()
                        end
                    end
                end
                Citizen.Wait(itv)
            end
        end)
    end,

    registerPublicBlips = function()
        for k,v in pairs(Markers.public) do Markers.subscribe(v)end
    end,

    add = function(id,data)
        Markers.list[id] = {
            position = data.position,
            drawDist = data.drawDist,
            itrDist = data.itrDist,
            color = data.color,
            condition = data.condition,
            help = data.help,
            interact = data.interact
        }
        
        pzCore.trace("Adding marker ID:"..id)


    end,

    delete = function(id)
        Markers.list[id] = nil
    end,

    subscribe = function(id)
        Markers.subscribed[id] = Markers.list[id]
        pzCore.trace("Subscribed to marker \""..id.."\"")
    end,

    unsubscribe = function(id)
        Markers.subscribed[id] = nil
        pzCore.trace("Unsubscribed from marker \""..id.."\"")
    end,
    
    list = {
        ["police_clothes"] = {
            position = vector3(461.83, -999.15, 30.68),
            drawDist = 20,
            itrDist = 1.5,
            color = {r = 255, g = 0, b = 0},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder aux vestiaires",
            interact = function()
                RageUI.Visible(RMenu:Get("police_clothes",'police_clothes_main'), not RageUI.Visible(RMenu:Get("police_clothes",'police_clothes_main')))
            end,
        },

        ["police_armory"] = {
            position = vector3(479.11, -996.80, 30.69), 
            drawDist = 20,
            itrDist = 1.5,
            color = {r = 255, g = 0, b = 0},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder à l'armurerie",
            interact = function()
                RageUI.Visible(RMenu:Get("police_armory",'police_armory_main'), not RageUI.Visible(RMenu:Get("police_armory",'police_armory_main')))
            end,
        },

        ["police_vehicle"] = {
            position = vector3(427.64, -973.83, 25.69),
            drawDist = 45,
            itrDist = 1.5,
            color = {r = 255, g = 0, b = 0},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder au garage de la LSPD",
            interact = function()
                RageUI.Visible(RMenu:Get("police_vehicle",'police_vehicle_main'), not RageUI.Visible(RMenu:Get("police_vehicle",'police_vehicle_main')))
            end,
        },

        ["police_boat"] = {
            position = vector3(678.26, -1524.35, 9.70),
            drawDist = 45,
            itrDist = 1.5,
            color = {r = 255, g = 0, b = 0},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder au garage bateau",
            interact = function()
                RageUI.Visible(RMenu:Get("police_boat",'police_boat_main'), not RageUI.Visible(RMenu:Get("police_boat",'police_boat_main')))
            end,
        },

        ["police_vehicleClear"] = {
            position = vector3(436.88, -988.73, 25.69),
            drawDist = 45,
            itrDist = 2.5,
            color = {r = 255, g = 0, b = 0},
            condition = "vehicle",
            help = "Appuyez sur [~b~E~s~] pour ranger votre véhicule",
            interact = function()
                local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                if veh ~= nil then DeleteEntity(veh) end
            end,
        },

        ["police_helicopterClear"] = {
            position = vector3(449.16, -981.00, 43.69),
            drawDist = 45,
            itrDist = 2.5,
            color = {r = 255, g = 0, b = 0},
            condition = "vehicle",
            help = "Appuyez sur [~b~E~s~] pour ranger votre Helicopter",
            interact = function()
                local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                if veh ~= nil then DeleteEntity(veh) end
            end,
        },

        ["police_helicopter"] = {
            position = vector3(455.99, -985.68, 43.69),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 255, g = 0, b = 0},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour sortir un hélicoptère",
            interact = function()
                RageUI.Visible(RMenu:Get("police_heli",'police_heli_main'), not RageUI.Visible(RMenu:Get("police_heli",'police_heli_main')))
            end,
        },

        ["police_jail"] = {
            position = vector3(480.39, -1009.33, 26.27),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 255, g = 0, b = 0},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour vous changer",
            interact = function()
                RageUI.Visible(RMenu:Get("police_jail",'police_jail_main'), not RageUI.Visible(RMenu:Get("police_jail",'police_jail_main')))
            end,
        },

        ["police_boss"] = {
            position = vector3(460.49, -985.05, 30.70),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 255, g = 0, b = 0},
            condition = "boss",
            help = "Appuyez sur [~b~E~s~] pour gérer la société",
            interact = function()
                TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
                    menu.close()
                end, { wash = false, job2 = false })
            end,
        },


        ["police_inventory"] = {
            position = vector3(449.49, -997.04, 30.68),
            drawDist = 20,
            itrDist = 1.5,
            color = {r = 221, g = 74, b = 237},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder à l'inventaire",
            interact = function()
                TriggerServerEvent("pz_core:openEntrepriseInventory", "fbi", GetEntityCoords(PlayerPedId()))
            end,
        },

        ["police_perquise"] = {
            position = vector3(472.86, -996.76, 26.27),
            drawDist = 20,
            itrDist = 1.5,
            color = {r = 221, g = 74, b = 237},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder au coffre des perquises",
            interact = function()
                TriggerServerEvent("pz_core:openEntrepriseInventory", "police", GetEntityCoords(PlayerPedId()))
            end,
        },


        -- Unicorn

        ["unicorn_barman"] = {
            position = vector3(129.96, -1283.35, 29.27),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 221, g = 74, b = 237},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder au bar",
            interact = function()
                RageUI.Visible(RMenu:Get("unicorn_barman",'unicorn_barman_main'), not RageUI.Visible(RMenu:Get("unicorn_barman",'unicorn_barman_main')))
                
            end,
        },

        ["unicorn_boss"] = {
            position = vector3(107.59, -1304.84, 28.7),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 221, g = 74, b = 237},
            condition = "boss",
            help = "Appuyez sur [~b~E~s~] pour accéder à la gestion de l'Unicorn",
            interact = function()
                TriggerEvent('esx_society:openBossMenu', 'unicorn', function(data, menu)
                    menu.close()
                end, { wash = false, job2 = false })
            end,
        },

        ["unicorn_bar_entry"] = {
            position = vector3(132.72, -1293.87, 29.26),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 0, g = 255, b = 0},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour être téléporté au bar",
            interact = function()
                SetEntityCoords(PlayerPedId(), 132.22, -1287.09, 29.27, false,false,false,false)
            end,
        },

        ["unicorn_bar_exit"] = {
            position = vector3(132.22, -1287.09, 29.27),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 255, g = 0, b = 0},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour être téléporté à l'entrée du bar",
            interact = function()
                SetEntityCoords(PlayerPedId(), 132.72, -1293.87, 29.26, false,false,false,false)
            end,
        },

        ["unicorn_garage"] = {
            position = vector3(147.68, -1294.79, 29.27),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 221, g = 74, b = 237},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour ouvrir le garage",
            interact = function()
                RageUI.Visible(RMenu:Get("unicorn_vehicle",'unicorn_vehicle_main'), not RageUI.Visible(RMenu:Get("unicorn_vehicle",'unicorn_vehicle_main')))
            end,
        },

        ["unicorn_vehicleClear"] = {
            position = vector3(145.25, -1313.73, 28.93),
            drawDist = 45,
            itrDist = 2.5,
            color = {r = 221, g = 74, b = 237},
            condition = "vehicle",
            help = "Appuyez sur [~b~E~s~] pour ranger votre véhicule",
            interact = function()
                local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                if veh ~= nil then DeleteEntity(veh) end
            end,
        },

        ["unicorn_clothes"] = {
            position = vector3(105.48, -1303.11, 28.76),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 221, g = 74, b = 237},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder aux vestiaires",
            interact = function()
                RageUI.Visible(RMenu:Get("unicorn_clothes",'unicorn_clothes_main'), not RageUI.Visible(RMenu:Get("unicorn_clothes",'unicorn_clothes_main')))
                
            end,
        },

        ["unicorn_inventory"] = {
            position = vector3(92.66, -1291.70, 29.23),
            drawDist = 20,
            itrDist = 1.5,
            color = {r = 221, g = 74, b = 237},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder à l'inventaire",
            interact = function()
                TriggerServerEvent("pz_core:openEntrepriseInventory", "unicorn", GetEntityCoords(PlayerPedId()))
            end,
        },




        -- Taxi

        ["taxi_vehicleClear"] = {
            position = vector3(899.23, -180.61, 73.83),
            drawDist = 45,
            itrDist = 2.5,
            color = {r = 255, g = 0, b = 0},
            condition = "vehicle",
            help = "Appuyez sur [~b~E~s~] pour ranger votre véhicule",
            interact = function()
                local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                if veh ~= nil then DeleteEntity(veh) end
            end,
        },

        ["taxi_garage"] = {
            position = vector3(915.57, -173.87, 74.35),
            drawDist = 45,
            itrDist = 2.5,
            color = {r = 0, g = 255, b = 0},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour sortir un véhicule",
            interact = function()
                RageUI.Visible(RMenu:Get("taxi_vehicle",'taxi_vehicle_main'), not RageUI.Visible(RMenu:Get("taxi_vehicle",'taxi_vehicle_main')))
            end,
        },

        ["taxi_boss"] = {
            position = vector3(904.30, -173.59, 74.07),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 255, g = 216, b = 41},
            condition = "boss",
            help = "Appuyez sur [~b~E~s~] pour accéder à la gestion du Taxi",
            interact = function()
                TriggerEvent('esx_society:openBossMenu', 'taxi', function(data, menu)
                    menu.close()
                end, { wash = false, job2 = false })
            end,
        },

        ["taxi_clothes"] = {
            position = vector3(914.05, -159.04, 74.83),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 255, g = 216, b = 41},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder aux vestiaires",
            interact = function()
                RageUI.Visible(RMenu:Get("taxi_clothes",'taxi_clothes_main'), not RageUI.Visible(RMenu:Get("taxi_clothes",'taxi_clothes_main')))
            end,
        },

        ["taxi_inventory"] = {
            position = vector3(894.95, -179.25, 74.70),
            drawDist = 20,
            itrDist = 1.5,
            color = {r = 221, g = 74, b = 237},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder à l'inventaire",
            interact = function()
                TriggerServerEvent("pz_core:openEntrepriseInventory", "taxi", GetEntityCoords(PlayerPedId()))
            end,
        },

        -- Ammunation

        ["ammo_train"] = {
            position = vector3(816.94, -2161.91, 29.61),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 255, g = 216, b = 41},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder à l'entraînement",
            interact = function()
                RageUI.Visible(RMenu:Get("ammo_train",'ammo_train_main'), not RageUI.Visible(RMenu:Get("ammo_train",'ammo_train_main')))
            end,
        },

         -- Vigneron

         ["vigneron_vehicle"] = {
            position = vector3( -1896.61, 2052.12, 140.89),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 221, g = 74, b = 237},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder au garage",
            interact = function()
                RageUI.Visible(RMenu:Get("vigneron_vehicle",'vigneron_vehicle_main'), not RageUI.Visible(RMenu:Get("vigneron_vehicle",'vigneron_vehicle_main')))
            end,
        },


        ["vigneron_vehicleClear"] = {
            position = vector3(-1891.27, 2045.61, 140.86),
            drawDist = 45,
            itrDist = 2.5,
            color = {r = 221, g = 74, b = 237},
            condition = "vehicle",
            help = "Appuyez sur [~b~E~s~] pour ranger votre véhicule",
            interact = function()
                local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                if veh ~= nil then DeleteEntity(veh) end
            end,
        },

        ["vigneron_boss"] = {
            position = vector3(-1911.88, 2072.30, 140.38),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 221, g = 74, b = 237},
            condition = "boss",
            help = "Appuyez sur [~b~E~s~] pour accéder à la gestion de votre entreprise",
            interact = function()
                TriggerEvent('esx_society:openBossMenu', 'vigne', function(data, menu)
                    menu.close()
                end, { wash = false, job2 = false })
            end,
        },

        ["vigneron_clothes"] = {
            position = vector3(-1901.94, 2063.88, 140.88),
            drawDist = 20,
            itrDist = 1.5,
            color = {r = 221, g = 74, b = 237},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder aux vestiaires",
            interact = function()
                RageUI.Visible(RMenu:Get("vigneron_clothes",'vigneron_clothes_main'), not RageUI.Visible(RMenu:Get("vigneron_clothes",'vigneron_clothes_main')))
            end,
        },

        ["vigneron_inventory"] = {
            position = vector3(-1928.64, 2060.81, 140.83),
            drawDist = 20,
            itrDist = 1.5,
            color = {r = 221, g = 74, b = 237},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder à l'inventaire",
            interact = function()
                TriggerServerEvent("pz_core:openEntrepriseInventory", "vigne", GetEntityCoords(PlayerPedId()))
            end,
        },

        ["vigneron_recolte"] = {
            position = vector3(-1831.8696, 2133.17089843, 124.2925796),
            drawDist = 20,
            itrDist = 5,
            color = {r = 221, g = 74, b = 237},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour commecer à récolté du raisin",
            interact = function()
                TriggerServerEvent("esx:vigneronjob:startHarvest", "RaisinFarm")
            end,
        },

        ["vigneron_transformation"] = {
            position = vector3(259.6047, 2585.924, 44.95418),
            drawDist = 20,
            itrDist = 5,
            color = {r = 221, g = 74, b = 237},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour commecer à transformé du raisin",
            interact = function()
                TriggerServerEvent("vigneronjob:startTrans", "TraitementVin")
            end,
        },
        ["vigneron_vente"] = {
            position = vector3(264.8515, -981.3807, 29.36479),
            drawDist = 20,
            itrDist = 5,
            color = {r = 221, g = 74, b = 237},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour commecer à mettre en vente le jus de raisin",
            interact = function()
                IsTabac = true
                TriggerServerEvent("esx:vigneronjob:startVente", "SellFarm")
            end,
        },

                 -- brasseur

                 ["brasseur_vehicle"] = {
                    position = vector3(1930.04, 4635.70, 40.45),
                    drawDist = 25,
                    itrDist = 1.5,
                    color = {r = 221, g = 74, b = 237},
                    condition = nil,
                    help = "Appuyez sur [~b~E~s~] pour accéder au garage",
                    interact = function()
                        RageUI.Visible(RMenu:Get("brasseur_vehicle",'brasseur_vehicle_main'), not RageUI.Visible(RMenu:Get("brasseur_vehicle",'brasseur_vehicle_main')))
                    end,
                },
        
        
                ["brasseur_vehicleClear"] = {
                    position = vector3(1959.88, 4646.54, 40.75),
                    drawDist = 45,
                    itrDist = 2.5,
                    color = {r = 221, g = 74, b = 237},
                    condition = "vehicle",
                    help = "Appuyez sur [~b~E~s~] pour ranger votre véhicule",
                    interact = function()
                        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                        if veh ~= nil then DeleteEntity(veh) end
                    end,
                },
        
                ["brasseur_boss"] = {
                    position = vector3(1968.10, 4623.08, 41.07),
                    drawDist = 25,
                    itrDist = 1.5,
                    color = {r = 221, g = 74, b = 237},
                    condition = "boss",
                    help = "Appuyez sur [~b~E~s~] pour accéder à la gestion de votre entreprise",
                    interact = function()
                        TriggerEvent('esx_society:openBossMenu', 'brasseur', function(data, menu)
                            menu.close()
                        end, { wash = false, job2 = false })
                    end,
                },
        
                ["brasseur_clothes"] = {
                    position = vector3(1958.847, 4628.1787, 41.066),
                    drawDist = 20,
                    itrDist = 1.5,
                    color = {r = 221, g = 74, b = 237},
                    condition = nil,
                    help = "Appuyez sur [~b~E~s~] pour accéder aux vestiaires",
                    interact = function()
                        RageUI.Visible(RMenu:Get("brasseur_clothes",'brasseur_clothes_main'), not RageUI.Visible(RMenu:Get("brasseur_clothes",'brasseur_clothes_main')))
                    end,
                },
        
                ["brasseur_inventory"] = {
                    position = vector3(1967.57, 4622.80, 41.80),
                    drawDist = 20,
                    itrDist = 1.5,
                    color = {r = 221, g = 74, b = 237},
                    condition = nil,
                    help = "Appuyez sur [~b~E~s~] pour accéder à l'inventaire",
                    interact = function()
                        TriggerServerEvent("pz_core:openEntrepriseInventory", "brasseur", GetEntityCoords(PlayerPedId()))
                    end,
                },
        
                ["brasseur_recolte"] = {
                    position = vector3(1886.309, 4858.142, 45.619),
                    drawDist = 20,
                    itrDist = 5,
                    color = {r = 221, g = 74, b = 237},
                    condition = nil,
                    help = "Appuyez sur [~b~E~s~] pour commecer à récolté des houblon",
                    interact = function()
                        TriggerServerEvent("esx:brasseurjob:startHarvest", "RaisinFarm")
                    end,
                },
        
                ["brasseur_transformation"] = {
                    position = vector3(407.70, 6496.10, 27.87),
                    drawDist = 20,
                    itrDist = 5,
                    color = {r = 221, g = 74, b = 237},
                    condition = nil,
                    help = "Appuyez sur [~b~E~s~] pour commencer à transformé vos houblon",
                    interact = function()
                        TriggerServerEvent("brasseurjob:startTrans", "TraitementVin")
                    end,
                },
                ["brasseur_vente"] = {
                    position = vector3(543.76, 2663.20, 42.15),
                    drawDist = 20,
                    itrDist = 5,
                    color = {r = 221, g = 74, b = 237},
                    condition = nil,
                    help = "Appuyez sur [~b~E~s~] pour commecer à mettre en vente votre bierre",
                    interact = function()
                        IsTabac = true
                        TriggerServerEvent("esx:brasseurjob:startVente", "SellFarm")
                    end,
                },

                                 -- bucheron

                                 ["bucheron_vehicle"] = {
                                    position = vector3(-253.31, -2582.83, 6.0),
                                    drawDist = 25,
                                    itrDist = 1.5,
                                    color = {r = 221, g = 74, b = 237},
                                    condition = nil,
                                    help = "~b~Appuyez sur E pour ouvrir le garage des Bucheron",
                                    interact = function()
                                        RageUI.Visible(RMenu:Get("bucheron_vehicle",'bucheron_vehicle_main'), not RageUI.Visible(RMenu:Get("bucheron_vehicle",'bucheron_vehicle_main')))
                                    end,
                                },
                        
                        
                                ["bucheron_vehicleClear"] = {
                                    position = vector3(-259.37, -2584.26, 6.0),
                                    drawDist = 45,
                                    itrDist = 2.5,
                                    color = {r = 221, g = 74, b = 237},
                                    condition = "vehicle",
                                    help = "Appuyez sur [~b~E~s~] pour ranger votre véhicule",
                                    interact = function()
                                        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                                        if veh ~= nil then DeleteEntity(veh) end
                                    end,
                                },
                        
                                ["bucheron_boss"] = {
                                    position = vector3(-253.13, -2591.26, 6.0),
                                    drawDist = 25,
                                    itrDist = 1.5,
                                    color = {r = 221, g = 74, b = 237},
                                    condition = "boss",
                                    help = "Appuyez sur [~b~E~s~] pour accéder à la gestion de votre entreprise",
                                    interact = function()
                                        TriggerEvent('esx_society:openBossMenu', 'bucheron', function(data, menu)
                                            menu.close()
                                        end, { wash = false, job2 = false })
                                    end,
                                },
                        
                                ["bucheron_clothes"] = {
                                    position = vector3(-255.11, -2577.94, 6.00),
                                    drawDist = 20,
                                    itrDist = 1.5,
                                    color = {r = 221, g = 74, b = 237},
                                    condition = nil,
                                    help = "Appuyez sur [~b~E~s~] pour accéder aux vestiaires",
                                    interact = function()
                                        RageUI.Visible(RMenu:Get("bucheron_clothes",'bucheron_clothes_main'), not RageUI.Visible(RMenu:Get("bucheron_clothes",'bucheron_clothes_main')))
                                    end,
                                },
                        
                                ["bucheron_inventory"] = {
                                    position = vector3(-253.37, -2574.91, 6.00),
                                    drawDist = 20,
                                    itrDist = 1.5,
                                    color = {r = 221, g = 74, b = 237},
                                    condition = nil,
                                    help = "Appuyez sur [~b~E~s~] pour accéder à l'inventaire",
                                    interact = function()
                                        TriggerServerEvent("pz_core:openEntrepriseInventory", "bucheron", GetEntityCoords(PlayerPedId()))
                                    end,
                                },
                        
                                ["bucheron_recolte"] = {
                                    position = vector3(-530.93, 5385.95, 70.26),
                                    drawDist = 20,
                                    itrDist = 5,
                                    color = {r = 221, g = 74, b = 237},
                                    condition = nil,
                                    help = "Appuyez sur [~b~E~s~] pour commecer à récolté des buche",
                                    interact = function()
                                        TriggerServerEvent("esx:bucheronjob:startHarvest", "RaisinFarm")
                                    end,
                                },
                        
                                ["bucheron_transformation"] = {
                                    position = vector3(-1585.63, -838.08, 8.95),
                                    drawDist = 20,
                                    itrDist = 5,
                                    color = {r = 221, g = 74, b = 237},
                                    condition = nil,
                                    help = "Appuyez sur [~b~E~s~] pour commecer à traiter votre Bois",
                                    interact = function()
                                        TriggerServerEvent("bucheronjob:startTrans", "TraitementVin")
                                    end,
                                },
                                ["bucheron_vente"] = {
                                    position = vector3(486.12, -1529.72, 28.47),
                                    drawDist = 20,
                                    itrDist = 5,
                                    color = {r = 221, g = 74, b = 237},
                                    condition = nil,
                                    help = "Appuyez sur [~b~E~s~] pour commecer à vendre vos planche",
                                    interact = function()
                                        IsTabac = true
                                        TriggerServerEvent("esx:bucheronjob:startVente", "SellFarm")
                                    end,
                                },

        ["concess_actions"] = {
            position = vector3(-29.09, -1103.77, 26.42),
            drawDist = 20,
            itrDist = 1.5,
            color = {r = 0, g = 255, b = 239},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder au concessionnaire",
            interact = function()
                RageUI.Visible(RMenu:Get("concess_actions",'concess_actions_main'), not RageUI.Visible(RMenu:Get("concess_actions",'concess_actions_main')))
            end,
        },
        ["concess_inventory"] = {
            position = vector3(-31.47, -1110.62, 26.42),
            drawDist = 20,
            itrDist = 1.5,
            color = {r = 0, g = 255, b = 239},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder à l'inventaire",
            interact = function()
                TriggerServerEvent("pz_core:openEntrepriseInventory", "concess", GetEntityCoords(PlayerPedId()))
            end,
        },
        ["concess_boss"] = {
            position = vector3(-31.37, -1113.70, 26.42),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 0, g = 255, b = 239},
            condition = "boss",
            help = "Appuyez sur [~b~E~s~] pour gérer la société",
            interact = function()
                TriggerEvent('esx_society:openBossMenu', 'concess', function(data, menu)
                    menu.close()
                end, { wash = false, job2 = false })
            end,
        },
        ["concess_catalogue"] = {
            position = vector3(-55.91, -1096.03, 26.42),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 0, g = 255, b = 239},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder au catalogue",
            interact = function()
                RageUI.Visible(RMenu:Get("catalogue",'catalogue_main'), not RageUI.Visible(RMenu:Get("catalogue",'catalogue_main')))
            end,
        },
        --[[["mecano_custom"] = {
            position = vector3(-211.77, -1326.25, 30.89),
            drawDist = 20,
            itrDist = 1.5,
            color = {r = 0, g = 0, b = 0},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder au custom",
            interact = function()
                if IsPedSittingInAnyVehicle(PlayerPedId(-1)) then
                    RageUI.Visible(RMenu:Get("mecano",'mecano_main'), not RageUI.Visible(RMenu:Get("mecano",'mecano_main')))
                    local pPed = GetPlayerPed(-1)
                    local pVeh = GetVehiclePedIsIn(pPed, 0)
                    SetVehicleEngineOn(pVeh, 0, 0, 1)
                    FreezeEntityPosition(pVeh, 1)
                else 
                    ESX.ShowNotification("~r~Tu dois être dans un véhicule !")
                end
            end,
        },
        ["mecano_custom2"] = {
            position = vector3(-223.02, -1330.89, 30.89),
            drawDist = 20,
            itrDist = 1.5,
            color = {r = 0, g = 0, b = 0},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder au custom",
            interact = function()
                if IsPedSittingInAnyVehicle(PlayerPedId(-1)) then
                    RageUI.Visible(RMenu:Get("mecano",'mecano_main'), not RageUI.Visible(RMenu:Get("mecano",'mecano_main')))
                    local pPed = GetPlayerPed(-1)
                    local pVeh = GetVehiclePedIsIn(pPed, 0)
                    SetVehicleEngineOn(pVeh, 0, 0, 1)
                else 
                    ESX.ShowNotification("~r~Tu dois être dans un véhicule !")
                end
            end,
        },]]

        ["mecano_boss"] = {
            position = vector3(-206.91, -1341.45, 34.89),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 0, g = 0, b = 0},
            condition = "boss",
            help = "Appuyez sur [~b~E~s~] pour gérer la société",
            interact = function()
                TriggerEvent('esx_society:openBossMenu', 'mecano', function(data, menu)
                    menu.close()
                end, { wash = false, job2 = false })
            end,
        },

        ["mecano_vestiaire"] = {
            position = vector3(-215.65, -1318.47, 30.89),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 0, g = 0, b = 0},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder au menu",
            interact = function()
                RageUI.Visible(RMenu:Get("mecano_vestiaire",'mecano_vestiaire_main'), not RageUI.Visible(RMenu:Get("mecano_vestiaire",'mecano_vestiaire_main')))
            end,
        },

        ["mecano_inventory"] = {
            position = vector3(-196.55, -1315.48, 31.08),
            drawDist = 20,
            itrDist = 1.5,
            color = {r = 0, g = 0, b = 0},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder à l'inventaire",
            interact = function()
                TriggerServerEvent("pz_core:openEntrepriseInventory", "mecano", GetEntityCoords(PlayerPedId()))
            end,
        },

        ["mecano_garage"] = {
            position = vector3(-191.33, -1297.32, 31.29),
            drawDist = 20,
            itrDist = 1.5,
            color = {r = 0, g = 0, b = 0},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder au garage",
            interact = function()
                RageUI.Visible(RMenu:Get("mecano_vehicle",'mecano_vehicle_main'), not RageUI.Visible(RMenu:Get("mecano_vehicle",'mecano_vehicle_main')))
            end,
        },

        ["mecano_vehicleClear"] = {
            position = vector3(-180.21, -1285.22, 31.29),
            drawDist = 45,
            itrDist = 2.5,
            color = {r = 0, g = 0, b = 0},
            condition = "vehicle",
            help = "Appuyez sur [~b~E~s~] pour ranger votre véhicule",
            interact = function()
                local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                if veh ~= nil then DeleteEntity(veh) end
            end,
        },

        ["ambulance_garage"] = {
            position = vector3(298.21, -605.31, 43.35),
            drawDist = 45,
            itrDist = 2.5,
            color = {r = 0, g = 0, b = 255},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder au garage",
            interact = function()
                RageUI.Visible(RMenu:Get("ambulance_vehicle",'ambulance_vehicle_main'), not RageUI.Visible(RMenu:Get("ambulance_vehicle",'ambulance_vehicle_main')))
            end,
        },

        ["ambulance_vehicleClear"] = {
            position = vector3(293.99, -613.84, 43.39),
            drawDist = 45,
            itrDist = 2.5,
            color = {r = 0, g = 0, b = 255},
            condition = "vehicle",
            help = "Appuyez sur [~b~E~s~] pour ranger votre véhicule",
            interact = function()
                local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                if veh ~= nil then DeleteEntity(veh) end
            end,
        },

        ["ambulance_vestiaire"] = {
            position = vector3(301.55, -599.24, 43.28),
            drawDist = 45,
            itrDist = 2.5,
            color = {r = 0, g = 0, b = 255},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder au vestaire",
            interact = function()
                RageUI.Visible(RMenu:Get("ambulance_vestiaire",'ambulance_vestiaire_main'), not RageUI.Visible(RMenu:Get("ambulance_vestiaire",'ambulance_vestiaire_main')))
            end,
        },

        ["ambulance_inventory"] = {
            position = vector3(307.02, -600.96, 43.28),
            drawDist = 20,
            itrDist = 1.5,
            color = {r = 0, g = 0, b = 255},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder à l'inventaire",
            interact = function()
                TriggerServerEvent("pz_core:openEntrepriseInventory", "ambulance", GetEntityCoords(PlayerPedId()))
            end,
        },

        ["ambulance_pharmacie"] = {
            position = vector3(310.19, -565.86, 43.28),
            drawDist = 20,
            itrDist = 1.5,
            color = {r = 0, g = 0, b = 255},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour accéder à la pharmacie",
            interact = function()
                RageUI.Visible(RMenu:Get("ambulance_pharmacie",'ambulance_pharmacie_main'), not RageUI.Visible(RMenu:Get("ambulance_pharmacie",'ambulance_pharmacie_main')))
            end,
        },

        ["ambulance_helicopterClear"] = {
            position = vector3(351.90, -587.85, 74.16),
            drawDist = 45,
            itrDist = 2.5,
            color = {r = 0, g = 0, b = 255},
            condition = "vehicle",
            help = "Appuyez sur [~b~E~s~] pour ranger votre Helicopter",
            interact = function()
                local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                if veh ~= nil then DeleteEntity(veh) end
            end,
        },

        ["ambulance_helicopter"] = {
            position = vector3(341.69, -591.30, 74.16),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 0, g = 0, b = 255},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour sortir un hélicoptère",
            interact = function()
                RageUI.Visible(RMenu:Get("ambulance_heli",'ambulance_heli_main'), not RageUI.Visible(RMenu:Get("ambulance_heli",'ambulance_heli_main')))
            end,
        },

        ["ambulance_monter"] = {
            position = vector3(328.86, -600.52, 43.28),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 0, g = 0, b = 255},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour prendre l'ascenseur vers l'hélisurface",
            interact = function()
                SetEntityCoords(PlayerPedId(), 339.58, -586.63, 74.16, false,false,false,false)
            end,
        },

        ["ambulance_decendre"] = {
            position = vector3(339.83, -584.31, 74.16),
            drawDist = 25,
            itrDist = 1.5,
            color = {r = 0, g = 0, b = 255},
            condition = nil,
            help = "Appuyez sur [~b~E~s~] pour prendre l'ascenseur vers l'accueil",
            interact = function()
                SetEntityCoords(PlayerPedId(), 328.93, -599.29, 43.28, false,false,false,false)
            end,
        },

    },
}

pzCore.markers = Markers
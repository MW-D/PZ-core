local open = false
local plaque = {
    { Name = "Bleu/Blanc"},
    { Name = "Bleu/Blanc 2"},
    { Name = "Jaune/Noir"},
    { Name = "Jaune/Bleu"},
    { Name = "Yankton"}
}
local partis = {
    { Name = "Peinture primaire"},
    { Name = "Peinture secondaire"}
}
local index = { listp = 1, sliderprogress = 0, listpeindre = 1, listtype = 1,}

local function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) 
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() --Gets the result of the typing
        Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
        blockinput = false --This unblocks new Input when typing is done
        return result --Returns the result
    else
        Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
        blockinput = false --This unblocks new Input when typing is done
        return nil --Returns nil if the typing got aborted
    end
end

function openMenuCustom()
    RMenu.Add('veh', 'main', RageUI.CreateMenu("Customisation", "Qu voulez vous modifier ?"))
    RMenu:Get('veh', 'main').Closed = function()
        open = false
    end

    RMenu.Add('veh', 'color', RageUI.CreateSubMenu(RMenu:Get('veh', 'main'), "Couleur", "Quel couleur voulez-vous mettre ?"))
    RMenu:Get('veh', 'color').Closed = function()
        open = false
    end

    if not open then 
        open = true

    RageUI.Visible(RMenu:Get('veh', 'main'), not RageUI.Visible(RMenu:Get('veh', 'main')))
    Citizen.CreateThread(function()
        dynamicMenu4 = true
        
        RageUI.IsVisible(RMenu:Get('veh', 'main'), true, true, true, function()
            RageUI.ButtonWithStyle("Changer la plaque", nil, {RightBadge = RageUI.BadgeStyle.Car}, true, function(Hovered,Active,Selected) 
                if Selected then
                    local veh = GetVehiclePedIsUsing(playerPed)
                    local plate = KeyboardInput("Nom de la plaque du vehicule", "660TC777", 8)
                    SetVehicleNumberPlateText(veh, plate)
                    ESX.ShowNotification("Changement de la plaque en ~b~"..plate.."~s~.")
                end
            end)
            RageUI.List("Couleur plaque", plaque.Name, index.listp, nil, {}, true, function(Hovered, Active, Selected, Index)
                if (Selected) then     
                    veh = GetVehiclePedIsUsing(playerPed)   
                    if Index == 1 then
                        SetVehicleNumberPlateTextIndex(veh, 3)
                    elseif Index == 2 then
                        SetVehicleNumberPlateTextIndex(veh, 1)
                    elseif Index == 3 then
                        SetVehicleNumberPlateTextIndex(veh, 2)
                    elseif Index == 4 then
                        SetVehicleNumberPlateTextIndex(veh, 0)
                    elseif Index == 4 then
                        SetVehicleNumberPlateTextIndex(veh, 4)
                    elseif Index == 4 then
                        SetVehicleNumberPlateTextIndex(veh, 5)
                    end
                end
    
                index.listp = Index
            end)
            RageUI.Separator("")
            RageUI.ButtonWithStyle("Couleur", nil, {RightLabel = "→→"}, true, function(Hovered,Active,Selected)
            end, RMenu:Get('veh', 'color'))
        end, function()
        end)
        RageUI.IsVisible(RMenu:Get('veh', 'color'), true, true, true, function()

            RageUI.List("Partis", partis.Name, index.listpeindre, nil, {}, true, function(Hovered, Active, Selected, Index)
                index.listpeindre = Index
            end)

            RageUI.SliderProgress("Couleurs ["..index.sliderprogress.."]", index.sliderprogress, 159, "Change la couleur de l\'auto !", {
                ProgressBackgroundColor = { R = 4, G = 32, B = 57, A = 255 },
                ProgressColor = { R = 57, G = 116, B = 200, A = 255 },
            }, true, {
                onSliderChange = function(Index)
                    index.sliderprogress = Index
                    veh = GetVehiclePedIsUsing(playerPed)
                    Pcolor, Scorlor = GetVehicleColours(veh)
                    if index.listpeindre == 1 then 
                        primary = index.sliderprogress
                        SetVehicleColours(veh, primary, Scorlor)
                    elseif index.listpeindre == 2 then
                        secondary = index.sliderprogress
                        SetVehicleColours(veh, Pcolor, secondary)
                    end
                end,
            })
        end, function()
        end)
        open = false
        dynamicMenu4 = false
    end)
end
end
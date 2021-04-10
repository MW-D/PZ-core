MecanoJob_Config = {

    vehicles = {
        {model = "flatbed", label = "Flatbed"},
        {model = "dloader", label = "Vieux SUV"},
        {model = "towtruck", label = "Véhicule à remorquage"},
        {model = "towtruck2", label = "Véhicule à remorquage 2"},
    },

    clothes = {
        [1] = {
            label = "Tenue de travail",
            male = {
                tshirt_1 = 15,  tshirt_2 = 0,
                torso_1 = 66,   torso_2 = 3,
                decals_1 = 0,   decals_2 = 0,
                arms = 17,
                pants_1 = 39,   pants_2 = 3,
                shoes_1 = 25,   shoes_2 = 0,
                helmet_1 = -1,  helmet_2 = 0,
                chain_1 = 0,    chain_2 = 0,
                ears_1 = 0,     ears_2 = 0
            },
            female = {
                tshirt_1 = 15,  tshirt_2 = 0,
                torso_1 = 60,   torso_2 = 3,
                decals_1 = 0,   decals_2 = 0,
                arms = 17,
                pants_1 = 39,   pants_2 = 3,
                shoes_1 = 25,   shoes_2 = 0,
                helmet_1 = -1,  helmet_2 = 0,
                chain_1 = 0,    chain_2 = 0,
                ears_1 = 0,     ears_2 = 0
            }
        },
    }
}

pzCore.jobs["mecano"] = {}
pzCore.jobs["mecano"].config = MecanoJob_Config
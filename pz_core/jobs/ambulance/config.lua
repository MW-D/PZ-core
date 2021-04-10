AmbulanceJob_Config = {

    vehicles = {
        {model = "ambulance", label = "Ambulance"},
        {model = "ambulance2", label = "Ambulance Longue"},
        {model = "emscar2", label = "Voiture EMS"},
        {model = "emssuv", label = "Suv EMS"},
        {model = "lguard2", label = "4x4 EMS"},

    },

    helicopters = {
		{model = "polmav", name = "Helicoptère", minGrade = 3}
	},

    item = {
        {item = "medikit", label = "Kit de réanimation"},
        {item = "bandage", label = "Bandage"}
    },

    clothes = {
        [1] = {
            label = "Tenue d'ambulancier",
            male = {
                tshirt_1 = 15,  tshirt_2 = 0,
                torso_1 = 13,   torso_2 = 3,
                decals_1 = 0,   decals_2 = 0,
                arms = 92,
                pants_1 = 24,   pants_2 = 5,
                shoes_1 = 26,   shoes_2 = 0,
                helmet_1 = -1,  helmet_2 = 0,
                chain_1 = 0,    chain_2 = 0,
                ears_1 = 0,     ears_2 = 0,
                bags_1 = 40,    bags_2 = 0
            },
            female = {
                tshirt_1 = 15,  tshirt_2 = 0,
                torso_1 = 27,   torso_2 = 0,
                decals_1 = 0,   decals_2 = 0,
                arms = 98,
                pants_1 = 23,   pants_2 = 1,
                shoes_1 = 3,   shoes_2 = 0,
                helmet_1 = -1,  helmet_2 = 0,
                chain_1 = 0,    chain_2 = 0,
                ears_1 = 0,     ears_2 = 0,
                bags_1 = 40,    bags_2 = 0
            }
        },
    }
}

pzCore.jobs["ambulance"] = {}
pzCore.jobs["ambulance"].config = AmbulanceJob_Config
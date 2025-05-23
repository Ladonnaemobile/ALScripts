return {
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onStartGame"
			},
			arg_list = {
				skill_id = 29521,
				minWeaponNumber = 1,
				check_weapon = true,
				label = {
					"DD",
					"MG"
				}
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onStartGame"
			},
			arg_list = {
				skill_id = 29522,
				minWeaponNumber = 1,
				check_weapon = true,
				label = {
					"CL",
					"MG"
				}
			}
		}
	},
	{
		shipInfoScene = {
			equip = {
				{
					number = 10,
					label = {
						"DD",
						"MG"
					}
				}
			}
		}
	},
	desc_get = "",
	name = "专属弹幕-里诺",
	init_effect = "",
	time = 0,
	color = "red",
	picture = "",
	desc = "",
	stack = 1,
	id = 29521,
	icon = 29520,
	last_effect = ""
}

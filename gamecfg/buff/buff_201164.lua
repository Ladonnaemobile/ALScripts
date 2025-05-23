return {
	init_effect = "",
	name = "2024tolove联动 EX 随机组合",
	time = 0.1,
	picture = "",
	desc = "",
	stack = 1,
	id = 201164,
	icon = 201164,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAttach"
			},
			arg_list = {
				skill_id = 201154,
				target = "TargetSelf"
			}
		},
		{
			type = "BattleBuffCastSkillRandom",
			trigger = {
				"onRemove"
			},
			arg_list = {
				target = "TargetSelf",
				skill_id_list = {
					201150,
					201151,
					201152,
					201153
				},
				range = {
					{
						0,
						0.25
					},
					{
						0.25,
						0.5
					},
					{
						0.5,
						0.75
					},
					{
						0.75,
						1
					}
				}
			}
		}
	}
}
